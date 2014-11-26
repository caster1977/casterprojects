unit CastersPackage.uTStatusBarEx;

interface

uses
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ComCtrls;

type
  TStatusBarExOption = (sboeShowHint, sboeShowImage, sboeShowProgress);

  TStatusBarExOptions = set of TStatusBarExOption;

type
  TStatusBarEx = class(TStatusBar)
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Height default 20;

  strict private
    FOptions: TStatusBarExOptions;
    function GetOptions: TStatusBarExOptions;
    procedure SetOptions(const AValue: TStatusBarExOptions);
  published
    property Options: TStatusBarExOptions read GetOptions write SetOptions default [];

  strict private
    FImagePanelIndex: Integer;
    function GetImagePanelIndex: Integer;
    procedure SetImagePanelIndex(const AValue: Integer);
  published
    property ImagePanelIndex: Integer read GetImagePanelIndex write SetImagePanelIndex default 0;

  strict private
    FProgressPanelIndex: Integer;
    function GetProgressPanelIndex: Integer;
    procedure SetProgressPanelIndex(const AValue: Integer);
  published
    property ProgressPanelIndex: Integer read GetProgressPanelIndex write SetProgressPanelIndex default 1;

  strict private
    FHintPanelIndex: Integer;
    function GetHintPanelIndex: Integer;
    procedure SetHintPanelIndex(const AValue: Integer);
  published
    property HintPanelIndex: Integer read GetHintPanelIndex write SetHintPanelIndex default 2;

  strict private
    FOldApplicationOnHint: TNotifyEvent;
  public
    procedure ApplicationOnHint(Sender: TObject);
  end;

procedure Register;

implementation

// {$R *.dcr}

uses
  Vcl.Forms,
  Vcl.Controls,
  System.Types,
  Winapi.Windows,
  Winapi.CommCtrl,
  CastersPackage.uTHackControl;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TStatusBarEx]);
end;

procedure TStatusBarEx.ApplicationOnHint(Sender: TObject);
var
  s: string;
begin
  if not(csDesigning in ComponentState) then
  begin
    s := GetLongHint(Application.Hint);
    if SimplePanel then
    begin
      SimpleText := s;
    end
    else
    begin
      if (HintPanelIndex > -1) and (HintPanelIndex < Panels.Count) then
      begin
        Panels[HintPanelIndex].Text := GetLongHint(Application.Hint);
      end;
    end;
  end;
end;

constructor TStatusBarEx.Create(AOwner: TComponent);
begin
  inherited;
  FOldApplicationOnHint := Application.OnHint;
  Application.OnHint := ApplicationOnHint;
  Height := 20;
  FOptions := [];
  FImagePanelIndex := 0;
  FProgressPanelIndex := 1;
  FHintPanelIndex := 2;
end;

destructor TStatusBarEx.Destroy;
begin
  Application.OnHint := FOldApplicationOnHint;
  inherited;
end;

function TStatusBarEx.GetHintPanelIndex: Integer;
begin
  Result := FHintPanelIndex;
end;

function TStatusBarEx.GetImagePanelIndex: Integer;
begin
  Result := FImagePanelIndex;
end;

function TStatusBarEx.GetOptions: TStatusBarExOptions;
begin
  Result := FOptions;
end;

function TStatusBarEx.GetProgressPanelIndex: Integer;
begin
  Result := FProgressPanelIndex;
end;

procedure TStatusBarEx.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
  end;
end;

procedure TStatusBarEx.SetHintPanelIndex(const AValue: Integer);
begin
  if FHintPanelIndex <> AValue then
  begin
    FHintPanelIndex := AValue;
  end;
end;

procedure TStatusBarEx.SetImagePanelIndex(const AValue: Integer);
begin
  if FImagePanelIndex <> AValue then
  begin
    FImagePanelIndex := AValue;
  end;
end;

procedure TStatusBarEx.SetOptions(const AValue: TStatusBarExOptions);
begin
  if FOptions <> AValue then
  begin
    FOptions := AValue;
    if (sboeShowImage in FOptions) or (sboeShowProgress in FOptions) then
    begin
      SimplePanel := False;
    end;
    if sboeShowImage in FOptions then
    begin
      while Pred(Panels.Count) < ImagePanelIndex do
      begin
        Panels.Add;
      end;
      Panels[ImagePanelIndex].Alignment := taCenter;
      Panels[ImagePanelIndex].Width := 20;
      Panels[ImagePanelIndex].Style := psText;
    end;
    if sboeShowProgress in FOptions then
    begin
      while Pred(Panels.Count) < ProgressPanelIndex do
      begin
        Panels.Add;
      end;
      Panels[ImagePanelIndex].Alignment := taCenter;
      Panels[ImagePanelIndex].Width := 100;
      Panels[ImagePanelIndex].Style := psText;
    end;
    if sboeShowHint in FOptions then
    begin
      while Pred(Panels.Count) < HintPanelIndex do
      begin
        Panels.Add;
      end;
      Panels[ImagePanelIndex].Alignment := taLeftJustify;
      Panels[ImagePanelIndex].Style := psText;
    end;
  end;
end;

procedure TStatusBarEx.SetProgressPanelIndex(const AValue: Integer);
begin
  if FProgressPanelIndex <> AValue then
  begin
    FProgressPanelIndex := AValue;
  end;
end;

end.
