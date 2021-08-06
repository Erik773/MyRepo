///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Контрагент = ?(Параметры.ВидПроверки.Свойство2 <> Неопределено, Параметры.ВидПроверки.Свойство2, 
		Справочники._ДемоКонтрагенты.ПустаяСсылка());
	Если Не Контрагент.Пустая() Тогда
		УточнениеЗаголовка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'контрагента %1'"), Контрагент);
	Иначе
		УточнениеЗаголовка = НСтр("ru = 'всех контрагентов'");
	КонецЕсли;
	Элементы.Пояснение.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Элементы.Пояснение.Заголовок,
		УточнениеЗаголовка);
	
	УстановитьТекущуюСтраницу(ЭтотОбъект, Ложь, Ложь, Ложь);
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Авто;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПровестиСчетФактуруПолученный(Команда)
	
	ДлительнаяОперация = ПровестиСчетаФактурыВФоне();
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ПровестиСчетаФактурыВФонеЗавершение", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСчетовФактур(Команда)
	
	ОткрытьФорму("Документ._ДемоСчетФактураПолученный.ФормаСписка");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьТекущуюСтраницу(Форма, ИдетИсправлениеПроблемы, ИсправлениеУспешноВыполнено, СбойВАлгоритмеИсправления)
	
	ЭлементыФормы = Форма.Элементы;
	Если ИдетИсправлениеПроблемы Тогда
		ЭлементыФормы.ГруппаИндикаторИсправления.Видимость           = Истина;
		ЭлементыФормы.ГруппаИндикаторНачалаИсправления.Видимость     = Ложь;
		ЭлементыФормы.ГруппаИндикаторУспешноеИсправление.Видимость   = Ложь;
		ЭлементыФормы.ГруппаИндикаторНеуспешноеИсправление.Видимость = Ложь;
	ИначеЕсли ИсправлениеУспешноВыполнено Тогда
		ЭлементыФормы.ГруппаИндикаторИсправления.Видимость           = Ложь;
		ЭлементыФормы.ГруппаИндикаторНачалаИсправления.Видимость     = Ложь;
		ЭлементыФормы.ГруппаИндикаторУспешноеИсправление.Видимость   = Истина;
		ЭлементыФормы.Провести.Видимость                             = Ложь;
		ЭлементыФормы.ГруппаИндикаторНеуспешноеИсправление.Видимость = Ложь;
	ИначеЕсли СбойВАлгоритмеИсправления Тогда
		ЭлементыФормы.ГруппаИндикаторИсправления.Видимость           = Ложь;
		ЭлементыФормы.ГруппаИндикаторНачалаИсправления.Видимость     = Ложь;
		ЭлементыФормы.ГруппаИндикаторУспешноеИсправление.Видимость   = Ложь;
		ЭлементыФормы.ГруппаИндикаторНеуспешноеИсправление.Видимость = Истина;
	Иначе
		ЭлементыФормы.ГруппаИндикаторИсправления.Видимость         = Ложь;
		ЭлементыФормы.ГруппаИндикаторНачалаИсправления.Видимость   = Истина;
		ЭлементыФормы.ГруппаИндикаторУспешноеИсправление.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПровестиСчетаФактурыВФоне()
	
	Если ДлительнаяОперация <> Неопределено Тогда
		ДлительныеОперации.ОтменитьВыполнениеЗадания(ДлительнаяОперация.ИдентификаторЗадания);
	КонецЕсли;
	
	УстановитьТекущуюСтраницу(ЭтотОбъект, Истина, Ложь, Ложь);
	
	Если Контрагент.Пустая() Тогда
		НаименованиеФоновогоЗадания = НСтр("ru = 'Проведение счет-фактур всех контрагентов'");
	Иначе
		НаименованиеФоновогоЗадания = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Проведение счет-фактур контрагента ""%1""'"), Контрагент);
	КонецЕсли;
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеФоновогоЗадания;
	
	ПараметрыПроверки = Новый Структура("ВидПроверки", Параметры.ВидПроверки);
	
	Результат = ДлительныеОперации.ВыполнитьВФоне("Документы._ДемоСчетФактураПолученный.ПровестиСчетаФактурыПоПроблемнымКонтрагентам",
		ПараметрыПроверки, ПараметрыВыполнения);
		
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПровестиСчетаФактурыВФонеЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ДлительнаяОперация = Неопределено;

	Если Результат = Неопределено Тогда
		УстановитьТекущуюСтраницу(ЭтотОбъект, Истина, Ложь, Ложь);
		Возврат;
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		УстановитьТекущуюСтраницу(ЭтотОбъект, Ложь, Ложь, Ложь);
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	ИначеЕсли Результат.Статус = "Выполнено" Тогда
		ОбработатьУспешноеВыполнениеИсправления(Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьУспешноеВыполнениеИсправления(Результат)
	
	АдресРезультата      = Результат.АдресРезультата;
	РезультатыПроведения = ПолучитьИзВременногоХранилища(АдресРезультата);
	
	КоличествоНепроведенных          = РезультатыПроведения.КоличествоНепроведенных;
	КоличествоПроведенных            = РезультатыПроведения.КоличествоПроведенных;
	КоличествоНеправильноЗаполненных = РезультатыПроведения.КоличествоНеправильноЗаполненных;
	
	Если КоличествоНепроведенных = 0 И КоличествоНеправильноЗаполненных = 0 Тогда
		УстановитьТекущуюСтраницу(ЭтотОбъект, Ложь, Истина, Ложь);
		Элементы.НадписьУспешноеИсправление.Заголовок = ОписаниеУспеха(КоличествоПроведенных);
	Иначе
		УстановитьТекущуюСтраницу(ЭтотОбъект, Ложь, Ложь, Истина);
		Элементы.НадписьНеуспешноеИсправление.Заголовок = ОписаниеПричинНеуспеха(АдресРезультата, КоличествоПроведенных, КоличествоНепроведенных, КоличествоНеправильноЗаполненных);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОписаниеПричинНеуспеха(АдресРезультата, КоличествоПроведенных, КоличествоНепроведенных, КоличествоНеправильноЗаполненных)
	
	Информация = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Проведено: %1
	|Не проведено: %2
	|в т.ч. из-за незаполненных данных: %3'"),
	Формат(КоличествоПроведенных, "ЧН=0; ЧГ=0"), Формат(КоличествоНепроведенных, "ЧН=0; ЧГ=0"), Формат(КоличествоНеправильноЗаполненных, "ЧН=0; ЧГ=0"));
	
	ГиперссылкаОтчета = Новый ФорматированнаяСтрока(НСтр("ru = 'Подробнее...'"), , , , АдресРезультата);
	
	Возврат Новый ФорматированнаяСтрока(Информация, Символы.ПС, ГиперссылкаОтчета);
	
КонецФункции

&НаСервереБезКонтекста
Функция ОписаниеУспеха(КоличествоПроведенных)
	
	ТекстоваяИнформацияОПроведенных = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Успешно проведено документов: %1'"),
		Формат(КоличествоПроведенных, "ЧН=0; ЧГ=0"));
	
	Возврат Новый ФорматированнаяСтрока(ТекстоваяИнформацияОПроведенных, , ЦветаСтиля.РезультатУспехЦвет);
	
КонецФункции

&НаКлиенте
Процедура НадписьНеуспешноеИсправлениеОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СписокПроблемныхСчетовФактур = СписокПроблемныхСчетовФактур(НавигационнаяСсылкаФорматированнойСтроки);
	СписокПроблемныхСчетовФактур.Показать(НСтр("ru = 'Список проблемных счетов-фактур'"), , Истина);
	
КонецПроцедуры

&НаСервере
Функция СписокПроблемныхСчетовФактур(НавигационнаяСсылкаФорматированнойСтроки)
	
	РезультатыПроведения           = ПолучитьИзВременногоХранилища(НавигационнаяСсылкаФорматированнойСтроки);
	ПодробнаяИнформацияПоПроблемам = РезультатыПроведения.ПодробнаяИнформацияПоПроблемам;
	
	СписокПроблемныхСчетовФактур = Новый ТабличныйДокумент;
	Макет                        = Документы._ДемоСчетФактураПолученный.ПолучитьМакет("Макет");
	
	ОбластьШапка = Макет.ПолучитьОбласть("Шапка");
	СписокПроблемныхСчетовФактур.Вывести(ОбластьШапка);
	
	Для Каждого ЭлементИнформации Из ПодробнаяИнформацияПоПроблемам Цикл
		
		ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
		
		ОбластьСтрока.Параметры.СсылкаНаДокумент = ЭлементИнформации.Ключ;
		ОбластьСтрока.Параметры.ТекстИсключения  = ЭлементИнформации.Значение;
		
		СписокПроблемныхСчетовФактур.Вывести(ОбластьСтрока);
		
	КонецЦикла;
	
	СписокПроблемныхСчетовФактур.ФиксацияСверху = 1;
	СписокПроблемныхСчетовФактур.Защита         = Истина;
	
	Возврат СписокПроблемныхСчетовФактур;
	
КонецФункции

#КонецОбласти