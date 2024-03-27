unit RoundPanel;

interface

uses
  windows, SysUtils, Classes, Controls, Graphics;

type
  TRoundPanel = class(TCustomControl) //»ли TCustomPanel с ExtCtrls
  private const
    DEFAULT_BORDER_COLOR = $00ffffff;
    DEFAULT_CLIENT_COLOR = clWindow;
    DEFAULT_ROUNDING = 0;
  private
    { Private declarations }
    FBorderColor: TColor;
    FBackgroundColor: TColor;
    FRoundingByWidth: integer;
    FRoundingByHeight: integer;
    FAlignment: TAlignment;
    procedure SetBorderColor(BorderColor: TColor);
    procedure SetBackgroundColor(Color: TColor);
    procedure SetRoundingByWidth(RWidth: integer);
    procedure SetRoundingByHeight(RHeight: integer);
    procedure SetAlignment(Alignment: TAlignment);
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Color;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Font;
    property BorderColor: TColor read FBorderColor write SetBorderColor default DEFAULT_BORDER_COLOR;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default DEFAULT_CLIENT_COLOR;
    property RoundingByWidth: integer read FRoundingByWidth write SetRoundingByWidth default DEFAULT_ROUNDING;
    property RoundingByHeight: integer read FRoundingByHeight write SetRoundingByHeight default DEFAULT_ROUNDING;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TestP', [TRoundPanel]);
end;

constructor TRoundPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable, csPannable];
  FBorderColor := DEFAULT_BORDER_COLOR;
  FBackgroundColor := DEFAULT_CLIENT_COLOR;
  FRoundingByWidth := DEFAULT_ROUNDING;
  FRoundingByHeight := DEFAULT_ROUNDING;
  FAlignment := taCenter;
end;

procedure TRoundPanel.Paint;
var
  r: TRect;
  coefW, coefH: Integer;
const
  Alignments: array[TAlignment] of integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
  inherited;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Brush.Style := bsSolid;
  coefW:= Round(FRoundingByWidth);
  coefH:= Round(FRoundingByHeight);
  Canvas.RoundRect(0,0, ClientWidth, ClientHeight, coefW, coefH);
end;

procedure TRoundPanel.SetAlignment(Alignment: TAlignment);
begin
  if FAlignment <> Alignment then
  begin
    FAlignment := Alignment;
    Invalidate;
  end;
end;

procedure TRoundPanel.SetBorderColor(BorderColor: TColor);
begin
  if FBorderColor <> BorderColor then
  begin
    FBorderColor := BorderColor;
    Invalidate;
  end;
end;

procedure TRoundPanel.SetRoundingByWidth(RWidth: integer);
begin
  if FRoundingByWidth <> RWidth then
  begin
    FRoundingByWidth := RWidth;
    Invalidate;
  end;
end;

procedure TRoundPanel.SetRoundingByHeight(RHeight: integer);
begin
  if FRoundingByHeight <> RHeight then
  begin
    FRoundingByHeight := RHeight;
    Invalidate;
  end;
end;

procedure TRoundPanel.SetBackgroundColor(Color: TColor);
begin
  if FBackgroundColor <> Color then
  begin
    FBackgroundColor := Color;
    Invalidate;
  end;
end;

end.
