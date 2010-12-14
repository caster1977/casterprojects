unit AddEditPhone;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  CheckLst,
  Buttons,
  mysql,
  Main,
  Grids;

type
  TAddEditPhoneForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    pnlID: TPanel;
    lblIDCaption: TLabel;
    lblPhoneID: TLabel;
    Bevel4: TBevel;
    pnlModification: TPanel;
    Label3: TLabel;
    lblPhoneModifiedAt: TLabel;
    Bevel1: TBevel;
    mePhoneComments: TMemo;
    Panel3: TPanel;
    lblPhoneNumber: TLabel;
    edbxPhoneNumber: TEdit;
    lblPhoneType: TLabel;
    cmbbxPhoneType: TComboBox;
    lblPhoneComments: TLabel;
    lblPhoneCompared: TLabel;
    dtpPhoneCompared: TDateTimePicker;
    edbxPhonePriority: TEdit;
    lblPhonePriority: TLabel;
    procedure edbxPhoneNumberExit(Sender: TObject);
    procedure edbxPhonePriorityEnter(Sender: TObject);
    procedure edbxPhonePriorityExit(Sender: TObject);
    procedure edbxPhonePriorityChange(Sender: TObject);
    procedure edbxPhonePriorityKeyPress(Sender: TObject; var Key: Char);
    procedure edbxPhoneNumberChange(Sender: TObject);
    procedure mePhoneCommentsExit(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  end;

var
  AddEditPhoneForm: TAddEditPhoneForm;

implementation

{$R *.dfm}

function StringIsNumeric(aString: string): boolean; // функция проверки, состоит ли строка-источник из цифровых символов
var
  i: integer;
  b: boolean;
begin
  b:=True; // изначальная инициализация переменной значениеем "правда"
  for i:=1 to Length(aString) do // в цикле производим перебор всех символов строки-источника
    begin
      if not CharInSet(aString[i], ['0'..'9']) then // если очередной символ не является цифрой
        b:=False; // то присваиваем переменной значение "ложь"
    end;
  Result:=b; // возвращаем результат функции
end;

procedure TAddEditPhoneForm.btnClearClick(Sender: TObject); // процедура-обработчик нажатия кнопки "Очистить"
// выполняет очистку всех "полей ввода" и помещает курсор в поле ввода номера телефона
var
  GroupGUID: string;
begin
  GroupGUID:='{62C2C08D-089E-4C00-AC4C-D742606ADA05}';
  MainForm.Set_Busy(GroupGUID); // включаем индикатор "занятости"
  Screen.Cursor:=crHourGlass; // делаем курсор в форме песочных часов
  Application.ProcessMessages; // обрабатывем накопившиеся системные сообщения
  dtpPhoneCompared.Date:=EncodeDate(1900, 01, 01); // очищаем поле "Сверен"
  mePhoneComments.Clear; // очищаем поле "Комментарии"
  edbxPhoneNumber.Clear; // очищаем поле "Номер телефона"
  // при очистке поля "Номер телефона" срабатывает процедура-обработчик
  // в итоге поле ввода "Тип телефона" сбрасывается в на элемент с пустым значением
  edbxPhoneNumber.SetFocus; // помещаем курсор ввода в поле "Номер телефона"
  Screen.Cursor:=crDefault; // делаем нормальный курсор
  MainForm.Set_Ready(GroupGUID); // включаем индикатор готовности
  Application.ProcessMessages; // обрабатывем накопившиеся системные сообщения
end;

procedure TAddEditPhoneForm.edbxPhoneNumberChange(Sender: TObject);
var
  sPhone: string; // переменная для хранения значения "очищенной" от символов-разделителей строки с номером телефона
begin
  sPhone:= // получаем очищенную от символов-разделителей строку с номером телефона
    StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(edbxPhoneNumber.Text, ' ', '', [rfReplaceAll]), // очищаем от пробелов
    '(', '', [rfReplaceAll]), // от круглых скобок
    ')', '', [rfReplaceAll]), '-', '', [rfReplaceAll]), // от знаков минуса
    '+', '', [rfReplaceAll]), // от знаков плюса
    '[', '', [rfReplaceAll]), // от квадратных скобок
    ']', '', [rfReplaceAll]);
  if StringIsNumeric(sPhone) then // если строка состоит из цифр
    begin
      if (Pos('2', sPhone)=1)and(Length(sPhone)=Length('2')+6) then // производим отбор городских телефонов на 2
        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('стационарный')
      else
        if (Pos('3', sPhone)=1)and(Length(sPhone)=Length('3')+6) then // производим отбор городских телефонов на 3
          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('стационарный')
        else
          if (Pos('5', sPhone)=1)and(Length(sPhone)=Length('5')+6) then // производим отбор пригородных телефонов на 5
            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('стационарный')
          else
            if (Pos('375255', sPhone)=1)and(Length(sPhone)=Length('375255')+6) then // производим отбор телефонов БеСТ
              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
            else
              if (Pos('80255', sPhone)=1)and(Length(sPhone)=Length('80255')+6) then
                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
              else
                if (Pos('0255', sPhone)=1)and(Length(sPhone)=Length('0255')+6) then
                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                else
                  if (Pos('00255', sPhone)=1)and(Length(sPhone)=Length('00255')+6) then
                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                  else
                    if (Pos('375256', sPhone)=1)and(Length(sPhone)=Length('375256')+6) then // производим отбор телефонов БеСТ
                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                    else
                      if (Pos('80256', sPhone)=1)and(Length(sPhone)=Length('80256')+6) then
                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                      else
                        if (Pos('0256', sPhone)=1)and(Length(sPhone)=Length('0256')+6) then
                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                        else
                          if (Pos('00256', sPhone)=1)and(Length(sPhone)=Length('00256')+6) then
                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                          else
                            if (Pos('375257', sPhone)=1)and(Length(sPhone)=Length('375257')+6) then // производим отбор телефонов БеСТ
                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                            else
                              if (Pos('80257', sPhone)=1)and(Length(sPhone)=Length('80257')+6) then
                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                              else
                                if (Pos('0257', sPhone)=1)and(Length(sPhone)=Length('0257')+6) then
                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                else
                                  if (Pos('00257', sPhone)=1)and(Length(sPhone)=Length('00257')+6) then
                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                  else
                                    if (Pos('375259', sPhone)=1)and(Length(sPhone)=Length('375259')+6) then // производим отбор телефонов БеСТ
                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                    else
                                      if (Pos('80259', sPhone)=1)and(Length(sPhone)=Length('80259')+6) then
                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                      else
                                        if (Pos('0259', sPhone)=1)and(Length(sPhone)=Length('0259')+6) then
                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                        else
                                          if (Pos('00259', sPhone)=1)and(Length(sPhone)=Length('00259')+6) then
                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (life:)/БеСТ)')
                                          else
                                            if (Pos('375294', sPhone)=1)and(Length(sPhone)=Length('375294')+6) then // производим отбор телефонов БелСел
                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Diallog/БелСел)')
                                            else
                                              if (Pos('80294', sPhone)=1)and(Length(sPhone)=Length('80294')+6) then
                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Diallog/БелСел)')
                                              else
                                                if (Pos('0294', sPhone)=1)and(Length(sPhone)=Length('0294')+6) then
                                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Diallog/БелСел)')
                                                else
                                                  if (Pos('00294', sPhone)=1)and(Length(sPhone)=Length('00294')+6) then
                                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Diallog/БелСел)')
                                                  else
                                                    if (Pos('375297', sPhone)=1)and(Length(sPhone)=Length('375297')+6) then // производим отбор телефонов МТС
                                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                    else
                                                      if (Pos('80297', sPhone)=1)and(Length(sPhone)=Length('80297')+6) then
                                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                      else
                                                        if (Pos('0297', sPhone)=1)and(Length(sPhone)=Length('0297')+6) then
                                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                        else
                                                          if (Pos('00297', sPhone)=1)and(Length(sPhone)=Length('00297')+6) then
                                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                          else
                                                            if (Pos('375295', sPhone)=1)and(Length(sPhone)=Length('375295')+6) then
                                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                            else
                                                              if (Pos('80295', sPhone)=1)and(Length(sPhone)=Length('80295')+6) then
                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                              else
                                                                if (Pos('0295', sPhone)=1)and(Length(sPhone)=Length('0295')+6) then
                                                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                else
                                                                  if (Pos('00295', sPhone)=1)and(Length(sPhone)=Length('00295')+6) then
                                                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                  else
                                                                    if (Pos('375292', sPhone)=1)and(Length(sPhone)=Length('375292')+6) then
                                                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                    else
                                                                      if (Pos('80292', sPhone)=1)and(Length(sPhone)=Length('80292')+6) then
                                                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                      else
                                                                        if (Pos('0292', sPhone)=1)and(Length(sPhone)=Length('0292')+6) then
                                                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                        else
                                                                          if (Pos('00292', sPhone)=1)and(Length(sPhone)=Length('00292')+6) then
                                                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                          else
                                                                            if (Pos('375298', sPhone)=1)and(Length(sPhone)=Length('375298')+6) then
                                                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                            else
                                                                              if (Pos('80298', sPhone)=1)and(Length(sPhone)=Length('80298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                              else
                                                                                if (Pos('0298', sPhone)=1)and(Length(sPhone)=Length('0298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('00298', sPhone)=1)and(Length(sPhone)=Length('00298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('37533', sPhone)=1)and(Length(sPhone)=Length('37533')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('8033', sPhone)=1)and(Length(sPhone)=Length('8033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('033', sPhone)=1)and(Length(sPhone)=Length('033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('0033', sPhone)=1)and(Length(sPhone)=Length('0033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (МТС)')
                                                                                else
                                                                                if (Pos('375296', sPhone)=1)and(Length(sPhone)=Length('375296')+6) then // производим отбор телефонов МЦС
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('80296', sPhone)=1)and(Length(sPhone)=Length('80296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('0296', sPhone)=1)and(Length(sPhone)=Length('0296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('00296', sPhone)=1)and(Length(sPhone)=Length('00296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('375293', sPhone)=1)and(Length(sPhone)=Length('375293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('80293', sPhone)=1)and(Length(sPhone)=Length('80293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('0293', sPhone)=1)and(Length(sPhone)=Length('0293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('00293', sPhone)=1)and(Length(sPhone)=Length('00293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('375291', sPhone)=1)and(Length(sPhone)=Length('375291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('80291', sPhone)=1)and(Length(sPhone)=Length('80291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('0291', sPhone)=1)and(Length(sPhone)=Length('0291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('00291', sPhone)=1)and(Length(sPhone)=Length('00291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('375299', sPhone)=1)and(Length(sPhone)=Length('375299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('80299', sPhone)=1)and(Length(sPhone)=Length('80299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('0299', sPhone)=1)and(Length(sPhone)=Length('0299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('00299', sPhone)=1)and(Length(sPhone)=Length('00299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('37544', sPhone)=1)and(Length(sPhone)=Length('37544')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('8044', sPhone)=1)and(Length(sPhone)=Length('8044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('044', sPhone)=1)and(Length(sPhone)=Length('044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                if (Pos('0044', sPhone)=1)and(Length(sPhone)=Length('0044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('мобильный (Velcom/МЦС)')
                                                                                else
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('');
    end
  else
    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf(''); // если строка состоит не из цифр
end;

procedure TAddEditPhoneForm.edbxPhoneNumberExit(Sender: TObject);
begin
  edbxPhoneNumber.Text:=StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(Trim(edbxPhoneNumber.Text), '  ', ' ', [rfReplaceAll]), // убираем двойные пробелы
    ' ', '-', [rfReplaceAll]), // заменяем пробелы на тире
    '(', '-', [rfReplaceAll]), // от круглых скобок
    ')', '-', [rfReplaceAll]), ' -', '-', [rfReplaceAll]), // очищаем от пробелов
    '- ', '-', [rfReplaceAll]), // очищаем от пробелов
    '--', '-', [rfReplaceAll]), // очищаем от лишних тире
    '--', '-', [rfReplaceAll]); // очищаем от лишних тире
  if edbxPhoneNumber.Text>'' then // если в начале или конце строки найдены птире - удаляем
    while CharInSet(edbxPhoneNumber.Text[1], ['-', ',', '.']) do
      edbxPhoneNumber.Text:=copy(edbxPhoneNumber.Text, 2, Length(edbxPhoneNumber.Text)-1);
  if edbxPhoneNumber.Text>'' then
    while CharInSet(edbxPhoneNumber.Text[Length(edbxPhoneNumber.Text)], ['-', ',', '.']) do
      edbxPhoneNumber.Text:=copy(edbxPhoneNumber.Text, 1, Length(edbxPhoneNumber.Text)-1);
end;

procedure TAddEditPhoneForm.edbxPhonePriorityChange(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, 0)<0 then
    edbxPhonePriority.Text:='0';
  if StrToIntDef(edbxPhonePriority.Text, 0)>254 then
    edbxPhonePriority.Text:='254';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityEnter(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, -1)=-1 then
    edbxPhonePriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityExit(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, -1)=-1 then
    edbxPhonePriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TAddEditPhoneForm.mePhoneCommentsExit(Sender: TObject); // процедура-обработчик поети фокуса полем ввода "Комментарии"
begin
  if MainForm.CurrentUser.bDBEdition then // если пользователь имеет права редактирования БД
    mePhoneComments.Text:=ValidateString(mePhoneComments.Text); // то выполняем валидацию значения строки поля ввода "Комментария"
end;

end.
