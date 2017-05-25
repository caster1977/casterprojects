unit Utils.Modules.UEOUpdater.Logic.Classes.TPresenterMain;

interface

uses
  Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceOldFile,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceNewFile, Utils.Modules.UEOUpdater.Logic.Interfaces.IPresenterMain,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IViewMain,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceDestinationFolder,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceDestinationFile, Utils.Modules.UEOUpdater.Logic.TViewEnumEvent, System.SysUtils,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItems;

type
  TPresenterMain = class(TInterfacedObject, IPresenterMain)
  strict private
    FOldFileName: string;
    FNewFileName: string;
    FDestinationFolderName: string;
    FView: IViewMain;
    FOldItems: IModelItems;
    FNewItems: IModelItems;
    FServiceOldFile: IServiceOldFile;
    FServiceNewFile: IServiceNewFile;
    FServiceDestinationFolder: IServiceDestinationFolder;
    FProcessign: Boolean;
    procedure OnEventSimple(aValue: TViewEnumEvent);

  public
    constructor Create(const aView: IViewMain; const aOldItems, aNewItems: IModelItems; const aServiceOldFile: IServiceOldFile;
      const aServiceNewFile: IServiceNewFile; const aServiceDestinationFolder: IServiceDestinationFolder); reintroduce;
  end;

implementation

uses
  System.StrUtils, Vcl.Forms, Winapi.ShellAPI, Winapi.Windows, System.IOUtils, Utils.Modules.UEOUpdater.Logic.TViewEnumAction,
  Utils.Modules.UEOUpdater.Logic.Classes.TServiceDestinationFile, Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItem,
  Utils.Modules.UEOUpdater.Logic.Classes.TModelItem, System.Math;

constructor TPresenterMain.Create(const aView: IViewMain; const aOldItems, aNewItems: IModelItems; const aServiceOldFile: IServiceOldFile;
  const aServiceNewFile: IServiceNewFile; const aServiceDestinationFolder: IServiceDestinationFolder);
begin
  Assert(Assigned(aView));
  Assert(Assigned(aServiceOldFile));
  Assert(Assigned(aServiceNewFile));
  inherited Create();
  FProcessign := False;
  FView := aView;
  FView.SetOnEventSimple(OnEventSimple);
  FView.StorePresenter(Self);
  FOldItems := aOldItems;
  FNewItems := aNewItems;
  FServiceOldFile := aServiceOldFile;
  FServiceNewFile := aServiceNewFile;
  FServiceDestinationFolder := aServiceDestinationFolder;
end;

procedure TPresenterMain.OnEventSimple(aValue: TViewEnumEvent);
  procedure OpenOld;
  var
    s: string;
  begin
    s := FServiceOldFile.GetName(FView.Control);
    if FServiceOldFile.Check(s) then
    begin
      FView.OldFileName := s;
      FOldFileName := s;
      FOldItems.FileName := s;
    end;
  end;

  procedure OpenNew;
  var
    s: string;
  begin
    s := FServiceNewFile.GetName(FView.Control);
    if FServiceNewFile.Check(s) then
    begin
      FView.NewFileName := s;
      FNewFileName := s;
      FNewItems.FileName := s;
    end;
  end;

  procedure ChooseDestinationFolder();
  var
    s: string;
  begin
    s := FServiceDestinationFolder.GetName(FView.Control);
    if TDirectory.Exists(s) then
    begin
      FView.DestinationFolderName := s;
      FDestinationFolderName := s;
    end;
  end;

  procedure OpenResult();
  var
    tmpHandle: THandle;
  begin
    tmpHandle := FView.Control.Handle;
    ShellExecute(tmpHandle, 'Open', PWideChar(FDestinationFolderName), nil, nil, SW_SHOWNORMAL);
  end;

  procedure StartUpdate;
  begin
    FView.ActionStates[vaStart] := (not FProcessign) and FServiceOldFile.Check(FOldFileName) and FServiceNewFile.Check(FNewFileName) and
      FServiceDestinationFolder.Check(FDestinationFolderName);
  end;

  procedure OpenResultUpdate;
  begin
    FView.ActionStates[vaOpenResult] := FServiceDestinationFolder.Check(FDestinationFolderName) and (not FProcessign);
  end;

  procedure ChooseDestinationFolderUpdate;
  begin
    FView.ActionStates[vaChooseDestinationFolder] := not FProcessign;
  end;

  procedure OpenNewUpdate;
  begin
    FView.ActionStates[vaOpenNew] := not FProcessign;
  end;

  procedure OpenOldUpdate;
  begin
    FView.ActionStates[vaOpenOld] := not FProcessign;
  end;

  procedure StartExecute();
  var
    tmpLine: string;
    tmpArray: TArray<string>;
    tmpItemArray: TArray<IModelItem>;
    tmpModelItem: IModelItem;
    tmpServiceDestinationFile: IServiceDestinationFile;
    s: string;
    i: Integer;
    bFounded: Boolean;
    tmpFormatSettings: TFormatSettings;

    function Calculate(aA, aB, aC: string): string;
    var
      iA, iB, iC, iLen: Int64;
    begin
      // получаем максимальное количество знаков после зап€той
      iLen := Max(Max(aA.Length - aA.LastIndexOf('.') - 1, aB.Length - aB.LastIndexOf('.') - 1), aC.Length - aC.LastIndexOf('.') - 1);
      // приводим все строки к найденному количеству знаков, убираем символ дес€тичного разделит€ и преобразуем к длинному целому
      iA := StrToInt64(aA.Replace('.', '') + StringOfChar('0', iLen - (aA.Length - aA.LastIndexOf('.') - 1)));
      iB := StrToInt64(aB.Replace('.', '') + StringOfChar('0', iLen - (aB.Length - aB.LastIndexOf('.') - 1)));
      iC := StrToInt64(aC.Replace('.', '') + StringOfChar('0', iLen - (aC.Length - aC.LastIndexOf('.') - 1)));
      Result := IntToStr(iA + (iB - iC)); // проводим вычислени€
      Result := Result.Insert(Result.Length - iLen, '.'); // преобразуем в строку и вставл€ем дес€тичный разделитель
    end;

  begin
    tmpFormatSettings := TFormatSettings.Create('ru-RU');
    tmpFormatSettings.DecimalSeparator := '.';
    FProcessign := True;
    try
      FView.RefreshStates();
      try
        tmpServiceDestinationFile := TServiceDestinationFile.Create();
        s := IncludeTrailingPathDelimiter(FDestinationFolderName);
        tmpServiceDestinationFile.Open(ChangeFileExt(ChangeFilePath(FNewFileName, s), '.csv'));

        FView.ShowProgress('«агрузка старого файла...', 3);
        FServiceOldFile.LoadData(FOldItems);
        FView.StepProgress('ќбработка нового файла...');
        try
          FServiceNewFile.Open(FNewFileName);
          try
            while not FServiceNewFile.Eof do
            begin
              Application.ProcessMessages();
              tmpArray := FServiceNewFile.ReadLine().Split([';']);
              if Length(tmpArray) = 10 then
              begin
                tmpModelItem := TModelItem.Create(tmpArray);
                tmpArray := tmpModelItem.AsArray();
                if FOldItems.Items.TryGetValue(tmpModelItem.A, tmpItemArray) or FOldItems.Items.TryGetValue(tmpModelItem.B, tmpItemArray) then
                begin
                  for i := 0 to Pred(Length(tmpItemArray)) do
                  begin
                    if Assigned(tmpItemArray[i]) then
                    begin
                      if (tmpItemArray[i].C <> tmpModelItem.C) or (tmpItemArray[i].D <> tmpModelItem.D) or (tmpItemArray[i].E <> tmpModelItem.E) then
                      begin
                        Continue;
                      end
                      else
                      begin
                        if tmpModelItem.G <> tmpItemArray[i].J then
                        begin
                          tmpModelItem.K := tmpItemArray[i].J;
                          tmpModelItem.M := Calculate(tmpModelItem.i, tmpItemArray[i].J, tmpModelItem.G);
                          tmpArray := tmpModelItem.AsArray();
                        end;
                        Break;
                      end;
                    end;
                  end;
                end;
              end;
              tmpLine := string.Join(';', tmpArray);
              tmpServiceDestinationFile.WriteLine(tmpLine);
            end;
          finally
            FServiceNewFile.Close();
          end;
        finally
          FView.StepProgress();
        end;
        FView.ShowProgress('«агрузка нового файла...', 3);
        FServiceOldFile.LoadData(FNewItems);
        FView.StepProgress('ќбработка старого файла...');
        try
          FServiceNewFile.Open(FOldFileName);
          try
            while not FServiceNewFile.Eof do
            begin
              bFounded := True;
              Application.ProcessMessages();
              tmpArray := FServiceNewFile.ReadLine().Split([';']);

              if Length(tmpArray) <> 10 then
              begin
                Continue;
              end;

              tmpModelItem := TModelItem.Create(tmpArray);
              tmpArray := tmpModelItem.AsArray();

              if StrToFloat(tmpModelItem.J, tmpFormatSettings) = 0 then
              begin
                Continue;
              end;

              if not FNewItems.Items.TryGetValue(tmpModelItem.A, tmpItemArray) then
              begin
                bFounded := False;
              end
              else
              begin
                bFounded := False;
                for i := 0 to Pred(Length(tmpItemArray)) do
                begin
                  if Assigned(tmpItemArray[i]) then
                  begin
                    if (tmpItemArray[i].B = tmpModelItem.B) and (tmpItemArray[i].C = tmpModelItem.C) and (tmpItemArray[i].D = tmpModelItem.D) and
                      (tmpItemArray[i].E = tmpModelItem.E) then
                    begin
                      bFounded := True;
                      Break;
                    end;
                  end;
                end;
              end;

              if not bFounded then
              begin
                tmpModelItem.K := tmpModelItem.J;
                tmpModelItem.L := '0';
                tmpModelItem.M := tmpModelItem.J;
                tmpModelItem.N := '0';
                tmpModelItem.G := '';
                tmpModelItem.H := '';
                tmpModelItem.i := '';
                tmpModelItem.J := '';
                tmpArray := tmpModelItem.AsArray();
                tmpLine := string.Join(';', tmpArray);
                tmpServiceDestinationFile.WriteLine(tmpLine);
              end;

            end;
          finally
            FServiceNewFile.Close();
          end;
        finally
          FView.StepProgress();
        end;
      finally
        FView.HideProgress();
      end;
    finally
      FProcessign := False;
    end;
  end;

begin
  case aValue of
    veOpenOldExecute:
      OpenOld();
    veOpenOldUpdate:
      OpenOldUpdate();
    veOpenNewExecute:
      OpenNew();
    veOpenNewUpdate:
      OpenNewUpdate();
    veChooseDestinationFolderExecute:
      ChooseDestinationFolder();
    veChooseDestinationFolderUpdate:
      ChooseDestinationFolderUpdate();
    veOpenResultExecute:
      OpenResult();
    veOpenResultUpdate:
      OpenResultUpdate();
    veStartExecute:
      StartExecute();
    veStartUpdate:
      StartUpdate();
  end;
end;

end.
