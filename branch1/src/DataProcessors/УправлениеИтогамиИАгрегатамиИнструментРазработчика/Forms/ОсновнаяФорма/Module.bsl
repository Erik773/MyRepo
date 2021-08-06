///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИтогиИАгрегатыСброситьДаты(Команда)
	ИтогиИАгрегатыСброситьДатыСервер();
	Если Открыта() Тогда
		Закрыть();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИтогиИАгрегатыСброситьДатыСервер()
	ПараметрыИтогов = Новый Структура;
	ПараметрыИтогов.Вставить("ЕстьРегистрыИтогов", Истина);
	ПараметрыИтогов.Вставить("ДатаРасчетаИтогов",  ДобавитьМесяц(ТекущаяДатаСеанса(), -12)); // Прошлый год
	
	УправлениеИтогамиИАгрегатамиСлужебный.ЗаписатьПараметрыИтоговИАгрегатов(ПараметрыИтогов);
КонецПроцедуры

#КонецОбласти
