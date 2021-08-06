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
	
	ИнициализироватьОтборы();
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия") Тогда
		ВключенаОтправкаSMS = Истина;
		ВключенаРаботаСПочтовымиСообщениями = Истина;
	Иначе
		ВключенаРаботаСПочтовымиСообщениями = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями");
		ВключенаОтправкаSMS = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОтправкаSMS");
	КонецЕсли;
	
	// кнопки в группе, если одна кнопка, то группа не нужна
	Элементы.ФормаСоздатьШаблонСообщенияSMS.Видимость = ВключенаОтправкаSMS;
	Элементы.ФормаСоздатьШаблонЭлектронногоПисьма.Видимость = ВключенаРаботаСПочтовымиСообщениями;
	Элементы.ФормаПоказыватьКонтекстныеШаблоны.Видимость = Пользователи.ЭтоПолноправныйПользователь();
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОтправкаSMS") Тогда
		
		СпрятатьЭлементыКогдаНедоступнаОднаИзПодсистем();
		
		Заголовок = НСтр("ru='Шаблоны сообщений электронных писем'");
		Элементы.ФормаСоздатьШаблонСообщенияSMS.Видимость       = Ложь;
		Элементы.ФормаСоздатьШаблонЭлектронногоПисьма.Заголовок = НСтр("ru='Создать'");
		ШаблонДля = ШаблоныСообщенийКлиентСервер.ИмяШаблонаЭлектронныхПисем();
		УстановитьОтборВСпискеШаблонов(Список, ШаблонДля);
		
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями") Тогда
		
		СпрятатьЭлементыКогдаНедоступнаОднаИзПодсистем();
		
		Заголовок = НСтр("ru='Шаблоны SMS сообщений'");
		Элементы.ФормаСоздатьШаблонЭлектронногоПисьма.Видимость = Ложь;
		Элементы.ФормаСоздатьШаблонСообщенияSMS.Заголовок       = НСтр("ru='Создать'");
		ШаблонДля = ШаблоныСообщенийКлиентСервер.ИмяШаблонаSMS();
		УстановитьОтборВСпискеШаблонов(Список, ШаблонДля);
		
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.ГруппаНаименованиеИФайлы.Группировка = ГруппировкаКолонок.ВЯчейке;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись_ШаблоныСообщений" Тогда
		ИнициализироватьОтборы();
		УстановитьФильтрНазначение(Назначение);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НазначениеФильтрПриИзменении(Элемент)
	УстановитьФильтрНазначение(Назначение);
КонецПроцедуры

&НаКлиенте
Процедура ШаблонДляФильтрОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УстановитьОтборВСпискеШаблонов(Список, ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ШаблоныСообщенийПечатныеФормыИВложения.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШаблоныСообщений.ПечатныеФормыИВложения КАК ШаблоныСообщенийПечатныеФормыИВложения
		|ГДЕ
		|	ШаблоныСообщенийПечатныеФормыИВложения.Ссылка В(&ШаблоныСообщений)
		|
		|СГРУППИРОВАТЬ ПО
		|	ШаблоныСообщенийПечатныеФормыИВложения.Ссылка";
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		
		Запрос.Текст = Запрос.Текст + "
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ШаблоныСообщенийПрисоединенныеФайлы.ВладелецФайла КАК Ссылка
		|ИЗ
		|	Справочник.ШаблоныСообщенийПрисоединенныеФайлы КАК ШаблоныСообщенийПрисоединенныеФайлы
		|ГДЕ
		|	ШаблоныСообщенийПрисоединенныеФайлы.ВладелецФайла В(&ШаблоныСообщений)
		|
		|СГРУППИРОВАТЬ ПО
		|	ШаблоныСообщенийПрисоединенныеФайлы.ВладелецФайла";
		
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ШаблоныСообщений", Строки.ПолучитьКлючи());
	
	ШаблоныСВложениями = Запрос.Выполнить().Выгрузить();
	ШаблоныСВложениями.Свернуть("Ссылка");
	Для каждого ШаблонСообщений Из ШаблоныСВложениями Цикл
		СтрокаСписка = Строки[ШаблонСообщений.Ссылка];
		СтрокаСписка.Данные["ЕстьФайлы"] = 1;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьШаблонЭлектронногоПисьма(Команда)
	СоздатьШаблон("ЭлектронноеПисьмо");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьШаблонСообщенияSMS(Команда)
	СоздатьШаблон("СообщениеSMS");
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьКонтекстныеШаблоны(Команда)
	Элементы.ФормаПоказыватьКонтекстныеШаблоны.Пометка = Не Элементы.ФормаПоказыватьКонтекстныеШаблоны.Пометка;
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьКонтекстныеШаблоны", Элементы.ФормаПоказыватьКонтекстныеШаблоны.Пометка);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СоздатьШаблон(ТипСообщения)
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("ВидСообщения",           ТипСообщения);
	ПараметрыФормы.Вставить("ПолноеИмяТипаОснования", Назначение);
	ПараметрыФормы.Вставить("МожноМенятьНазначение",  Истина);
	ОткрытьФорму("Справочник.ШаблоныСообщений.ФормаОбъекта", ПараметрыФормы, ЭтотОбъект);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборВСпискеШаблонов(Список, Знач ЗначениеОтбора)
	
	Если ЗначениеОтбора = ШаблоныСообщенийКлиентСервер.ИмяШаблонаSMS() Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПредназначенДляSMS", Истина, ВидСравненияКомпоновкиДанных.Равно);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПредназначенДляЭлектронныхПисем", Ложь, ВидСравненияКомпоновкиДанных.Равно);
	ИначеЕсли ЗначениеОтбора = ШаблоныСообщенийКлиентСервер.ИмяШаблонаЭлектронныхПисем() Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПредназначенДляSMS", Ложь, ВидСравненияКомпоновкиДанных.Равно);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПредназначенДляЭлектронныхПисем", Истина, ВидСравненияКомпоновкиДанных.Равно);
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.Отбор, "ПредназначенДляSMS");
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.Отбор, "ПредназначенДляЭлектронныхПисем");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФильтрНазначение(Знач ВыбранноеЗначение)
	
	Если ПустаяСтрока(ВыбранноеЗначение) Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.Отбор, "Назначение");
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Назначение", ВыбранноеЗначение, ВидСравненияКомпоновкиДанных.Равно);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ИнициализироватьОтборы()
	
	Элементы.НазначениеФильтр.СписокВыбора.Очистить();
	Элементы.ШаблонДляФильтр.СписокВыбора.Очистить();
	
	Список.Параметры.УстановитьЗначениеПараметра("Назначение", "");
	
	ВидыШаблонов = ШаблоныСообщенийСлужебный.ВидыШаблонов();
	ВидыШаблонов.Вставить(0, НСтр("ru = 'Электронных писем и SMS'"), НСтр("ru = 'Электронных писем и SMS'"));
	
	Список.Параметры.УстановитьЗначениеПараметра("СообщениеSMS", ВидыШаблонов.НайтиПоЗначению("SMS").Представление);
	Список.Параметры.УстановитьЗначениеПараметра("ЭлектроннаяПочта", ВидыШаблонов.НайтиПоЗначению("Email").Представление);
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьКонтекстныеШаблоны", Ложь);
	
	Для каждого ВидШаблона Из ВидыШаблонов Цикл
		Элементы.ШаблонДляФильтр.СписокВыбора.Добавить(ВидШаблона.Значение, ВидШаблона.Представление);
	КонецЦикла;
	
	Элементы.НазначениеФильтр.СписокВыбора.Добавить("", НСтр("ru = 'Все'"));
	
	Список.Параметры.УстановитьЗначениеПараметра(ШаблоныСообщенийКлиентСервер.ИдентификаторОбщий(),
		ШаблоныСообщенийКлиентСервер.ИдентификаторОбщий());
	Элементы.НазначениеФильтр.СписокВыбора.Добавить(ШаблоныСообщенийКлиентСервер.ИдентификаторОбщий(), 
		ШаблоныСообщенийКлиентСервер.ОбщийПредставление());
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ШаблоныСообщений.Назначение КАК Назначение,
		|	ШаблоныСообщений.ПолноеИмяТипаПараметраВводаНаОсновании КАК ПолноеИмяТипаПараметраВводаНаОсновании
		|ИЗ
		|	Справочник.ШаблоныСообщений КАК ШаблоныСообщений
		|ГДЕ
		|	ШаблоныСообщений.Назначение <> """" И ШаблоныСообщений.Назначение <> ""Служебный""
		|	И ШаблоныСообщений.Назначение <> &Общий
		|
		|СГРУППИРОВАТЬ ПО
		|	ШаблоныСообщений.Назначение, ШаблоныСообщений.ПолноеИмяТипаПараметраВводаНаОсновании
		|
		|УПОРЯДОЧИТЬ ПО
		|	Назначение";
	
	Запрос.УстановитьПараметр("Общий", ШаблоныСообщенийКлиентСервер.ИдентификаторОбщий());
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	
	ПриОпределенииНастроек =  ШаблоныСообщенийСлужебныйПовтИсп.ПриОпределенииНастроек();
	ПредметыШаблонов = ПриОпределенииНастроек.ПредметыШаблонов;
	Пока РезультатЗапроса.Следующий() Цикл
		НайденнаяСтрока = ПредметыШаблонов.Найти(РезультатЗапроса.ПолноеИмяТипаПараметраВводаНаОсновании, "Имя");
		Представление = ?( НайденнаяСтрока <> Неопределено, НайденнаяСтрока.Представление, РезультатЗапроса.Назначение);
		
		Элементы.НазначениеФильтр.СписокВыбора.Добавить(РезультатЗапроса.ПолноеИмяТипаПараметраВводаНаОсновании, Представление);
	КонецЦикла;
	
	Назначение = "";
	ШаблонДля = НСтр("ru = 'Электронных писем и SMS'");
	
КонецПроцедуры

&НаСервере
Процедура СпрятатьЭлементыКогдаНедоступнаОднаИзПодсистем()
	
	Элементы.ШаблонДляФильтр.Видимость                = Ложь;
	Элементы.ШаблонДля.Видимость                      = Ложь;
	АвтоЗаголовок                                     = Ложь;
	Элементы.ФормаГруппаСоздать.Вид = ВидГруппыФормы.ГруппаКнопок;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.УсловноеОформление.Элементы.Очистить();
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка.ВладелецШаблона");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	
	//
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Назначение.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Назначение");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = ШаблоныСообщенийКлиентСервер.ИдентификаторОбщий();
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", ШаблоныСообщенийКлиентСервер.ОбщийПредставление());
	
	//
	ПриОпределенииНастроек =  ШаблоныСообщенийСлужебныйПовтИсп.ПриОпределенииНастроек();
	ПредметыШаблонов = ПриОпределенииНастроек.ПредметыШаблонов;
	
	Для каждого ПредметШаблона Из ПредметыШаблонов Цикл
	
		Элемент = Список.УсловноеОформление.Элементы.Добавить();
		
		ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Назначение.Имя);
		
		ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Назначение");
		ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ОтборЭлемента.ПравоеЗначение = ПредметШаблона.Имя;
		
		Элемент.Оформление.УстановитьЗначениеПараметра("Текст", ПредметШаблона.Представление);
	
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
