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

// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// Возвращает сведения о внешней обработке.
//
// Возвращаемое значение:
//   см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке
//
Функция СведенияОВнешнейОбработке() Экспорт
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.2.3.1");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Загрузка юридических лиц (с контактной информацией) в справочник ""Демо: Контрагенты"".'");
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = "3.0.2.2";
	
	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = НСтр("ru = 'Демо: Контрагенты (Юридические лица с контактной информацией)'");
	Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыЗагрузкаДанныхИзФайла();
	Команда.Модификатор   = Метаданные.Справочники._ДемоКонтрагенты.ПолноеИмя();
	Команда.Идентификатор = "ЮрЛицаКонтрагентов";
	
	Возврат ПараметрыРегистрации;
КонецФункции

// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

#КонецОбласти

// Определяет параметры загрузки данных из файла.
//
// Параметры:
//   ИдентификаторКоманды - Строка - имя команды, определенное в функции СведенияОВнешнейОбработке().
//   ПараметрыЗагрузки - Структура - настройки загрузки данных:
//       * ИмяМакетаСШаблоном - Строка - имя макета с шаблоном загружаемых данных.
//           По умолчанию используется макет "ЗагрузкаИзФайла".
//       * ОбязательныеКолонкиМакета - Массив - список имен колонок обязательных для заполнения.
//
Процедура ОпределитьПараметрыЗагрузкиДанныхИзФайла(ИдентификаторКоманды, ПараметрыЗагрузки) Экспорт
	Если ИдентификаторКоманды = "ЮрЛицаКонтрагентов" Тогда
		ПараметрыЗагрузки.ИмяМакетаСШаблоном = "ЗагрузкаИзФайлаКонтрагенты";
	КонецЕсли;
КонецПроцедуры

// Производит сопоставление загружаемых данных с данными в  информационной базе.
// Состав и тип колонок таблицы соответствует макету "ЗагрузкаИзФайла".
//
// Параметры:
//  ИдентификаторКоманды - Строка - имя команды, определенное в функции СведенияОВнешнейОбработке().
//  ЗагружаемыеДанные - см. ЗагрузкаДанныхИзФайла.ТаблицаСопоставления
//
Процедура СопоставитьЗагружаемыеДанныеИзФайла(ИдентификаторКоманды, ЗагружаемыеДанные) Экспорт
	
	Если ИдентификаторКоманды = "ЮрЛицаКонтрагентов" Тогда
		СопоставитьКонтрагентов(ЗагружаемыеДанные);
	КонецЕсли;
	
КонецПроцедуры

// Загружает сопоставленные данные в базу.
//
// Параметры:
//  ИдентификаторКоманды - Строка - имя команды, определенное в функции СведенияОВнешнейОбработке(). 
//  ЗагружаемыеДанные - см. ЗагрузкаДанныхИзФайла.ОписаниеЗагружаемыхДанныхДляСправочников
//  ПараметрыЗагрузки - см. ЗагрузкаДанныхИзФайла.НастройкиЗагрузкиДанных
//  Отказ - Булево    - отмена загрузки. Например, если данные некорректные.
//
Процедура ЗагрузитьИзФайла(ИдентификаторКоманды, ЗагружаемыеДанные, ПараметрыЗагрузки, Отказ) Экспорт
	Если ИдентификаторКоманды = "ЮрЛицаКонтрагентов" Тогда
		ЗаписьКонтрагентовИзФайла(ЗагружаемыеДанные, ПараметрыЗагрузки, Отказ);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  ЗагружаемыеДанные - ТаблицаЗначений:
//    * СопоставленныйОбъект - СправочникСсылка
//    * РезультатСопоставленияСтроки - Строка
//    * ОписаниеОшибки - Строка
//    * Идентификатор - Число
//    * Наименование - Строка
//
Процедура СопоставитьКонтрагентов(ЗагружаемыеДанные)
	
	Для Каждого Строка Из ЗагружаемыеДанные Цикл
		Строка.ОбъектСопоставления = Справочники._ДемоКонтрагенты.НайтиПоРеквизиту("ИНН", СокрЛП(Строка.ИНН));
		Если Строка.ОбъектСопоставления = Неопределено Тогда
			Строка.ОбъектСопоставления = Справочники._ДемоКонтрагенты.НайтиПоНаименованию(Строка.Наименование, Истина);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Параметры:
//  ЗагружаемыеДанные - ТаблицаЗначений:
//    * СопоставленныйОбъект - СправочникСсылка
//    * РезультатСопоставленияСтроки - Строка
//    * ОписаниеОшибки - Строка
//    * Идентификатор - Число
//    * Наименование - Строка
//  ПараметрыЗагрузки - Структура
//  Отказ - Булево
//
Процедура ЗаписьКонтрагентовИзФайла(ЗагружаемыеДанные, ПараметрыЗагрузки, Отказ)
	
	Для Каждого СтрокаТаблицы Из ЗагружаемыеДанные Цикл
		Если ЗначениеЗаполнено(СтрокаТаблицы.ОбъектСопоставления) Тогда
			Если Не ПараметрыЗагрузки.ОбновлятьСуществующие Тогда
				СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
				Продолжить;
			КонецЕсли;
		Иначе
			Если Не ПараметрыЗагрузки.СоздаватьНовые Тогда
				СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		НачатьТранзакцию();
		Попытка
			ЗаписатьКонтрагента(СтрокаТаблицы);
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
			СтрокаТаблицы.ОписаниеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаписатьКонтрагента(СтрокаТаблицы)
	Если Не ЗначениеЗаполнено(СтрокаТаблицы.ОбъектСопоставления) Тогда
		ЭлементСправочника = Справочники._ДемоКонтрагенты.СоздатьЭлемент();
		СтрокаТаблицы.ОбъектСопоставления = ЭлементСправочника;
		СтрокаТаблицы.РезультатСопоставленияСтроки = "Создан";
	Иначе
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Справочник._ДемоКонтрагенты");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", СтрокаТаблицы.ОбъектСопоставления);
		ИнформацияОбОшибке = Неопределено;
		Попытка
			Блокировка.Заблокировать();
		Исключение
			ИнформацияОбОшибке = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;
		Если ИнформацияОбОшибке <> Неопределено Тогда
			СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
			СтрокаТаблицы.ОписаниеОшибки =
				НСтр("ru = 'Не удалось заблокировать объект.
					|Возможно он открыт в другом окне.
					|
					|Техническая информация:'")
				+ Символы.ПС
				+ КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			Возврат;
		КонецЕсли;
		ЭлементСправочника = СтрокаТаблицы.ОбъектСопоставления.ПолучитьОбъект();
		Если ЭлементСправочника = Неопределено Тогда
			СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
			СтрокаТаблицы.ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Объект ""%1"" не существует.'"),
				СтрокаТаблицы.Наименование);
			Возврат;
		КонецЕсли;
		СтрокаТаблицы.РезультатСопоставленияСтроки = "Обновлен";
	КонецЕсли;
	
	ЭлементСправочника.Наименование = СтрокаТаблицы.Наименование;
	ЭлементСправочника.НаименованиеПолное = СтрокаТаблицы.Наименование;
	ЭлементСправочника.ВидКонтрагента = Перечисления._ДемоЮридическоеФизическоеЛицо.ЮридическоеЛицо;
	ЭлементСправочника.ИНН = СтрокаТаблицы.ИНН;
	ЭлементСправочника.КПП = СтрокаТаблицы.КПП;
	
	КонтактнаяИнформация = ЭлементСправочника.КонтактнаяИнформация.Добавить();
	КонтактнаяИнформация.АдресЭП = СтрокаТаблицы.Почта;
	КонтактнаяИнформация.Представление = СтрокаТаблицы.Почта;
	КонтактнаяИнформация.Вид = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоEmailКонтрагента");
	КонтактнаяИнформация.Тип = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты;
	
	КонтактнаяИнформация = ЭлементСправочника.КонтактнаяИнформация.Добавить();
	КонтактнаяИнформация.Представление = СтрокаТаблицы.Адрес;
	КонтактнаяИнформация.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес;
	КонтактнаяИнформация.Вид = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоАдресКонтрагента");
	
	Если Не ЭлементСправочника.ПроверитьЗаполнение() Тогда
		СтрокаТаблицы.РезультатСопоставленияСтроки = "Пропущен";
		СообщенияПользователю = ПолучитьСообщенияПользователю(Истина);
		Если СообщенияПользователю.Количество() > 0 Тогда
			
			ОписаниеОшибки = Новый Массив;
			Для Каждого СообщениеПользователю Из СообщенияПользователю Цикл
				ОписаниеОшибки.Добавить(СообщениеПользователю.Текст);
			КонецЦикла;
			СтрокаТаблицы.ОписаниеОшибки = СтрСоединить(ОписаниеОшибки, Символы.ПС + Символы.ПС);
			
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	ЭлементСправочника.Записать();
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли