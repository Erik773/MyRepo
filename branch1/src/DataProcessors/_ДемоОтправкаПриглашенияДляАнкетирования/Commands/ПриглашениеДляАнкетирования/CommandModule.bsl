///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Шаблон = ШаблонСообщенияПоВладельцу(ПараметрКоманды);
	
	ПараметрыОткрытия          = ШаблоныСообщенийКлиент.ПараметрыФормы(ПараметрыВыполненияКоманды);
	ПараметрыОткрытия.Владелец = ПараметрыВыполненияКоманды.Источник;
	
	ШаблоныСообщенийКлиент.ПоказатьФормуШаблона(Шаблон, ПараметрыОткрытия);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  ВладелецШаблона - ДокументСсылка.НазначениеОпросов
//
&НаСервере
Функция ШаблонСообщенияПоВладельцу(ВладелецШаблона)

	Шаблон = ШаблоныСообщений.ПараметрыШаблона(ВладелецШаблона);
	Если ЗначениеЗаполнено(Шаблон.Ссылка) Тогда
		Возврат ВладелецШаблона;
	Иначе
		ЗаполнитьШаблоны(Шаблон, ВладелецШаблона);
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьШаблоны(Шаблон, ВладелецШаблона)
	
	Шаблон.Наименование = НСтр("ru = 'Приглашение для анкетирования по теме'") +" """ + ВладелецШаблона.Наименование + """";
	Шаблон.Тема = НСтр("ru = 'Опрос по теме [НазначениеОпросов.Наименование]'");
	
	Шаблон.Текст = НСтр("ru = '<P>Здравствуйте, <P>Приглашаем принять участие в опросе по теме [НазначениеОпросов.Наименование]'")
		+ НСтр("ru='<P><P>Опрос будет открыт для участия [НазначениеОпросов.ДатаНачала{ДЛФ=''DD''}]'")
		+ НСтр("ru = 'Чтобы начать опрос, пожалуйста, нажмите ссылку внизу.'")
		+ НСтр("ru = '<BR/> [ОбщиеРеквизиты.АдресПубликацииИнформационнойБазыВИнтернете]'")
		+ НСтр("ru = '<P><P>Благодарим за участие в опросе.'")
		+ НСтр("ru = '<P><P>[ОбщиеРеквизиты.ОсновнаяОрганизация]'")
		+ НСтр("ru = '<P>[ОбщиеРеквизиты.ТекущийПользователь.ФизическоеЛицо]'")
		+ НСтр("ru = '<P>[ОбщиеРеквизиты.ТекущийПользователь.Телефон]'")
		+ НСтр("ru = '<P>[ОбщиеРеквизиты.ТекущийПользователь.Электронная почта]'");
	
	Шаблон.ФорматПисьма = Перечисления.СпособыРедактированияЭлектронныхПисем.HTML;
	Шаблон.ПолноеИмяТипаНазначения = "Документ.НазначениеОпросов";
	
КонецПроцедуры

#КонецОбласти