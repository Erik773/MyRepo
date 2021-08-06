///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция ПредставлениеФайла(ИмяФайла, РазмерФайла) Экспорт

	ОбъектФС = Новый Файл(ИмяФайла);
	Возврат СтрШаблон("%1 (%2)", ОбъектФС.Имя, ПредставлениеРазмераФайла(РазмерФайла));

КонецФункции

Функция ПредставлениеРазмераФайла(РазмерФайла) Экспорт
	
	Если РазмерФайла < 1024 Тогда
		Результат = СтрШаблон(НСтр("ru = '%1 байт'"), РазмерФайла);
	ИначеЕсли РазмерФайла < 1024 * 1024 Тогда
		Результат = СтрШаблон(НСтр("ru = '%1 Кб'"), Формат(РазмерФайла / 1024, "ЧДЦ=0"));
	ИначеЕсли РазмерФайла < 1024 * 1024 * 1024 Тогда
		Результат = СтрШаблон(НСтр("ru = '%1 Мб'"), Формат(РазмерФайла / 1024 / 1024, "ЧДЦ=0"));
	Иначе
		Результат = СтрШаблон(НСтр("ru = '%1 Гб'"), Формат(РазмерФайла / 1024 / 1024 / 1024, "ЧДЦ=0"));
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция РазмерПорцииОбработки(РазмерФайла) Экспорт
	
	Если РазмерФайла > 100 * 1024 * 1024 Тогда
		Результат = 10 * 1024 * 1024;
	ИначеЕсли РазмерФайла > 10 * 1024 * 1024 Тогда
		Результат = 1024 * 1024;
	Иначе
		Результат = Окр(РазмерФайла / 10);
	КонецЕсли;
	
	Возврат Макс(Результат, 1);
	
КонецФункции

Функция МаксимальныйРазмерВременногоХранилища() Экспорт

	Возврат 4 * 1024 * 1024 * 1024;

КонецФункции

Функция ПриемлемыйРазмерВременногоХранилища() Экспорт

	Возврат 100 * 1024 * 1024;

КонецФункции

#КонецОбласти