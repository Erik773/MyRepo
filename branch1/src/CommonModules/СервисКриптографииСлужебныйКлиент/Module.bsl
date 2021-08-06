///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ПолучитьМаркерБезопасности

Процедура ПолучитьМаркерБезопасности(ОповещениеОЗавершении, Идентификатор, ПараметрыОперации = Неопределено) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Идентификатор", Идентификатор);
	Контекст.Вставить("ПараметрыОперации", ПараметрыОперации);
	
	Оповещение = Новый ОписаниеОповещения("ПолучитьМаркерБезопасностиПослеПолучения", ЭтотОбъект, Контекст);
	#Если МобильноеПриложениеКлиент ИЛИ МобильныйКлиент Тогда
		ФормаВводаПароля = "ОбщаяФорма.ВводВременногоПароляМобильноеПриложение";
	#Иначе
		ФормаВводаПароля = "ОбщаяФорма.ВводВременногоПароля";
	#КонецЕсли
	
	ДанныеСертификата = Новый Структура("Идентификатор", Идентификатор);
	ОткрытьФорму(
		ФормаВводаПароля, 
		Новый Структура("Сертификат, ПараметрыОперации", ДанныеСертификата, ПараметрыОперации),
		,,,, 
		Оповещение);
		
КонецПроцедуры

// Параметры:
//   Результат - Неопределено, Структура - результат выполнения обработчика.
//   ВходящийКонтекст - Структура:
//    * ОповещениеОЗавершении - ОписаниеОповещения - оповещение.
//    * Идентификатор - Строка - идентификатор операции.
//    * ПараметрыОперации - Структура - параметры.
//
Процедура ПолучитьМаркерБезопасностиПослеПолучения(Результат, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено", Ложь);
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		Если Результат.Состояние = "ИзменениеНастроекПолученияВременныхПаролей" Тогда
			Оповещение = Новый ОписаниеОповещения("ПолучитьМаркерБезопасностиПослеИзмененияНастроекПолученияВременныхПаролей", ЭтотОбъект, ВходящийКонтекст);
			ЭлектроннаяПодписьВМоделиСервисаКлиент.ИзменитьНастройкиПолученияВременныхПаролей(Результат.Сертификат, Оповещение);
			Возврат;
		ИначеЕсли Результат.Состояние = "ИзменениеСпособаПодтвержденияКриптооперации" Тогда
			Оповещение = Новый ОписаниеОповещения("ПолучитьМаркерБезопасностиПослеПолучения", ЭтотОбъект, ВходящийКонтекст);
			ЭлектроннаяПодписьВМоделиСервисаКлиент.ИзменитьСпособПодтвержденияКриптоопераций(Результат.Сертификат, Оповещение);
			Возврат;
		ИначеЕсли Результат.Состояние = "ПродолжитьПолучениеМаркераБезопасности" Тогда
			ПолучитьМаркерБезопасности(ВходящийКонтекст.ОповещениеОЗавершении, ВходящийКонтекст.Идентификатор, ВходящийКонтекст.ПараметрыОперации);	
			Возврат;
		ИначеЕсли Результат.Состояние = "ПарольНеПринят" Тогда
			ТекстИсключения = Результат.ОписаниеОшибки;
		ИначеЕсли Результат.Состояние = "ПарольПринят" Тогда
			РезультатВыполнения.Вставить("Выполнено", Истина);	
		КонецЕсли;
	Иначе
		ТекстИсключения = НСтр("ru = 'Пользователь отказался от ввода пароля'");
	КонецЕсли;
	
	
	Если Не РезультатВыполнения.Выполнено Тогда
		Попытка
			ВызватьИсключение(ТекстИсключения);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
		КонецПопытки;
		РезультатВыполнения.Вставить("ИнформацияОбОшибке", ИнформацияОбОшибке);
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	
КонецПроцедуры

// Параметры:
//   Результат - см. ПолучитьМаркерБезопасностиПослеПолучения.Результат
//   ВходящийКонтекст - см. ПолучитьМаркерБезопасностиПослеПолучения.ВходящийКонтекст
//
Процедура ПолучитьМаркерБезопасностиПослеИзмененияНастроекПолученияВременныхПаролей(Результат, ВходящийКонтекст) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		Если Результат.ТелефонИзменен ИЛИ Результат.ЭлектроннаяПочтаИзменена Тогда
			ПолучитьМаркерБезопасности(ВходящийКонтекст.ОповещениеОЗавершении, ВходящийКонтекст.Идентификатор, ВходящийКонтекст.ПараметрыОперации);	
		Иначе
			ПолучитьМаркерБезопасностиПослеПолучения(Неопределено, ВходящийКонтекст);	
		КонецЕсли;
	Иначе
		ПолучитьМаркерБезопасностиПослеПолучения(Неопределено, ВходящийКонтекст);
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область Зашифровать

Процедура Зашифровать(ОповещениеОЗавершении, Данные, Получатели, ТипШифрования = "CMS", ПараметрыШифрования = Неопределено) Экспорт
	
	Оповещение = Новый ОписаниеОповещения(
		"ЗашифроватьПослеЗавершения", 
		ЭтотОбъект, 
		Новый Структура("ОповещениеОЗавершении", ОповещениеОЗавершении));
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.Зашифровать(Данные, Получатели, ТипШифрования, ПараметрыШифрования));
	
КонецПроцедуры

Процедура ЗашифроватьБлок(ОповещениеОЗавершении, Данные, Получатель) Экспорт
	
	Оповещение = Новый ОписаниеОповещения(
		"ЗашифроватьПослеЗавершения", 
		ЭтотОбъект, 
		Новый Структура("ОповещениеОЗавершении", ОповещениеОЗавершении));
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ЗашифроватьБлок(Данные, Получатель));
	
КонецПроцедуры
	
Процедура ЗашифроватьПослеЗавершения(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	Если Результат.Выполнено Тогда
		Результат.Вставить("ЗашифрованныеДанные", Результат.РезультатВыполнения);
		Результат.Удалить("РезультатВыполнения");
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);

КонецПроцедуры

#КонецОбласти

#Область Расшифровать

Процедура Расшифровать(ОповещениеОЗавершении, ЗашифрованныеДанные, ТипШифрования = "CMS", ПараметрыШифрования = Неопределено) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("ЗашифрованныеДанные", ЗашифрованныеДанные);
	Контекст.Вставить("ТипШифрования", ТипШифрования);
	Контекст.Вставить("ПараметрыШифрования", ПараметрыШифрования);
	
	Оповещение = Новый ОписаниеОповещения("РасшифроватьПослеПолученияСвойствКриптосообщения", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ПолучитьСвойстваКриптосообщения(ЗашифрованныеДанные, Истина));	
	
КонецПроцедуры

Процедура РасшифроватьБлок(ОповещениеОЗавершении, ЗашифрованныеДанные, Получатель, КлючеваяИнформация, ПараметрыШифрования = Неопределено) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("ЗашифрованныеДанные", ЗашифрованныеДанные);
	Контекст.Вставить("Получатель", Получатель);
	Контекст.Вставить("КлючеваяИнформация", КлючеваяИнформация);
	Контекст.Вставить("ПараметрыШифрования", ПараметрыШифрования);
	
	Оповещение = Новый ОписаниеОповещения("РасшифроватьБлокПослеВыполненияРасшифровки", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.РасшифроватьБлок(ЗашифрованныеДанные, Получатель, КлючеваяИнформация, ПараметрыШифрования));	
	
КонецПроцедуры
	
Процедура РасшифроватьПослеПолученияСвойствКриптосообщения(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	СвойстваСообщения = Неопределено;
	
	ПолеПолучатели = "Получатели";
	ПолеИдентификатор = "Идентификатор";
	
	Если Результат.Выполнено Тогда
		СвойстваСообщения = Результат.РезультатВыполнения;

		Идентификаторы = Новый Массив;
		Если СвойстваСообщения.Тип = "envelopedData" Тогда
			Для Каждого Получатель Из СвойстваСообщения[ПолеПолучатели] Цикл
				Если Получатель.Свойство(ПолеИдентификатор) Тогда
					Идентификаторы.Добавить(Получатель[ПолеИдентификатор]);
				КонецЕсли;
			КонецЦикла;			
		Иначе
			Попытка
				ВызватьИсключение(НСтр("ru = 'Недопустимое значение параметра ЗашифрованныеДанные - файл не является криптосообщением'"));
			Исключение
				РезультатВыполнения = ПодготовитьОтрицательныйРезультат(ИнформацияОбОшибке());
				ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
				Возврат;
			КонецПопытки;	
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Идентификаторы) Тогда
			Попытка
				ВызватьИсключение(НСтр("ru = 'В хранилище отсутствуют сертификаты для расшифровки сообщения.'"));
			Исключение
				РезультатВыполнения = ПодготовитьОтрицательныйРезультат(ИнформацияОбОшибке());
				ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
				Возврат;
			КонецПопытки;
		КонецЕсли;
		
		ВходящийКонтекст.Вставить("Идентификаторы", Идентификаторы);
		ВходящийКонтекст.Вставить("ТекущийИдентификатор", 0);
		ВходящийКонтекст.Вставить(ПолеПолучатели, СвойстваСообщения[ПолеПолучатели]);
		ВходящийКонтекст.Вставить("ОписанияОшибок", Новый Массив);
		РасшифроватьПереборомСертификатов(ВходящийКонтекст);
	Иначе		
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
		Если ТипЗнч(Результат) = Тип("Структура") И Результат.Свойство("РезультатВыполнения") Тогда 
			СвойстваСообщения = Результат.РезультатВыполнения;
		КонецЕсли;
		Если ЗначениеЗаполнено(СвойстваСообщения) И СвойстваСообщения.Свойство(ПолеПолучатели) Тогда
			РезультатВыполнения.Вставить(ПолеПолучатели, СвойстваСообщения[ПолеПолучатели]);
		КонецЕсли;
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	КонецЕсли;

КонецПроцедуры

Процедура РасшифроватьПослеВыполненияРасшифровки(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		Если ТипЗнч(Результат.РезультатВыполнения) = Тип("Структура") Тогда
			Если Результат.РезультатВыполнения.КодВозврата = "ТребуетсяАутентификация" Тогда
				Оповещение = Новый ОписаниеОповещения("РасшифроватьПослеПолученияМаркераБезопасности", ЭтотОбъект, ВходящийКонтекст);
				ПолучитьМаркерБезопасности(Оповещение, Результат.РезультатВыполнения.Идентификатор, ВходящийКонтекст.ПараметрыШифрования);
			Иначе
				ВызватьИсключение(НСтр("ru = 'Неизвестный код возврата'"));
			КонецЕсли;
		Иначе
			Результат.Вставить("РасшифрованныеДанные", Результат.РезультатВыполнения);
			Результат.Удалить("РезультатВыполнения");
			ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
		КонецЕсли;
	Иначе
		ВходящийКонтекст.ТекущийИдентификатор = ВходящийКонтекст.ТекущийИдентификатор + 1;
		РасшифроватьПереборомСертификатов(ВходящийКонтекст, Результат.ИнформацияОбОшибке);
	КонецЕсли;
		
КонецПроцедуры

Процедура РасшифроватьПослеПолученияМаркераБезопасности(Результат, ВходящийКонтекст) Экспорт
	
	Если Результат.Выполнено Тогда
		РасшифроватьПереборомСертификатов(ВходящийКонтекст);
	Иначе
		ПредставлениеОшибки = КраткоеПредставлениеОшибки(Результат.ИнформацияОбОшибке);
		Если ВходящийКонтекст.ОписанияОшибок.Найти(ПредставлениеОшибки) = Неопределено Тогда
			ВходящийКонтекст.ОписанияОшибок.Добавить(ПредставлениеОшибки);
		КонецЕсли;		
		ВходящийКонтекст.ТекущийИдентификатор = ВходящийКонтекст.ТекущийИдентификатор + 1;
		РасшифроватьПереборомСертификатов(ВходящийКонтекст);
	КонецЕсли;
	
КонецПроцедуры

Процедура РасшифроватьБлокПослеВыполненияРасшифровки(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		Если ТипЗнч(Результат.РезультатВыполнения) = Тип("Структура") Тогда
			Если Результат.РезультатВыполнения.КодВозврата = "ТребуетсяАутентификация" Тогда
				Оповещение = Новый ОписаниеОповещения("РасшифроватьБлокПослеПолученияМаркераБезопасности", ЭтотОбъект, ВходящийКонтекст);
				ПолучитьМаркерБезопасности(Оповещение, Результат.РезультатВыполнения.Идентификатор, ВходящийКонтекст.ПараметрыШифрования);
			Иначе
				ВызватьИсключение(НСтр("ru = 'Неизвестный код возврата'"));
			КонецЕсли;
		Иначе
			Результат.Вставить("РасшифрованныеДанные", Результат.РезультатВыполнения);
			Результат.Удалить("РезультатВыполнения");
			ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
		КонецЕсли;
	Иначе
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
	КонецЕсли;
		
КонецПроцедуры

Процедура РасшифроватьБлокПослеПолученияМаркераБезопасности(Результат, ВходящийКонтекст) Экспорт
	
	Если Результат.Выполнено Тогда
		Оповещение = Новый ОписаниеОповещения("РасшифроватьБлокПослеВыполненияРасшифровки", ЭтотОбъект, ВходящийКонтекст);
		ОжидатьЗавершенияВыполненияВФоне(
			Оповещение, 
			СервисКриптографииСлужебныйВызовСервера.РасшифроватьБлок(
				ВходящийКонтекст.ЗашифрованныеДанные, 
				ВходящийКонтекст.Получатель,
				ВходящийКонтекст.КлючеваяИнформация, 
				ВходящийКонтекст.ПараметрыШифрования));
		Возврат;
	Иначе
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Подписать

Процедура Подписать(ОповещениеОЗавершении, Данные, Подписант, ТипПодписи = "CMS", ПараметрыПодписания = Неопределено) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Данные", Данные);
	Контекст.Вставить("Подписант", Подписант);
	Контекст.Вставить("ТипПодписи", ТипПодписи);
	Контекст.Вставить("ПараметрыПодписания", ПараметрыПодписания);
	
	Оповещение = Новый ОписаниеОповещения("ПодписатьПослеПолученияРезультатаПодписания", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.Подписать(Данные, Подписант, ТипПодписи, ПараметрыПодписания));
	
КонецПроцедуры

Процедура ПодписатьПослеПолученияРезультатаПодписания(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	РезультатВыполнения = Новый Структура("Выполнено");
	
	Если Результат.Выполнено Тогда
		
		Если ТипЗнч(Результат.РезультатВыполнения) = Тип("Структура") Тогда
			Если Результат.РезультатВыполнения.КодВозврата = "ТребуетсяАутентификация" Тогда		
				Контекст = Новый Структура;
				Контекст.Вставить("ОповещениеОЗавершении", ВходящийКонтекст.ОповещениеОЗавершении);
				Контекст.Вставить("Данные", ВходящийКонтекст.Данные);
				Контекст.Вставить("Подписант", ВходящийКонтекст.Подписант);
				Контекст.Вставить("ТипПодписи", ВходящийКонтекст.ТипПодписи);
				Контекст.Вставить("ПараметрыПодписания", ВходящийКонтекст.ПараметрыПодписания);
				
				Оповещение = Новый ОписаниеОповещения("ПодписатьПослеПолученияМаркераБезопасности", ЭтотОбъект, Контекст);
				ПолучитьМаркерБезопасности(Оповещение, Результат.РезультатВыполнения.Идентификатор, ВходящийКонтекст.ПараметрыПодписания);
			Иначе
				ВызватьИсключение(НСтр("ru = 'Неизвестный код возврата'"));
			КонецЕсли;
			Возврат;
		Иначе
			РезультатВыполнения.Выполнено = Истина;
			РезультатВыполнения.Вставить("Подпись", Результат.РезультатВыполнения);
		КонецЕсли;
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПодписатьПослеПолученияМаркераБезопасности(Результат, ВходящийКонтекст) Экспорт
	
	Если Результат.Выполнено Тогда
		Подписать(
			ВходящийКонтекст.ОповещениеОЗавершении,
			ВходящийКонтекст.Данные,
			ВходящийКонтекст.Подписант,
			ВходящийКонтекст.ТипПодписи,
			ВходящийКонтекст.ПараметрыПодписания);
	Иначе
		ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПроверитьПодпись

Процедура ПроверитьПодпись(ОповещениеОЗавершении, Подпись, Данные = Неопределено, ТипПодписи = "CMS", ПараметрыПодписания = Неопределено) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Подпись", Подпись);
	Контекст.Вставить("Данные", Данные);
	Контекст.Вставить("ТипПодписи", ТипПодписи);
	Контекст.Вставить("ПараметрыПодписания", ПараметрыПодписания);
		
	Оповещение = Новый ОписаниеОповещения("ПроверитьПодписьПослеПолученияРезультата", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ПроверитьПодпись(Подпись, Данные, ТипПодписи, ПараметрыПодписания));
	
КонецПроцедуры

Процедура ПроверитьПодписьПослеПолученияРезультата(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено");
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		
		РезультатПроверки = Результат.РезультатВыполнения;
		
		РезультатВыполнения.Выполнено = Истина;
		РезультатВыполнения.Вставить("ПодписьДействительна", РезультатПроверки);
		
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);		
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	
КонецПроцедуры

#КонецОбласти

#Область ПроверитьСертификат

Процедура ПроверитьСертификат(ОповещениеОЗавершении, Сертификат) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Сертификат", Сертификат);
	
	Оповещение = Новый ОписаниеОповещения("ПроверитьСертификатПослеПолученияРезультата", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ПроверитьСертификат(Сертификат));
		
КонецПроцедуры

Процедура ПроверитьСертификатПослеПолученияРезультата(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено");
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		
		РезультатПроверки = Результат.РезультатВыполнения;
		
		РезультатВыполнения.Выполнено = Истина;
		РезультатВыполнения.Вставить("Действителен", РезультатПроверки);
	
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);

КонецПроцедуры

#КонецОбласти

#Область ПолучитьСвойстваСертификата

Процедура ПолучитьСвойстваСертификата(ОповещениеОЗавершении, Сертификат) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Сертификат", Сертификат);
	
	Оповещение = Новый ОписаниеОповещения("ПолучитьСвойстваСертификатаПослеПолученияРезультата", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ПолучитьСвойстваСертификата(Сертификат));
	
КонецПроцедуры

Процедура ПолучитьСвойстваСертификатаПослеПолученияРезультата(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено");
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		
		СвойстваСертификата = Результат.РезультатВыполнения;
		
		РезультатВыполнения.Выполнено = Истина;
		РезультатВыполнения.Вставить("Сертификат", СвойстваСертификата);
	
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	
КонецПроцедуры

#КонецОбласти

#Область ПолучитьСертификатыИзПодписи

Процедура ПолучитьСертификатыИзПодписи(ОповещениеОЗавершении, Подпись) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Подпись", Подпись);
	
	Оповещение = Новый ОписаниеОповещения("ПолучитьСертификатыИзПодписиПослеПолученияРезультата", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ПолучитьСертификатыИзПодписи(Подпись));
	
КонецПроцедуры

Процедура ПолучитьСертификатыИзПодписиПослеПолученияРезультата(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено");
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		
		Сертификаты = Результат.РезультатВыполнения;
		
		РезультатВыполнения.Выполнено = Истина;
		РезультатВыполнения.Вставить("Сертификаты", Сертификаты);
		
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	
КонецПроцедуры
		
#КонецОбласти

#Область ХешированиеДанных

Процедура ХешированиеДанных(ОповещениеОЗавершении, Данные, АлгоритмХеширования, ПараметрыХеширования) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	Контекст.Вставить("Данные", Данные);
	Контекст.Вставить("АлгоритмХеширования", АлгоритмХеширования);
	Контекст.Вставить("ПараметрыХеширования", ПараметрыХеширования);
	
	Оповещение = Новый ОписаниеОповещения("ХешированиеДанныхПослеПолученияРезультата", ЭтотОбъект, Контекст);
	ОжидатьЗавершенияВыполненияВФоне(
		Оповещение, 
		СервисКриптографииСлужебныйВызовСервера.ХешированиеДанных(Данные, АлгоритмХеширования, ПараметрыХеширования));
	
КонецПроцедуры

Процедура ХешированиеДанныхПослеПолученияРезультата(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	РезультатВыполнения = Новый Структура("Выполнено");
	
	Результат = ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация);
	
	Если Результат.Выполнено Тогда
		
		Результат = Результат.РезультатВыполнения;
	
		РезультатВыполнения.Выполнено = Истина;
		РезультатВыполнения.Вставить("Хеш", Результат);
		
	Иначе
		РезультатВыполнения = ПодготовитьОтрицательныйРезультат(Результат.ИнформацияОбОшибке);
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, РезультатВыполнения);
	
КонецПроцедуры

#КонецОбласти

Процедура ОжидатьЗавершенияВыполненияВФоне(ОповещениеОЗавершении, ДлительнаяОперация) Экспорт
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//   Сертификат - Структура:
//    * Идентификатор - Строка - идентификатор сертификата.
// Возвращаемое значение:
//    Строка - идентификатор сертификата.
//
Функция Идентификатор(Знач Сертификат) Экспорт
	
	Возврат Сертификат.Идентификатор;

КонецФункции

// Возвращаемое значение:
//   Структура:
//   * Выполнено - Булево - признак выполнения
//   * РезультатВыполнения - ДвоичныеДанные, Строка, Структура - результат или описание ошибки с полями:
//      ** КодВозврата - Строка - код ошибки
//      ** Идентификатор - Строка - идентификатор сертификата.
//
Функция ПолучитьРезультатВыполненияВФоне(ДлительнаяОперация) Экспорт
	
	Если ДлительнаяОперация = Неопределено Тогда
		Возврат ПодготовитьОтрицательныйРезультат(НСтр("ru = 'Вызов API сервиса криптографии не был завершен штатно.'"));
	КонецЕсли;
	
	Если ДлительнаяОперация.Статус = "Выполнено" Тогда
		Возврат ПодготовитьПоложительныйРезультат(ПолучитьИзВременногоХранилища(ДлительнаяОперация.АдресРезультата));
	Иначе
		Возврат ПодготовитьОтрицательныйРезультат(ДлительнаяОперация.КраткоеПредставлениеОшибки);
	КонецЕсли;
	
КонецФункции

Функция ПодготовитьПоложительныйРезультат(РезультатВыполнения)
	
	Результат = Новый Структура;
	Результат.Вставить("Выполнено", Истина);
	Результат.Вставить("РезультатВыполнения", РезультатВыполнения);
		
	Возврат Результат;
	
КонецФункции

// Возвращаемое значение:
//   Структура:
//   * ИнформацияОбОшибке - ИнформацияОбОшибке - информация об ошибке. 
//   * Выполнено - Булево - всегда = Ложь
//
Функция ПодготовитьОтрицательныйРезультат(ИнформацияОбОшибке)
	
	Результат = Новый Структура;
	Результат.Вставить("Выполнено", Ложь);
	
	Если ТипЗнч(ИнформацияОбОшибке) = Тип("Строка") Тогда
		Результат.Вставить("ИнформацияОбОшибке", ПолучитьИнформациюОбОшибкеПоСтроке(ИнформацияОбОшибке));
	Иначе	
		Результат.Вставить("ИнформацияОбОшибке", ИнформацияОбОшибке);
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

Функция ПолучитьИнформациюОбОшибкеПоСтроке(ТекстИсключения)
	
	Попытка
		ВызватьИсключение ТекстИсключения;
	Исключение
		Возврат ИнформацияОбОшибке();
	КонецПопытки;
	
КонецФункции

// Параметры:
//   ВходящийКонтекст - Структура
//   ИнформацияОбОшибке - ИнформацияОбОшибке, Неопределено - информация об ошибке.
//
Процедура РасшифроватьПереборомСертификатов(ВходящийКонтекст, ИнформацияОбОшибке = Неопределено)

	Если ВходящийКонтекст.ТекущийИдентификатор < ВходящийКонтекст.Идентификаторы.Количество() Тогда
		Оповещение = Новый ОписаниеОповещения("РасшифроватьПослеВыполненияРасшифровки", ЭтотОбъект, ВходящийКонтекст);
		ОжидатьЗавершенияВыполненияВФоне(
			Оповещение, 
			СервисКриптографииСлужебныйВызовСервера.Расшифровать(
				ВходящийКонтекст.ЗашифрованныеДанные, 
				Новый Структура("Идентификатор", ВходящийКонтекст.Идентификаторы[ВходящийКонтекст.ТекущийИдентификатор]),
				ВходящийКонтекст.ТипШифрования, 
				ВходящийКонтекст.ПараметрыШифрования));
		Возврат;
	КонецЕсли;
	
	Если ИнформацияОбОшибке = Неопределено Тогда
		ТекстИсключения = СтрСоединить(ВходящийКонтекст.ОписанияОшибок, Символы.ПС);
		Если Не ЗначениеЗаполнено(ТекстИсключения) Тогда
			ТекстИсключения = НСтр("ru = 'Не удалось выполнить расшифровку сообщения'");
		КонецЕсли;
		Попытка			
			ВызватьИсключение(ТекстИсключения);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
		КонецПопытки;
	КонецЕсли;
	
	Результат = ПодготовитьОтрицательныйРезультат(ИнформацияОбОшибке);
	ПолеПолучатели = "Получатели";
	Если ВходящийКонтекст.Свойство(ПолеПолучатели) Тогда
		Результат.Вставить(ПолеПолучатели, ВходящийКонтекст[ПолеПолучатели]);
	КонецЕсли;
	ВыполнитьОбработкуОповещения(ВходящийКонтекст.ОповещениеОЗавершении, Результат);
	
КонецПроцедуры

#КонецОбласти