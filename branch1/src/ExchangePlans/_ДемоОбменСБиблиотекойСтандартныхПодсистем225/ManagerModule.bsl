///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ОбменДанными

// Заполняет настройки, влияющие на использование плана обмена.
// 
// Параметры:
//  Настройки - см. ОбменДаннымиСервер.НастройкиПланаОбменаПоУмолчанию
//
Процедура ПриПолученииНастроек(Настройки) Экспорт
	
	// В демонстрационной конфигурации значение хранится в константе
	// _ДемоИмяКонфигурацииВОбменеСБиблиотекойСтандартныхПодсистем.
	// Это связано с необходимостью настройки обмена между идентичными конфигурациями "БСП-БСП".
	// Для настройки обмена между различными конфигурациями функция должна возвращать константное значение.
	ИмяКонфигурацииИсточника = Константы._ДемоИмяКонфигурацииВОбменеСБиблиотекойСтандартныхПодсистем.Получить();
	Настройки.ИмяКонфигурацииИсточника = ?(ПустаяСтрока(ИмяКонфигурацииИсточника),
		Метаданные.Имя, ИмяКонфигурацииИсточника);
		
	Настройки.ИмяКонфигурацииПриемника.Вставить("БиблиотекаСтандартныхПодсистемДемо");
	
	Настройки.ПредупреждатьОНесоответствииВерсийПравилОбмена = Истина;
	
	Настройки.Алгоритмы.ПриПолученииВариантовНастроекОбмена   = Истина;
	Настройки.Алгоритмы.ПриПолученииОписанияВариантаНастройки = Истина;
	
	Настройки.Алгоритмы.ПредставлениеОтбораИнтерактивнойВыгрузки     = Истина;
	Настройки.Алгоритмы.НастроитьИнтерактивнуюВыгрузку               = Истина;
	Настройки.Алгоритмы.НастроитьИнтерактивнуюВыгрузкуВМоделиСервиса = Истина;
	
	Настройки.Алгоритмы.ОбработчикПроверкиПараметровУчета = Истина;
	
	Настройки.Алгоритмы.ПриПодключенииККорреспонденту     = Истина;
	Настройки.Алгоритмы.ПриПолученииДанныхОтправителя     = Истина;
	
КонецПроцедуры

// Заполняет коллекцию вариантов настроек, предусмотренных для плана обмена.
// 
// Параметры:
//  ВариантыНастроекОбмена - см. ОбменДаннымиСервер.КоллекцияВариантовНастроекОбмена
//  ПараметрыКонтекста     - см. ОбменДаннымиСервер.ПараметрыКонтекстаПолученияВариантовНастроек
//
Процедура ПриПолученииВариантовНастроекОбмена(ВариантыНастроекОбмена, ПараметрыКонтекста) Экспорт
	
	ВариантНастройки = ВариантыНастроекОбмена.Добавить();
	ВариантНастройки.ИдентификаторНастройки        = "Двухсторонний";
	ВариантНастройки.КорреспондентВМоделиСервиса   = Истина;
	ВариантНастройки.КорреспондентВЛокальномРежиме = Истина;
	
КонецПроцедуры

// Заполняет набор параметров, определяющих вариант настройки обмена.
// 
// Параметры:
//  ОписаниеВарианта       - см. ОбменДаннымиСервер.ОписаниеВариантаНастройкиОбменаПоУмолчанию
//  ИдентификаторНастройки - Строка - идентификатор варианта настройки обмена.
//  ПараметрыКонтекста     - см. ОбменДаннымиСервер.ПараметрыКонтекстаПолученияОписанияВариантаНастройки
//
Процедура ПриПолученииОписанияВариантаНастройки(ОписаниеВарианта, ИдентификаторНастройки, ПараметрыКонтекста) Экспорт
	
	КраткаяИнформацияПоОбмену = "";
	Если ИдентификаторНастройки = "ТолькоОтправка" Тогда
		КраткаяИнформацияПоОбмену = НСтр("ru = 'Позволяет отправлять данные в программу 1С:Библиотека стандартных подсистем, версия 2.2.5.'");
	ИначеЕсли ИдентификаторНастройки = "ТолькоПолучение" Тогда
		КраткаяИнформацияПоОбмену = НСтр("ru = 'Позволяет получать данные из программы 1С:Библиотека стандартных подсистем, версия 2.2.5.'");
	ИначеЕсли ИдентификаторНастройки = "Двухсторонний" Тогда
		КраткаяИнформацияПоОбмену = НСтр("ru = 'Позволяет синхронизировать данные с программой 1С:Библиотека стандартных подсистем, версия 2.2.5.'");
	КонецЕсли;
	КраткаяИнформацияПоОбмену = КраткаяИнформацияПоОбмену + Символы.ПС
		+ НСтр("ru = 'Демонстрируется поддержка обратной совместимости, когда одна из программ разработана на базе текущей редакции, а другая - на предыдущей версии 2.2.5.'");
	
	ПодробнаяИнформацияПоОбмену = ?(ОбщегоНазначения.РазделениеВключено(),
		"https://its.1c.ru/bmk/bsp/synch_prog",
		"ПланОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем225.Форма.ПодробнаяИнформация");
	
	ОписаниеВарианта.КраткаяИнформацияПоОбмену   = КраткаяИнформацияПоОбмену;
	ОписаниеВарианта.ПодробнаяИнформацияПоОбмену = ПодробнаяИнформацияПоОбмену;
	
	ОписаниеВарианта.ИмяКонфигурацииКорреспондента          = "БиблиотекаСтандартныхПодсистемДемо225";
	ОписаниеВарианта.НаименованиеКонфигурацииКорреспондента = НСтр("ru = '1С:Библиотека стандартных подсистем, редакция 2.2.5'");
	
	ОписаниеВарианта.ИмяФайлаНастроекДляПриемника = НСтр("ru = 'Настройки синхронизации для БСП'");
	
	ОписаниеВарианта.ПутьКФайлуКомплектаПравилНаПользовательскомСайте = "https://users.v8.1c.ru/distribution/project/SSL22";
	ОписаниеВарианта.ПутьКФайлуКомплектаПравилВКаталогеШаблонов       = "1c\SSL\";
	
	ЗаголовокКоманды   = "";
	ЗаголовокПомощника = "";
	ЗаголовокУзла      = "";
	Если ИдентификаторНастройки = "ТолькоОтправка" Тогда
		
		ЗаголовокКоманды   = НСтр("ru = 'Отправка данных в ""1С:Библиотека стандартных подсистем, редакция 2.2.5""'");
		ЗаголовокПомощника = НСтр("ru = 'Отправка данных в 1С:Библиотека стандартных подсистем, редакция 2.2.5 (настройка)'");
		ЗаголовокУзла      = НСтр("ru = 'Отправка данных в 1С:Библиотека стандартных подсистем, редакция 2.2.5'");
		
	ИначеЕсли ИдентификаторНастройки = "ТолькоПолучение" Тогда
		
		ЗаголовокКоманды   = НСтр("ru = 'Получение данных из ""1С:Библиотека стандартных подсистем, редакция 2.2.5""'");
		ЗаголовокПомощника = НСтр("ru = 'Получение данных из 1С:Библиотека стандартных подсистем, редакция 2.2.5 (настройка)'");
		ЗаголовокУзла      = НСтр("ru = 'Получение данных из 1С:Библиотека стандартных подсистем, редакция 2.2.5'");
		
	ИначеЕсли ИдентификаторНастройки = "Двухсторонний" Тогда
		
		ЗаголовокКоманды   = НСтр("ru = 'Полная синхронизация с ""1С:Библиотека стандартных подсистем, редакция 2.2.5""'");
		ЗаголовокПомощника = НСтр("ru = 'Синхронизация данных с 1С:Библиотека стандартных подсистем, редакция 2.2.5 (настройка)'");
		ЗаголовокУзла      = НСтр("ru = 'Синхронизация данных с 1С:Библиотека стандартных подсистем, редакция 2.2.5'");
	КонецЕсли;
	
	ОписаниеВарианта.ЗаголовокКомандыДляСозданияНовогоОбменаДанными = ЗаголовокКоманды;
	ОписаниеВарианта.ЗаголовокПомощникаСозданияОбмена               = ЗаголовокПомощника;
	ОписаниеВарианта.ЗаголовокУзлаПланаОбмена                       = ЗаголовокУзла;
	
	ПояснениеДляНастройкиПараметровУчета = НСтр("ru = 'Требуется указать ответственных для организаций во втором приложении.
		|Для этого перейдите во второе приложение, в разделе ""Синхронизация данных"" выберите команду ""Ответственные лица организаций"".'");

	ОписаниеВарианта.ПояснениеДляНастройкиПараметровУчета = ПояснениеДляНастройкиПараметровУчета;
	
	ОписаниеВарианта.ОбщиеДанныеУзлов = "ДатаНачалаВыгрузкиДокументов, РежимВыгрузкиСправочников, "
		+ "РежимВыгрузкиСправочниковКорреспондента, РежимВыгрузкиДокументов, РежимВыгрузкиДокументовКорреспондента, "
		+ "ИспользоватьОтборПоПодразделениям, ИспользоватьОтборПоСкладам, Подразделения, Склады";

КонецПроцедуры

// Проверяет корректность настройки параметров учета.
//
// Параметры:
//  Отказ - Булево - признак невозможности продолжения настройки обмена из-за некорректно настроенных параметров учета.
//  Получатель - ПланОбменаСсылка - узел обмена, для которого выполняется проверка параметров учета.
//  Сообщение - Строка - содержит текст сообщения о некорректных параметрах учета.
//
Процедура ОбработчикПроверкиПараметровУчета(Отказ, Получатель, Сообщение) Экспорт
	
	Отбор = Неопределено;
	
	СвойстваПолучателя = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Получатель, "ИспользоватьОтборПоОрганизациям, Организации");
	
	Если СвойстваПолучателя.ИспользоватьОтборПоОрганизациям Тогда
		
		Отбор = СвойстваПолучателя.Организации.Выгрузить().ВыгрузитьКолонку("Организация");
		
	КонецЕсли;
	
	Если Не РегистрыСведений._ДемоОтветственныеЛица.ДляВсехОрганизацийНазначеныОтветственные(Отбор, Сообщение) Тогда
		
		Отказ = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

// Обработчик события при подключении к корреспонденту.
// Событие возникает при успешном подключении к корреспонденту и получении версии конфигурации корреспондента
// при настройке обмена с использованием помощника через прямое подключение
// или при подключении к корреспонденту через Интернет.
// В обработчике можно проанализировать версию корреспондента и,
// если настройка обмена не поддерживается с корреспондентом указанной версии, то вызвать исключение.
//
// Параметры:
//  ВерсияКорреспондента - Строка - версия конфигурации корреспондента, например, "2.1.5.1".
//
Процедура ПриПодключенииККорреспонденту(ВерсияКорреспондента) Экспорт
	
	Если ВерсияКорреспондента = "0.0.0.0" Тогда
		ВерсияКорреспондента = "2.0.1.1";
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияКорреспондента, "1.0.6.8") < 0 Тогда
		
		ВызватьИсключение НСтр("ru = 'Настройка синхронизации данных поддерживается только с демонстрационной конфигурацией
			|""Библиотека стандартных подсистем"" версии 1.0.6 и выше.'");
	КонецЕсли;
	
КонецПроцедуры

// Обработчик события при получении данных узла-отправителя.
// Событие возникает при получении данных узла-отправителя,
// когда данные узла прочитаны из сообщения обмена, но не записаны в информационную базу.
// В обработчике можно изменить полученные данные или вовсе отказаться от получения данных узла.
//
// Параметры:
//  Отправитель - ПланОбменаОбъект
//              - Структура - узел плана обмена, от имени которого выполняется получение данных.
//  Игнорировать - Булево - признак отказа от получения данных узла.
//							Если в обработчике установить значение этого параметра в Истина,
//							то получение данных узла выполнена не будет. Значение по умолчанию - Ложь.
//
Процедура ПриПолученииДанныхОтправителя(Отправитель, Игнорировать) Экспорт
	
	Если ТипЗнч(Отправитель) = Тип("Структура") Тогда
		
		Если Отправитель.Свойство("РежимВыгрузкиСправочников") Тогда
			ПоменятьЗначения(Отправитель, "РежимВыгрузкиСправочников", "РежимВыгрузкиСправочниковКорреспондента");
		КонецЕсли;
		
		Если Отправитель.Свойство("РежимВыгрузкиДокументов") Тогда
			ПоменятьЗначения(Отправитель, "РежимВыгрузкиДокументов", "РежимВыгрузкиДокументовКорреспондента");
		КонецЕсли;
		
	Иначе
		
		ПоменятьЗначения(Отправитель, "РежимВыгрузкиСправочников", "РежимВыгрузкиСправочниковКорреспондента");
		ПоменятьЗначения(Отправитель, "РежимВыгрузкиДокументов", "РежимВыгрузкиДокументовКорреспондента");
		
	КонецЕсли;
	
КонецПроцедуры

// Возвращает представление отбора для варианта дополнения выгрузки по сценарию узла.
// См. описание "ВариантДополнительно" в процедуре "НастроитьИнтерактивнуюВыгрузку".
//
// Параметры:
//  Получатель - ПланОбменаСсылка - узел, для которого определяется представление отбора.
//  Параметры  - Структура        - характеристики отбора. Содержит поля:
//    *ИспользоватьПериодОтбора - Булево            - флаг того, что необходимо использовать общий отбор по периоду.
//    *ПериодОтбора             - СтандартныйПериод - значение периода общего отбора.
//    *Отбор                    - ТаблицаЗначений   - содержит строки с описанием подробных отборов по сценарию узла.
//		                                                Содержит колонки:
//      *ПолноеИмяМетаданных - Строка                - полное имя метаданных регистрируемого объекта, отбор которого
//			                                               описывает строка.
//                                                         Например "Документ._ДемоПоступлениеТоваров". Могут быть
//                                                         использованы специальные  значения "ВсеДокументы" и
//                                                         "ВсеСправочники" для отбора соответственно всех документов и
//                                                         всех справочников, регистрирующихся на узле Получатель.
//      *ВыборПериода        - Булево                - флаг того, что данная строка описывает отбор с общим периодом.
//      *Период              - СтандартныйПериод     - значение периода общего отбора для метаданных строки.
//      *Отбор               - ОтборКомпоновкиДанных - поля отбора. Поля отбора формируются в соответствии с общим
//			                                               правилами формирования полей компоновки. Например, для указания
//			                                               отбора по реквизиту документа "Организация", будет использовано
//			                                               поле "Ссылка.Организация".
//
// Возвращаемое значение:
//  Строка - описание отбора
//
Функция ПредставлениеОтбораИнтерактивнойВыгрузки(Получатель, Параметры) Экспорт
	
	Если Параметры.ИспользоватьПериодОтбора Тогда
		Если ЗначениеЗаполнено(Параметры.ПериодОтбора) Тогда
			ОписаниеПериода = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'за период: %1'"), НРег(Параметры.ПериодОтбора));
		Иначе
			ДатаНачалаВыгрузки = Получатель.ДатаНачалаВыгрузкиДокументов;
			Если ЗначениеЗаполнено(ДатаНачалаВыгрузки) Тогда
				ОписаниеПериода = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'начиная с даты начала отправки документов: %1'"), Формат(ДатаНачалаВыгрузки, "ДЛФ=DD"));
			Иначе
				ОписаниеПериода = НСтр("ru = 'за весь период учета'");
			КонецЕсли;
		КонецЕсли;
	Иначе
		ОписаниеПериода = "";
	КонецЕсли;
	
	СписокОрганизаций = ОрганизацииОтбораИнтерактивнойВыгрузки(Параметры.Отбор);
	Если СписокОрганизаций.Количество()=0 Тогда
		ОписаниеОтбораОрганизации = НСтр("ru = 'по всем организациям'");
	Иначе
		ОписаниеОтбораОрганизации = "";
		Для Каждого Элемент Из СписокОрганизаций Цикл
			ОписаниеОтбораОрганизации = ОписаниеОтбораОрганизации+ ", " + Элемент.Представление;
		КонецЦикла;
		ОписаниеОтбораОрганизации = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'по организациям: %1'"), СокрЛП(Сред(ОписаниеОтбораОрганизации, 2)));
	КонецЕсли;

	Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Будут отправлены поступления товаров %1,
		         |%2'"),
		ОписаниеПериода,  ОписаниеОтбораОрганизации);
КонецФункции

// Предназначена для настройки вариантов интерактивной настройки выгрузки по сценарию узла.
// Для настройки необходимо установить значения свойств параметров в необходимые значения.
//
// Используется для контроля режимов работы помощника интерактивного обмена данными.
//
// Параметры:
//   Получатель - ПланОбменаСсылка - узел, для которого производится настройка.
//   Параметры  - см. ОбменДаннымиСервер.ОписаниеСтандартныхВариантовДополненияВыгрузки
//
Процедура НастроитьИнтерактивнуюВыгрузку(Получатель, Параметры) Экспорт
	
	// Настраиваем стандартные варианты.
	Параметры.ВариантБезДополнения.Использование     = Истина;
	Параметры.ВариантБезДополнения.Порядок           = 2;
	Параметры.ВариантВсеДокументы.Использование      = Ложь;
	Параметры.ВариантПроизвольныйОтбор.Использование = Ложь;
	
	// Настраиваем вариант дополнения по сценарию узла.
	Параметры.ВариантДополнительно.Использование  = Истина;
	Параметры.ВариантДополнительно.Порядок        = 1;
	Параметры.ВариантДополнительно.Заголовок      = НСтр("ru = 'Отправить поступления товаров по организациям:'");
	Параметры.ВариантДополнительно.Пояснение      = НСтр("ru = 'Дополнительно будут отправлены документы поступления товаров за указанный период по выбранным организациям.'");
	
	Параметры.ВариантДополнительно.ИмяФормыОтбора        = "ПланОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем225.Форма.НастройкаВыгрузки";
	Параметры.ВариантДополнительно.ЗаголовокКомандыФормы = НСтр("ru = 'Выбрать организации'");
	
	// Вычисляем и устанавливаем параметры сценария.
	ПараметрыПоУмолчанию = ПараметрыВыгрузкиПоУмолчанию(Получатель);
	
	Параметры.ВариантДополнительно.ИспользоватьПериодОтбора = Истина;
	Параметры.ВариантДополнительно.ПериодОтбора = ПараметрыПоУмолчанию.Период;
	
	// Добавляем строку настройки отбора.
	СтрокаОтбора = Параметры.ВариантДополнительно.Отбор.Добавить();
	СтрокаОтбора.ПолноеИмяМетаданных = "Документ._ДемоПоступлениеТоваров";
	СтрокаОтбора.ВыборПериода = Истина;
	СтрокаОтбора.Период       = ПараметрыПоУмолчанию.Период;
	СтрокаОтбора.Отбор        = ПараметрыПоУмолчанию.Отбор;
	
КонецПроцедуры

// Аналог НастроитьИнтерактивнуюВыгрузку для работы в модели сервиса.
//
// В текущей версии обрабатывается только использование стандартных вариантов дополнения выгрузки,
// Пользовательский сценарий, описание, расположение и т.п. не учитывается.
// 
// Если для всех вариантов флаги разрешения использования установлены в Ложь, то страница дополнения
// выгрузки в помощнике интерактивного обмена данными будет пропущена.
// 
// Параметры:
//   Получатель - ПланОбменаСсылка - узел, для которого производится настройка.
//   Параметры  - см. ОбменДаннымиСервер.ОписаниеСтандартныхВариантовДополненияВыгрузки
//
Процедура НастроитьИнтерактивнуюВыгрузкуВМоделиСервиса(Получатель, Параметры) Экспорт
	
	Параметры.ВариантБезДополнения.Использование     = Истина;
	Параметры.ВариантВсеДокументы.Использование      = Истина;
	Параметры.ВариантПроизвольныйОтбор.Использование = Истина;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ОбменДанными

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//   Массив из Строка - список имен реквизитов объекта.
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("РегистрироватьИзменения");
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает список организаций по таблице отбора (см "ПредставлениеОтбораИнтерактивнойВыгрузки").
// Также используется из демонстрационной формы "НастройкаВыгрузки" этого плана обмена.
//
// Параметры:
//  ТаблицаОтбора - ТаблицаЗначений   - содержит строки с описанием подробных отборов по сценарию узла. Содержит колонки:
//    *ПолноеИмяМетаданных - Строка.
//    *ВыборПериода        - Булево.
//    *Период              - СтандартныйПериод.
//    *Отбор               - ОтборКомпоновкиДанных.
//
// Возвращаемое значение:
//  СписокЗначений - значение - ссылка на организацию, представление - наименование.
//
Функция ОрганизацииОтбораИнтерактивнойВыгрузки(Знач ТаблицаОтбора) Экспорт
	
	Результат = Новый СписокЗначений;
	
	Если ТаблицаОтбора.Количество()=0 Или ТаблицаОтбора[0].Отбор.Элементы.Количество()=0 Тогда
		// Нет данных отбора
		Возврат Результат;
	КонецЕсли;
		
	// Мы знаем состав отбора, так как помещали туда сами - или из "НастроитьИнтерактивнуюВыгрузку"
	// или как результат редактирования в форме.
	
	СтрокаДанных = ТаблицаОтбора[0].Отбор.Элементы[0];
	Отобранные   = СтрокаДанных.ПравоеЗначение;
	
	Если ТипЗнч(Отобранные) = Тип("СписокЗначений") Тогда
		Для Каждого Элемент Из Отобранные Цикл
			ДобавитьСписокОрганизаций(Результат, Элемент.Значение);
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(Отобранные) = Тип("Массив") Тогда
		ДобавитьСписокОрганизаций(Результат, Отобранные);
		 
	ИначеЕсли ТипЗнч(Отобранные) = Тип("СправочникСсылка._ДемоОрганизации") Тогда
		Если Результат.НайтиПоЗначению(Отобранные) = Неопределено Тогда
			Результат.Добавить(Отобранные, Отобранные.Наименование);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Добавляет в список организаций коллекцию.
//
// Параметры:
//  Список      - СписокЗначений - дополняемый список.
//  Организации - Массив из СправочникСсылка._ДемоОрганизации - коллекция организаций.
// 
Процедура ДобавитьСписокОрганизаций(Список, Знач Организации)
	Для Каждого Организация Из Организации Цикл
		
		Если ТипЗнч(Организация) = Тип("Массив") Тогда
			ДобавитьСписокОрганизаций(Список, Организация);
			Продолжить;
		КонецЕсли;
		
		Если Список.НайтиПоЗначению(Организация) = Неопределено Тогда
			Список.Добавить(Организация, Организация.Наименование);
		КонецЕсли;
		
	КонецЦикла;
КонецПроцедуры

Процедура ПоменятьЗначения(Данные, Знач Свойство1, Знач Свойство2)
	
	Значение = Данные[Свойство1];
	
	Данные[Свойство1] = Данные[Свойство2];
	Данные[Свойство2] = Значение;
	
КонецПроцедуры

// Расчет параметров выгрузки по умолчанию.
//
// Параметры:
//     Получатель - ПланОбменаСсылка - узел, для которого производится настройка.
//
// Возвращаемое значение:
//   Структура:
//     ПредставлениеОтбора - Строка - текстовое описание отбора по умолчанию.
//     Период              - СтандартныйПериод     - значение периода общего отбора по умолчанию.
//     Отбор               - ОтборКомпоновкиДанных - отбор.
//
Функция ПараметрыВыгрузкиПоУмолчанию(Получатель)
	
	Результат = Новый Структура;
	
	// Период по умолчанию
	Результат.Вставить("Период", Новый СтандартныйПериод);
	Результат.Период.Вариант = ВариантСтандартногоПериода.ПрошлыйМесяц;
	
	// Отбор по умолчанию и его представление.
	КомпоновщикОтбора = Новый КомпоновщикНастроекКомпоновкиДанных;
	Результат.Вставить("Отбор", КомпоновщикОтбора.Настройки.Отбор);
	
	// Элементы, предлагаемые первый раз по умолчанию, считываем из настроек узла.
	Если Получатель.ИспользоватьОтборПоОрганизациям Тогда
		// Организации из табличной части.
		ЗапросИсточника = Новый Запрос("
			|ВЫБРАТЬ РАЗРЕШЕННЫЕ
			|	ОрганизацииПланаОбмена.Организация              КАК Организация,
			|	ОрганизацииПланаОбмена.Организация.Наименование КАК Наименование
			|ИЗ
			|	ПланОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем225.Организации КАК ОрганизацииПланаОбмена
			|ГДЕ
			|	ОрганизацииПланаОбмена.Ссылка = &Получатель
			|");
		ЗапросИсточника.УстановитьПараметр("Получатель", Получатель);
	Иначе
		// Все доступные организации
		ЗапросИсточника = Новый Запрос("
			|ВЫБРАТЬ РАЗРЕШЕННЫЕ
			|	Организации.Ссылка       КАК Организация,
			|	Организации.Наименование КАК Наименование
			|ИЗ
			|	Справочник._ДемоОрганизации КАК Организации
			|ГДЕ
			|	НЕ Организации.ПометкаУдаления
			|");
	КонецЕсли;
		
	ОтборПоОрганизацииСтрокой = "";
	КоллекцияОрганизации = Новый Массив;
	
	Выборка = ЗапросИсточника.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		КоллекцияОрганизации.Добавить(Выборка.Организация);
		ОтборПоОрганизацииСтрокой = ОтборПоОрганизацииСтрокой + ", " + Выборка.Наименование;
	КонецЦикла;
	ОтборПоОрганизацииСтрокой = СокрЛП(Сред(ОтборПоОрганизацииСтрокой, 2));
	
	ОтборПоОрганизации = Результат.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборПоОрганизации.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("Ссылка.Организация");
	ОтборПоОрганизации.ВидСравнения   = ВидСравненияКомпоновкиДанных.ВСписке;
	ОтборПоОрганизации.Использование  = Истина;
	ОтборПоОрганизации.ПравоеЗначение = КоллекцияОрганизации;
	
	// Общее представление, период не включаем, так как в этом сценарии поле периода будет редактироваться отдельно.
	Результат.Вставить("ПредставлениеОтбора", СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Будут отправлены поступления товаров по организациям:
		         |%1'"),
		ОтборПоОрганизацииСтрокой));
	
	Возврат Результат;
КонецФункции
#КонецОбласти

#КонецЕсли
