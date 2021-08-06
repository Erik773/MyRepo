///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Генерирует код узла плана обмена для заданной области данных.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//   НомерОбласти - Число - значение разделителя. 
//
// Возвращаемое значение:
//   Строка - код узла плана обмена для заданной области. 
//
Функция КодУзлаПланаОбменаВСервисе(Знач НомерОбласти) Экспорт
КонецФункции

// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  Строка - наименование события.
//
Функция СобытиеЖурналаРегистрацииУдаленноеАдминистрированиеУстановитьПараметры() Экспорт
КонецФункции

#КонецОбласти