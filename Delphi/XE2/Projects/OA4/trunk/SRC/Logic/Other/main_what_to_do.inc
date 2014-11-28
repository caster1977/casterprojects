
// переделать процедуры реакции на выделение элементов списков организаций и мероприятий
// переделать проверку на ошибки при запросах

//Написать обработку прогрессбара во всех выпадающих списках
//добавить курсор с часами во всех нужных местах проги

// !!!! "завернуть" выполнение запросов в условие проверки ошибки!!! в некоторых случаях ошибочно вынесен за границы условия!!!

//          if Configuration.bDataPanelHalfWidth then
//            pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2
//          else pnlData.Width:=Configuration.iDataPanelWidth;
//
//          if Configuration.bOrgPanelHalfHeight then
//            pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2
//          else pnlOrgLV.Height:=Configuration.iOrgPanelHeight;
//  DEFAULT_ORGPANELHEIGHT=200; доделать сохранение высоты и ширины панелей после изменения их размеров при помощи сплиттера

//      int prevScrollPos = 0;
//			SCROLLINFO currentInfo = new SCROLLINFO();
//			currentInfo.cbSize = Marshal.SizeOf(currentInfo);
//			currentInfo.fMask = (int)ScrollInfoMask.SIF_ALL;
//
//			GetScrollInfo(this.Handle, (int)ScrollBarDirection.SB_VERT, ref currentInfo)
//				prevScrollPos = currentInfo.nPos;
//
//			//The LVM_SCROLL message will take a delta-x and delta-y which tell the list view how
//			//much to scroll, relative to the current scroll positions. We are given the scroll
//			//position as an absolute position, so some adjustments are necessary:
//			scrollPos -= prevScrollPos;


// при установке окна по центру экрана слетают группы в списке организаций

// сделать поиск по таблице времени работы

// !!! не корректно отрабатывает вызов функции ListView_EnsureVisible(

// добавить в запрос условие на поиск по типу телефона

// запрос для выборки "битых" телефонов, в которых ссылка phn_owner_id не соответствует реальной
//SELECT phn_id, phn_owner_id, org_id
//	FROM minsk.otdel
//	LEFT JOIN rne4._phn ON phn_otdel_id=otdel_id
//	LEFT JOIN rne4._org ON org_firm_code=otdel.firm_code
//WHERE phn_owner_is_measure="0" AND phn_owner_id!=org_id;

//UPDATE rne4._phn SET phn_owner_id= WHERE phn_id=;

// перелопатить процедуры импорта и чистки базы исходя из нового алгоритмя работы

// добавить поиск и вывод данных по деятельности фирм

// добавить передачу строк лога при наличии запущенного АРМ 109

// реализовать возможность отравки сообщений пользователей на единый сервер

// дописать механику настроек поднлючения к БД сообщений и лог-клиента

// добавить в reOrgOtherInfo данные из поля "комментарий"
