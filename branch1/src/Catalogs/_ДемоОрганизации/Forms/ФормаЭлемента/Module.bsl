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
	
	Если Не Пользователи.ЭтоСеансВнешнегоПользователя() Тогда
		// СтандартныеПодсистемы.ПодключаемыеКоманды
		ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
		// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
		
		Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
			МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
			ДополнительныеПараметрыКонтактнойИнформации = МодульУправлениеКонтактнойИнформацией.ПараметрыКонтактнойИнформации();
			ДополнительныеПараметрыКонтактнойИнформации.ТипПомещения = "Офис";
			МодульУправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект, ДополнительныеПараметрыКонтактнойИнформации);
		КонецЕсли;
	Иначе
		Элементы.Страницы.Видимость = Ложь;
	КонецЕсли;
	
	ВидОрганизации = ?(ЗначениеЗаполнено(Объект.ИндивидуальныйПредприниматель), 1, 0);
	
	// СтандартныеПодсистемы.РаботаСФайлами
	ДобавляемыеЭлементы = Новый Массив;
	
	ПараметрыГиперссылки = РаботаСФайлами.ГиперссылкаФайлов();
	ПараметрыГиперссылки.Размещение = "КоманднаяПанель";
	ДобавляемыеЭлементы.Добавить(ПараметрыГиперссылки);
	
	ОбщиеПараметрыПоля = РаботаСФайлами.ПолеФайла();
	ОбщиеПараметрыПоля.ФильтрДиалогаВыбора = НСтр("ru = 'Изображения'") + "|*.bmp;*.png;*.jpg";
	ОбщиеПараметрыПоля.МаксимальныйРазмер = 2;
	ОбщиеПараметрыПоля.ПоказыватьКоманднуюПанель = Ложь;
	
	ПараметрыПоля = РаботаСФайлами.ПолеФайла();
	ЗаполнитьЗначенияСвойств(ПараметрыПоля, ОбщиеПараметрыПоля);
	ПараметрыПоля.Размещение  = "ПечатьОрганизации";
	ПараметрыПоля.ПутьКДанным = "Объект.ПечатьОрганизации";
	ДобавляемыеЭлементы.Добавить(ПараметрыПоля);
	
	ПараметрыПоля = РаботаСФайлами.ПолеФайла();
	ЗаполнитьЗначенияСвойств(ПараметрыПоля, ОбщиеПараметрыПоля);
	ПараметрыПоля.Размещение  = "ПодписьДиректора";
	ПараметрыПоля.ПутьКДанным = "Объект.ПодписьДиректора";
	ДобавляемыеЭлементы.Добавить(ПараметрыПоля);
	
	ПараметрыПоля = РаботаСФайлами.ПолеФайла();
	ЗаполнитьЗначенияСвойств(ПараметрыПоля, ОбщиеПараметрыПоля);
	ПараметрыПоля.Размещение  = "ПодписьГлавногоБухгалтера";
	ПараметрыПоля.ПутьКДанным = "Объект.ПодписьГлавногоБухгалтера";
	ДобавляемыеЭлементы.Добавить(ПараметрыПоля);
	
	ПараметрыПоля = РаботаСФайлами.ПолеФайла();
	ЗаполнитьЗначенияСвойств(ПараметрыПоля, ОбщиеПараметрыПоля);
	ПараметрыПоля.Размещение  = "ЭмблемаОрганизацииДляШтампаЭлектроннойПодписи";
	ПараметрыПоля.ПутьКДанным = "Объект.ЭмблемаОрганизацииДляШтампаЭлектроннойПодписи";
	ДобавляемыеЭлементы.Добавить(ПараметрыПоля);
	
	РаботаСФайлами.ПриСозданииНаСервере(ЭтотОбъект, ДобавляемыеЭлементы);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.НаименованиеПолное.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
		
		Элементы.ОсновнаяГруппировка.ВыравниваниеЭлементовИЗаголовков =
			ВариантВыравниванияЭлементовИЗаголовков.ЭлементыПравоЗаголовкиЛево;
		
		Элементы.Главное.ВыравниваниеЭлементовИЗаголовков =
			ВариантВыравниванияЭлементовИЗаголовков.ЭлементыПравоЗаголовкиЛево;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
		МодульУправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
		МодульУправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
		МодульУправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	
	ОбновитьИнтерфейс = ТекущийОбъект.ЭтоНовый() И НЕ ПолучитьФункциональнуюОпцию("_ДемоИспользоватьНесколькоОрганизаций");
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ОбновитьИнтерфейс Тогда
		ОбновитьИнтерфейс();
	КонецЕсли;
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	Оповестить("Запись_Организация", Новый Структура, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	ОпределитьДоступностьПоляИндивидуальныйПредприниматель(Ложь);
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПрефиксПриИзменении(Элемент)
	Если СтрНайти(Объект.Префикс, "-") > 0 Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Нельзя в префиксе организации использовать символ ""-"".'"));
		Объект.Префикс = СтрЗаменить(Объект.Префикс, "-", "");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВидОрганизацииЮридическоеЛицоПриИзменении(Элемент)
	ОпределитьДоступностьПоляИндивидуальныйПредприниматель();
КонецПроцедуры

&НаКлиенте
Процедура КПППриИзменении(Элемент)
	КПППриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СтранаРегистрацииОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.СтранаМираОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
КонецПроцедуры

// СтандартныеПодсистемы.РаботаСФайлами

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраНажатие(Элемент, СтандартнаяОбработка)
	
	РаботаСФайламиКлиент.ПолеПредпросмотраНажатие(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	РаботаСФайламиКлиент.ПолеПредпросмотраПеретаскивание(ЭтотОбъект, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	РаботаСФайламиКлиент.ПолеПредпросмотраПроверкаПеретаскивания(ЭтотОбъект, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.РаботаСФайлами

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_КомандаПанелиПрисоединенныхФайлов(Команда)

	РаботаСФайламиКлиент.КомандаУправленияПрисоединеннымиФайлами(ЭтотОбъект, Команда);

КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

&НаКлиенте
Процедура ПоказатьИнструкциюПоСозданиюФаксимильнойПодписиИПечати(Команда)
	УправлениеПечатьюКлиент.ПоказатьИнструкциюПоСозданиюФаксимильнойПодписиИПечати();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОпределитьДоступностьПоляИндивидуальныйПредприниматель(УстановитьЗначение = Истина)
	Элементы.ИндивидуальныйПредприниматель.Доступность = (ВидОрганизации = 1);
	
	Если УстановитьЗначение Тогда
		Если ВидОрганизации = 0 Тогда
			Объект.ИндивидуальныйПредприниматель = Неопределено;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.КонтактнаяИнформация

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьИзменение(ЭтотОбъект, Элемент);
	КонецЕсли;
КонецПроцедуры

// Параметры:
//   Элемент - ПолеФормы
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		
		ПараметрыОткрытия = Новый Структура;
		
		Отбор = Новый Структура("ИмяРеквизита", Элемент.Имя);
		Строки = ЭтотОбъект.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(Отбор);  // см. УправлениеКонтактнойИнформациейКлиентСервер.ОписаниеКонтактнойИнформацииНаФорме
		ДанныеСтроки = ?(Строки.Количество() = 0, Неопределено, Строки[0]);
		Если ДанныеСтроки <> Неопределено Тогда
			ДобавитьСтрануВПараметрыОткрытия(ПараметрыОткрытия, ДанныеСтроки.Вид, Объект.СтранаРегистрации);
		КонецЕсли;
		
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент,, СтандартнаяОбработка, ПараметрыОткрытия);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент,, СтандартнаяОбработка);
	КонецЕсли;
КонецПроцедуры

// Параметры:
//   Элемент - ПолеФормы
//   СтандартнаяОбработка - Булево
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьОчистку(ЭтотОбъект, Элемент.Имя);
	КонецЕсли;
КонецПроцедуры


// Параметры:
//   Команда - КомандаФормы
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда.Имя);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//   Элемент - ПолеФормы
// 	
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.ОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, Элемент.Имя, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
		МодульУправлениеКонтактнойИнформациейКлиент.НачатьОбработкуНавигационнойСсылки(ЭтотОбъект, Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьОбновлениеКонтактнойИнформации(Результат, ДополнительныеПараметры) Экспорт
	ОбновитьКонтактнуюИнформацию(Результат);
КонецПроцедуры

&НаСервере
Процедура ОбновитьКонтактнуюИнформацию(Результат)
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
		МодульУправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

&НаСервере
Процедура КПППриИзмененииНаСервере()
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КалендарныеГрафики") Тогда
		МодульКалендарныеГрафики = ОбщегоНазначения.ОбщийМодуль("КалендарныеГрафики");
		МодульКалендарныеГрафики.ЗаполнитьПроизводственныйКалендарьВФорме(ЭтотОбъект, "Объект.ПроизводственныйКалендарь", Объект.КПП);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ДобавитьСтрануВПараметрыОткрытия(ПараметрыОткрытия, Вид , СтранаРегистрации)
	
	Если Вид = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоМеждународныйАдресОрганизации")
			ИЛИ Вид = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоПочтовыйАдресОрганизации") Тогда
			ПараметрыОткрытия.Вставить("Страна", СтранаРегистрации);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
