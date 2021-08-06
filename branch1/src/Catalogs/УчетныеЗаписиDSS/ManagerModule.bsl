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

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	НеРедактируемыеРеквизиты.Добавить("Логин");
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

// СтандартныеПодсистемы.ВариантыОтчетов

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.СостояниеУчетнойЗаписиDSS) Тогда
		Команда = КомандыОтчетов.Добавить();
		Команда.Представление      = НСтр("ru = 'Состояние учетной записи'");
		Команда.МножественныйВыбор = Ложь;
		Команда.Обработчик		   = "СервисКриптографииDSSКлиент.ПоказатьОтчетСостояниеУчетнойЗаписи";
		Команда.ИмяПараметраФормы  = "УчетнаяЗапись";
		Команда.РежимЗаписи        = "ЗаписыватьТолькоНовые";
		Команда.Менеджер           = "Отчет.СостояниеУчетнойЗаписиDSS";
		Команда.РежимЗаписи		   = "Запись";
	КонецЕсли;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЭтоАвторизованныйПользователь(Автор)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если НЕ (ЭлектроннаяПодпись.ИспользоватьЭлектронныеПодписи() ИЛИ ЭлектроннаяПодпись.ИспользоватьШифрование()) Тогда
		СтандартнаяОбработка = Ложь;
		ВызватьИсключение НСтр("ru = 'Не включен режим использования электронной подписи'");
		
	ИначеЕсли НЕ ЭлектроннаяПодписьСлужебный.ИспользоватьСервисОблачнойПодписи() Тогда
		СтандартнаяОбработка = Ложь;
		ВызватьИсключение СервисКриптографииDSSСлужебный.ПолучитьОписаниеОшибки(Неопределено, "ПодсистемаОтключена");
		
	ИначеЕсли ВидФормы = "ФормаОбъекта" Тогда
		СтандартнаяОбработка = Ложь;
		Если Параметры.Свойство("Ключ") Тогда
			ВыбраннаяФорма = Метаданные.Обработки.УправлениеПодключениемDSS.Формы.ФормаУчетнойЗаписи;
		Иначе
			ВыбраннаяФорма = Метаданные.Обработки.УправлениеПодключениемDSS.Формы.ФормаУчетнойЗаписи;
		КонецЕсли;
		
	ИначеЕсли ВидФормы = "ФормаВыбора" Тогда
		СтандартнаяОбработка = Ложь;
		ВыбраннаяФорма = Метаданные.Обработки.УправлениеПодключениемDSS.Формы.ВыборУчетнойЗаписи;
		
	ИначеЕсли ВидФормы = "ФормаСписка" Тогда
		СтандартнаяОбработка = Ложь;
		ВыбраннаяФорма = Метаданные.Обработки.УправлениеПодключениемDSS.Формы.СписокУчетныхЗаписей;
		
	КонецЕсли;	
	
КонецПроцедуры

Функция ПолучитьДанныеСсылки(СсылкаСправочника) Экспорт
	
	Результат = Новый Структура("Владелец, Логин");
	
	Если НЕ СервисКриптографииDSSСлужебный.ПроверитьПраво("УчетныеЗаписиDSS") Тогда
		Возврат Результат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	УчетныеЗаписиDSS.Владелец КАК Владелец,
	|	УчетныеЗаписиDSS.Логин КАК Логин,
	|	УчетныеЗаписиDSS.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.УчетныеЗаписиDSS КАК УчетныеЗаписиDSS
	|ГДЕ
	|	УчетныеЗаписиDSS.Ссылка = &СсылкаСправочника";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("СсылкаСправочника", СсылкаСправочника);
	Выборка	= Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции	

#КонецОбласти

#КонецЕсли

