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
	
	УстановитьУсловноеОформление();
	
	БыстрыйОтбор = ОбщегоНазначения.СкопироватьРекурсивно(Параметры.Отбор);
	Если ЗначениеЗаполнено(БыстрыйОтбор) Тогда
		УстановитьОтборПриСозданииНаСервере(БыстрыйОтбор);
		Параметры.Отбор.Очистить();
	КонецЕсли;
	
	// СтандартныеПодсистемы.УправлениеДоступом
	ОписаниеОтборов = Новый Соответствие;
	ОписаниеОтборов.Вставить("Организация", Тип("СправочникСсылка._ДемоОрганизации"));
	ОписаниеОтборов.Вставить("Партнер",     Тип("СправочникСсылка._ДемоПартнеры"));
	УправлениеДоступом.НастроитьОтборыДинамическогоСписка(Список, ОписаниеОтборов);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов")
	 Или Не ПравоДоступа("Редактирование", Метаданные.Документы._ДемоЗаказПокупателя) Тогда
		
		Элементы.ФормаИзменитьВыделенные.Видимость = Ложь;
	КонецЕсли;
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчета.ПриСозданииНаСервереФормыСписка(ЭтотОбъект, "Список");
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.Комментарий.Видимость = Ложь;
		Элементы.ГруппаШапка.ОтображатьЗаголовок = Истина;
		Элементы.ОтборПоОрганизации.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Лево;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	Если ЗначениеЗаполнено(БыстрыйОтбор) Тогда
		Для Каждого ЭлементОтбора Из БыстрыйОтбор Цикл
			Настройки.Удалить(ЭлементОтбора.Ключ);
		КонецЦикла;
	Иначе
		Для Каждого НастройкаСписка Из Настройки Цикл
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, НастройкаСписка.Ключ, НастройкаСписка.Значение, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(НастройкаСписка.Значение));
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборПоСтатусуЗаказаПриИзменении(Элемент)
	УстановитьОтборПоСтатусуНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоСтатусуЗаказаОчистка(Элемент, СтандартнаяОбработка)
	Если СтатусЗаказа = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоОрганизацииПриИзменении(Элемент)
	УстановитьОтборПоОрганизацииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоОрганизацииОчистка(Элемент, СтандартнаяОбработка)
	Если Организация = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.СписокПредметПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле);
	// Конец СтандартныеПодсистемы.Взаимодействия

КонецПроцедуры

&НаКлиенте
Процедура СписокПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.СписокПредметПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле);
	// Конец СтандартныеПодсистемы.Взаимодействия

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчета.ПриПолученииДанныхНаСервере(Настройки, Строки);
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтрольВеденияУчета

&НаКлиенте
Процедура Подключаемый_Выбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	КонтрольВеденияУчетаКлиент.ОткрытьОтчетПоПроблемамИзСписка(ЭтотОбъект, "Список", Поле, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтрольВеденияУчета

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	СтандартныеПодсистемыСервер.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "Список.Дата", Элементы.Дата.Имя);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Дата.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Номер.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Валюта.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Договор.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Комментарий.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Контрагент.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Организация.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Партнер.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СуммаДокумента.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СтатусЗаказа.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.СтатусЗаказа");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("ПустаяСсылка");

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);

КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПриСозданииНаСервере(БыстрыйОтбор)
	
	Для Каждого ЭлементОтбора Из БыстрыйОтбор Цикл
		
		Если ТипЗнч(ЭлементОтбора.Значение) = Тип("СписокЗначений") Тогда
			ВидСравненияСписка = ВидСравненияКомпоновкиДанных.ВСписке;
		Иначе
			ВидСравненияСписка = ВидСравненияКомпоновкиДанных.Равно;
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Список, ЭлементОтбора.Ключ, ЭлементОтбора.Значение, ВидСравненияСписка,, Истина);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСтатусуНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, "СтатусЗаказа", СтатусЗаказа, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(СтатусЗаказа));
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоОрганизацииНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, "Организация", Организация, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

#КонецОбласти
