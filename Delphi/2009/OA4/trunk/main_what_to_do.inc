
// ���������� ��������� ������� �� ��������� ��������� ������� ����������� � �����������
// ���������� �������� �� ������ ��� ��������

//�������� ��������� ������������ �� ���� ���������� �������
//�������� ������ � ������ �� ���� ������ ������ �����

// !!!! "���������" ���������� �������� � ������� �������� ������!!! � ��������� ������� �������� ������� �� ������� �������!!!

//          if Configuration.bDataPanelHalfWidth then
//            pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2
//          else pnlData.Width:=Configuration.iDataPanelWidth;
//
//          if Configuration.bOrgPanelHalfHeight then
//            pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2
//          else pnlOrgLV.Height:=Configuration.iOrgPanelHeight;
//  DEFAULT_ORGPANELHEIGHT=200; �������� ���������� ������ � ������ ������� ����� ��������� �� �������� ��� ������ ���������

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


// ��� ��������� ���� �� ������ ������ ������� ������ � ������ �����������

// ������� ����� �� ������� ������� ������

// !!! �� ��������� ������������ ����� ������� ListView_EnsureVisible(

// �������� � ������ ������� �� ����� �� ���� ��������

// ������ ��� ������� "�����" ���������, � ������� ������ phn_owner_id �� ������������� ��������
//SELECT phn_id, phn_owner_id, org_id
//	FROM minsk.otdel
//	LEFT JOIN rne4._phn ON phn_otdel_id=otdel_id
//	LEFT JOIN rne4._org ON org_firm_code=otdel.firm_code
//WHERE phn_owner_is_measure="0" AND phn_owner_id!=org_id;

//UPDATE rne4._phn SET phn_owner_id= WHERE phn_id=;

// ������������ ��������� ������� � ������ ���� ������ �� ������ ��������� ������

// �������� ����� � ����� ������ �� ������������ ����

// �������� �������� ����� ���� ��� ������� ����������� ��� 109

// ����������� ����������� ������� ��������� ������������� �� ������ ������

// �������� �������� �������� ����������� � �� ��������� � ���-�������

// �������� � reOrgOtherInfo ������ �� ���� "�����������"