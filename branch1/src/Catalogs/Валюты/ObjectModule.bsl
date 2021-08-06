///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.РасчетПоФормуле Тогда
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	Валюты.Наименование КАК СимвольныйКод
		|ИЗ
		|	Справочник.Валюты КАК Валюты
		|ГДЕ
		|	Валюты.СпособУстановкиКурса = ЗНАЧЕНИЕ(Перечисление.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Валюты.Наименование
		|ИЗ
		|	Справочник.Валюты КАК Валюты
		|ГДЕ
		|	Валюты.СпособУстановкиКурса = ЗНАЧЕНИЕ(Перечисление.СпособыУстановкиКурсаВалюты.РасчетПоФормуле)";
		
		Запрос = Новый Запрос(ТекстЗапроса);
		ЗависимыеВалюты = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("СимвольныйКод");
		
		Для Каждого Валюта Из ЗависимыеВалюты Цикл
			Если СтрНайти(ФормулаРасчетаКурса, Валюта) > 0 Тогда
				Отказ = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ОсновнаяВалюта.ОсновнаяВалюта) Тогда
		Отказ = Истина;
	КонецЕсли;
	
	Если Отказ Тогда
		ОбщегоНазначения.СообщитьПользователю(
			НСтр("ru = 'Курс валюты можно связать только с курсом независимой валюты.'"));
	КонецЕсли;
	
	Если СпособУстановкиКурса <> Перечисления.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты Тогда
		ИсключаемыеРеквизиты = Новый Массив;
		ИсключаемыеРеквизиты.Добавить("ОсновнаяВалюта");
		ИсключаемыеРеквизиты.Добавить("Наценка");
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, ИсключаемыеРеквизиты);
	КонецЕсли;
	
	Если СпособУстановкиКурса <> Перечисления.СпособыУстановкиКурсаВалюты.РасчетПоФормуле Тогда
		ИсключаемыеРеквизиты = Новый Массив;
		ИсключаемыеРеквизиты.Добавить("ФормулаРасчетаКурса");
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, ИсключаемыеРеквизиты);
	КонецЕсли;
	
	Если Не ЭтоНовый()
		И СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты
		И РаботаСКурсамиВалют.СписокЗависимыхВалют(Ссылка).Количество() > 0 Тогда
		ОбщегоНазначения.СообщитьПользователю(
			НСтр("ru = 'Валюта не может быть подчиненной, так как она является основной для других валют.'"));
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	КурсЗагружаетсяИзИнтернета = СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.ЗагрузкаИзИнтернета;
	КурсЗависитОтДругойВалюты = СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты;
	КурсРассчитываетсяПоФормуле = СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.РасчетПоФормуле;
	
	Если ЭтоНовый() Тогда
		Если КурсЗависитОтДругойВалюты Или КурсРассчитываетсяПоФормуле Тогда
			ДополнительныеСвойства.Вставить("ОбновитьКурсы");
		КонецЕсли;
		ДополнительныеСвойства.Вставить("ЭтоНовый");
		ДополнительныеСвойства.Вставить("ЗапланироватьКопированиеКурсовВалюты");
	Иначе
		ПредыдущиеЗначения = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "Код,СпособУстановкиКурса,ОсновнаяВалюта,Наценка,ФормулаРасчетаКурса");
		
		ПоменялсяСпособУстановкиКурса = ПредыдущиеЗначения.СпособУстановкиКурса <> СпособУстановкиКурса;
		ПоменялсяКодВалюты = ПредыдущиеЗначения.Код <> Код;
		ПоменяласьОсновнаяВалюта = ПредыдущиеЗначения.ОсновнаяВалюта <> ОсновнаяВалюта;
		ПоменяласьНаценка = ПредыдущиеЗначения.Наценка <> Наценка;
		ПоменяласьФормула = ПредыдущиеЗначения.ФормулаРасчетаКурса <> ФормулаРасчетаКурса;
		
		Если (КурсЗависитОтДругойВалюты И (ПоменяласьОсновнаяВалюта Или ПоменяласьНаценка Или ПоменялсяСпособУстановкиКурса))
			Или (КурсРассчитываетсяПоФормуле И (ПоменяласьФормула Или ПоменялсяСпособУстановкиКурса)) Тогда
			ДополнительныеСвойства.Вставить("ОбновитьКурсы");
		КонецЕсли;
		
		Если КурсЗагружаетсяИзИнтернета И (ПоменялсяСпособУстановкиКурса Или ПоменялсяКодВалюты) Тогда
			ДополнительныеСвойства.Вставить("ЗапланироватьКопированиеКурсовВалюты");
		КонецЕсли;
	КонецЕсли;
	
	Если СпособУстановкиКурса <> Перечисления.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты Тогда
		ОсновнаяВалюта = Справочники.Валюты.ПустаяСсылка();
		Наценка = 0;
	КонецЕсли;
	
	Если СпособУстановкиКурса <> Перечисления.СпособыУстановкиКурсаВалюты.РасчетПоФормуле Тогда
		ФормулаРасчетаКурса = "";
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ОбновитьКурсы") И ВыполняетсяФоновыйПересчетКурсов() Тогда
		ВызватьИсключение НСтр("ru = 'Не удалось записать валюту, так как еще не завершился фоновый пересчет курсов.
			|Попробуйте записать валюту позже.'");
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ОбновитьКурсы") Тогда
		НачатьФоновоеОбновлениеКурсовВалюты();
	Иначе
		РаботаСКурсамиВалют.ПроверитьКорректностьКурсаНа01_01_1980(Ссылка);
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ЗапланироватьКопированиеКурсовВалюты") Тогда
		ЗапланироватьКопированиеКурсовВалюты();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВыполняетсяФоновыйПересчетКурсов()
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Наименование", "РаботаСКурсамиВалют.ОбновитьКурсВалюты");
	ПараметрыЗадания.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
	
	Возврат ОбщегоНазначения.ИнформационнаяБазаФайловая() 
		И ФоновыеЗадания.ПолучитьФоновыеЗадания(ПараметрыЗадания).Количество() > 0;
		
КонецФункции

Процедура НачатьФоновоеОбновлениеКурсовВалюты()
	
	ПараметрыВалюты = Новый Структура;
	ПараметрыВалюты.Вставить("ОсновнаяВалюта");
	ПараметрыВалюты.Вставить("Ссылка");
	ПараметрыВалюты.Вставить("Наценка");
	ПараметрыВалюты.Вставить("ДополнительныеСвойства");
	ПараметрыВалюты.Вставить("ФормулаРасчетаКурса");
	ПараметрыВалюты.Вставить("СпособУстановкиКурса");
	ПараметрыВалюты.Вставить("ИспользуемыеВалютыПриРасчетеКурса", ИспользуемыеВалютыПриРасчетеКурса());
	ЗаполнитьЗначенияСвойств(ПараметрыВалюты, ЭтотОбъект);
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Валюта", ПараметрыВалюты);
	ПараметрыЗадания.Вставить("КодыВалют", Справочники.Валюты.КодыВалют());
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор());
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	ПараметрыВыполнения.ЗапуститьНеВФоне = ОбновлениеИнформационнойБазы.НеобходимоОбновлениеИнформационнойБазы();
	
	Результат = ДлительныеОперации.ВыполнитьВФоне("РаботаСКурсамиВалют.ОбновитьКурсВалюты", ПараметрыЗадания, ПараметрыВыполнения);
	Если Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;

КонецПроцедуры

Процедура ЗапланироватьКопированиеКурсовВалюты()
	
	Если ОбщегоНазначения.РазделениеВключено()
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Валюты") Тогда
		МодульРаботаСКурсамиВалютСлужебный = ОбщегоНазначения.ОбщийМодуль("РаботаСКурсамиВалютСлужебный");
		МодульРаботаСКурсамиВалютСлужебный.ЗапланироватьКопированиеКурсовВалюты(ЭтотОбъект);
	КонецЕсли;

КонецПроцедуры

Функция ИспользуемыеВалютыПриРасчетеКурса()
	
	Если СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.НаценкаНаКурсДругойВалюты Тогда
		Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОсновнаяВалюта);
	КонецЕсли;
	
	Если СпособУстановкиКурса <> Перечисления.СпособыУстановкиКурсаВалюты.РасчетПоФормуле Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Валюты.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Валюты КАК Валюты
	|ГДЕ
	|	&ФормулаРасчетаКурса ПОДОБНО ""%"" + Валюты.Наименование + ""%""
	|	И Валюты.Наименование <> """"";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ФормулаРасчетаКурса", ФормулаРасчетаКурса);
	РезультатЗапроса = Запрос.Выполнить();
		
	Если РезультатЗапроса.Пустой() Тогда
		ТекстОшибки = НСтр("ru = 'В формуле должна быть использована хотя бы одна основная валюта.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстОшибки, , "Объект.ФормулаРасчетаКурса");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли