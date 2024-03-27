unit CircleButton;

interface

uses
  windows, SysUtils, Classes, Controls, Graphics, StdCtrls;

type
  TCircleButton = class(TCustomControl)
    private const
      DEFAULT_BORDER_COLOR = $00ffffff;
    private
     FBorderColor: TColor;
     FHeight: Integer;
     FCaption: TCaption;
     FAlignment: TAlignment;
     procedure SetBorderColor(Color: TColor);
     procedure SetAlignment(Alignment: TAlignment);
     procedure SetCaption(const Caption: TCaption);
    protected
      procedure Paint; override;
    public
      constructor Create(AOwner: TComponent); override;
    published
      property Color;
      property Caption read FCaption write SetCaption;
      property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
      property Font;
      property BorderColor: TColor read FBorderColor write SetBorderColor default DEFAULT_BORDER_COLOR;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TestP', [TCircleButton]);
end;

constructor TCircleButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable, csPannable];
  FBorderColor := DEFAULT_BORDER_COLOR;
  FAlignment := taCenter;
end;

procedure TCircleButton.Paint;
var
  r: TRect;
  coefW, coefH: Integer;
const
  Alignments: array[TAlignment] of integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
  inherited;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Brush.Color := FBorderColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.Ellipse(0, 0, ClientWidth, ClientHeight);

  Canvas.Brush.Color := FBorderColor;
  Canvas.Font.Assign(Self.Font);
  r := Rect(0, 0, ClientWidth, ClientHeight);
  Canvas.Brush.Style := bsClear;
  DrawText(Canvas.Handle,
    PChar(Caption),
    length(Caption),
    r,
    DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS or Alignments[FAlignment]);
end;

procedure TCircleButton.SetAlignment(Alignment: TAlignment);
begin
  if FAlignment <> Alignment then
  begin
    FAlignment := Alignment;
    Invalidate;
  end;
end;

procedure TCircleButton.SetBorderColor(Color: TColor);
begin
  if FBorderColor <> BorderColor then
  begin
    FBorderColor := BorderColor;
    Invalidate;
  end;
end;

procedure TCircleButton.SetCaption(const Caption: TCaption);
begin
  if not SameStr(FCaption, Caption) then
  begin
    FCaption := Caption;
    Invalidate;
  end;
end;
end.
