///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоОбменСБиблиотекойСтандартныхПодсистем".

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистемЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("_ДемоОбменСБиблиотекойСтандартныхПодсистем", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистемЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("_ДемоОбменСБиблиотекойСтандартныхПодсистем", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистемЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоОбменСБиблиотекойСтандартныхПодсистем", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистемЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("_ДемоОбменСБиблиотекойСтандартныхПодсистем", Источник, Отказ);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоОбменСБиблиотекойСтандартныхПодсистем225".

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистем225ЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("_ДемоОбменСБиблиотекойСтандартныхПодсистем225", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистем225ЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("_ДемоОбменСБиблиотекойСтандартныхПодсистем225", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистем225ЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоОбменСБиблиотекойСтандартныхПодсистем225", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением.
//
Процедура _ДемоОбменСБиблиотекойСтандартныхПодсистем225ЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("_ДемоОбменСБиблиотекойСтандартныхПодсистем225", Источник, Отказ);
	
КонецПроцедуры


//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоОбменВРаспределеннойИнформационнойБазе".

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюКонстанты.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьИзменениеКонстанты(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюКонстанты("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьИзменениеНабораЗаписейРасчетаПередЗаписью(Источник, Отказ, Замещение, ТолькоЗапись, ЗаписьФактическогоПериодаДействия, ЗаписьПерерасчетов) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением.
//
Процедура _ДемоОбменВРаспределеннойИнформационнойБазеЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("_ДемоОбменВРаспределеннойИнформационнойБазе", Источник, Отказ);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоОбменБезИспользованияПравилКонвертации".

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью.
//
Процедура _ДемоОбменБезИспользованияПравилКонвертацииЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("_ДемоОбменБезИспользованияПравилКонвертации", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоОбменБезИспользованияПравилКонвертацииЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоОбменБезИспользованияПравилКонвертации", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением.
//
Процедура _ДемоОбменБезИспользованияПравилКонвертацииЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("_ДемоОбменБезИспользованияПравилКонвертации", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента.
//
Процедура _ДемоОбменБезИспользованияПравилКонвертацииЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("_ДемоОбменБезИспользованияПравилКонвертации", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоАвтономнаяРабота".

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("_ДемоАвтономнаяРабота", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("_ДемоАвтономнаяРабота", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюКонстанты.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьИзменениеКонстанты(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюКонстанты("_ДемоАвтономнаяРабота", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоАвтономнаяРабота", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьИзменениеНабораЗаписейРасчетаПередЗаписью(Источник, Отказ, Замещение, ТолькоЗапись, ЗаписьФактическогоПериодаДействия, ЗаписьПерерасчетов) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоАвтономнаяРабота", Источник, Отказ, Замещение);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением.
//
Процедура _ДемоАвтономнаяРаботаЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("_ДемоАвтономнаяРабота", Источник, Отказ);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////
// Обработчики событий подписок для плана обмена "_ДемоСинхронизацияДанныхЧерезУниверсальныйФормат".

// Процедура-обработчик события "ПередЗаписью" ссылочных типов данных (кроме документов) для механизма регистрации
// объектов на узлах.
//
// Параметры:
//  ИмяПланаОбмена - Строка - имя плана обмена, для которого выполняется механизм регистрации.
//  Источник       - источник события, кроме типа ДокументОбъект.
//  Отказ          - Булево - флаг отказа от выполнения обработчика.
// 
Процедура _ДемоСинхронизацияДанныхЧерезУниверсальныйФорматЗарегистрироватьИзменение(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью(
		"_ДемоСинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ);
	
КонецПроцедуры

// Процедура-обработчик события "ПередЗаписью" документов для механизма регистрации объектов на узлах.
//
// Параметры:
//  ИмяПланаОбмена - Строка - имя плана обмена, для которого выполняется механизм регистрации.
//  Источник       - ДокументОбъект - источник события.
//  Отказ          - Булево - флаг отказа от выполнения обработчика.
// 
Процедура _ДемоСинхронизацияДанныхЧерезУниверсальныйФорматЗарегистрироватьИзменениеДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента(
		"_ДемоСинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Процедура-обработчик события "ПередУдалением" ссылочных типов данных для механизма регистрации объектов на узлах.
//
// Параметры:
//  ИмяПланаОбмена - Строка - имя плана обмена, для которого выполняется механизм регистрации.
//  Источник       - источник события.
//  Отказ          - Булево - флаг отказа от выполнения обработчика.
// 
Процедура _ДемоСинхронизацияДанныхЧерезУниверсальныйФорматЗарегистрироватьУдаление(Источник, Отказ) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением(
		"_ДемоСинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ);
	
КонецПроцедуры

// Описание см. в ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра.
//
Процедура _ДемоСинхронизацияДанныхЧерезУниверсальныйФорматЗарегистрироватьИзменениеНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. подписка используется в механизме обмена данными,
	// который в ходе загрузке данных в базу регистрирует эти данные к выгрузке на других узлах плана обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("_ДемоСинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ, Замещение);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////
// Служебные процедуры для целей автоматизированного тестирования обменов.

Процедура ПроверкаНегативногоСценария(УзелКорреспондента, НегативныйСценарий = "", ДополнительныеПараметры = Неопределено) Экспорт
	
	Если Не ЗначениеЗаполнено(УзелКорреспондента) Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеПараметры = Неопределено Тогда
		ДополнительныеПараметры = Новый Структура;
	КонецЕсли;
	
	НегативныйСценарийУзлаОбмена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УзелКорреспондента, "НегативныйСценарий");
	Если СтрНайти(НегативныйСценарийУзлаОбмена, НегативныйСценарий) = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Если НегативныйСценарий = "ОшибкаГлобальногоОбработчика" Тогда
		ВызватьИсключение НСтр("ru = 'Проверка ошибки глобального обработчика.'");
	ИначеЕсли НегативныйСценарий = "ОшибкаОбработчикаПОД" Тогда
		ВызватьИсключение НСтр("ru = 'Проверка ошибки обработчика ПОД.'");
	ИначеЕсли НегативныйСценарий = "ОшибкаОбработчикаПКО" Тогда
		ВызватьИсключение НСтр("ru = 'Проверка ошибки обработчика ПКО.'");
	ИначеЕсли НегативныйСценарий = "ОшибкаПроверкиЗаполнения"
		И ДополнительныеПараметры.Свойство("ДокументОбъект")
		И ДополнительныеПараметры.ДокументОбъект <> Неопределено Тогда
		// Очистка обязательного реквизита документа.
		ДополнительныеПараметры.ДокументОбъект.Организация = Неопределено;
	ИначеЕсли НегативныйСценарий = "ОшибкаОтложенногоЗаполненияПТиУ"
		И ДополнительныеПараметры.Свойство("ДокументОбъект")
		И ДополнительныеПараметры.ДокументОбъект <> Неопределено Тогда
		ДополнительныеПараметры.ДокументОбъект.ДополнительныеСвойства.Вставить("ОшибкаОтложенногоЗаполненияПТиУ", Истина);
	ИначеЕсли НегативныйСценарий = "ПроверкаЗначенияНаСоответствиеФасетуПеречисления" Тогда
		ДополнительныеПараметры.Вставить("СтавкаНДС", "НесуществующаяСтавкаНДС");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
