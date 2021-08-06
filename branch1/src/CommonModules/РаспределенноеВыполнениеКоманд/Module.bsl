///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types

#Область ПрограммныйИнтерфейс

// Вызывает команду указанной дополнительной обработки и передает в нее параметры,
// регистрирует сообщение для МС с результатами выполнения.
// Важно! Вызывается как фоновое задание.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИдентификаторОбработки - Строка - указывает на обработку, команду которой нужно выполнить.
//  ИдентификаторКоманды - Строка - имя команды (как оно задано в обработке), которую нужно выполнить.
//  ИдентификаторОперации - Строка - позволяет идентифицировать отдельные вызовы (например, для логирования).
//  СообщитьМенеджеру - Булево - указывает на необходимость сообщить Менеджеру сервиса о результате выполнения команды.
//
Процедура ВыполнитьКомандуДополнительнойОбработки(ИдентификаторОбработки, ИдентификаторКоманды, ИдентификаторОперации, СообщитьМенеджеру = Ложь) Экспорт
КонецПроцедуры 

// Вызывает команду передачи файла из текущей области данных в любую другую область 
// данных сервиса.
// Важно! Если какой-либо из параметров передан некорректно, вызывается исключение.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИмяФайла - Строка - полное имя к передаваемому файлу.
//  КодПолучателя - Число - код области данных, куда нужно передать файл.
//  БыстраяПередача - Булево - указывает, что необходимо использовать быстрые сообщения для передачи файла. 
//  ПараметрыВызова - Структура - дополнительные параметры вызова:
//    * Код - Число - код ответа,
//    * Тело - Строка - тело ответа.
//
// Возвращаемое значение:
//   УникальныйИдентификатор - идентификатор вызова.
//
Функция ВыполнитьПередачуФайлаПриложению(ИмяФайла, КодПолучателя, БыстраяПередача = Ложь, ПараметрыВызова = Неопределено) Экспорт
КонецФункции

// Отправляет области-получателю сообщение-квитанцию о получении (завершении обработки,
// и так далее) ранее полученного файла.
// Важно! Если какой-либо из параметров передан некорректно, вызывается исключение.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИдентификаторВызова - УникальныйИдентификатор - ранее выданный функцией ВыполнитьПередачуФайлаПриложению
//  КодПолучателя - Число - код области данных, куда нужно передать квитанцию.
//  БыстраяПередача - Булево - указывает, что необходимо использовать быстрые сообщения для передачи файла. 
//  ПараметрыВызова - Структура - дополнительные параметры вызова:
//    * Код - Число - код ответа,
//    * Тело - Строка - тело ответа.
//
Процедура ВыслатьКвитанциюПередачиФайла(ИдентификаторВызова, КодПолучателя, БыстраяПередача = Ложь, ПараметрыВызова = Неопределено) Экспорт
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков
// @skip-warning ПустойМетод - особенность реализации.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт 
КонецПроцедуры

#КонецОбласти