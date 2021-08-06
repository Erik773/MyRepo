///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаменитьВоВсехМестахИспользования(Команда)
	МассивСсылок = Элементы.Список.ВыделенныеСтроки;
	Если МассивСсылок.Количество() = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Выберите договор'"));
		Возврат;
	КонецЕсли;
	ПоискИУдалениеДублейКлиент.ЗаменитьВыделенные(МассивСсылок);
КонецПроцедуры

#КонецОбласти