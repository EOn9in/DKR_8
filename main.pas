unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Math;

type

  { TWindow }

  TWindow = class(TForm)
    CheckBox_Hard: TCheckBox;
    CheckBox_Simple: TCheckBox;
    Fon: TImage;
    Label1: TLabel;
    Per_text: TLabel;
    Raschitat: TButton;
    Clear_Button: TButton;
    Input_sum: TEdit;
    Input_per: TEdit;
    Input_mon: TEdit;
    Sum_text: TLabel;
    Info_output: TMemo;
    Strelochki: TUpDown;
    UpDown1: TUpDown;
    procedure RaschitatClick(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);


  private

  public

  end;

var
  Window: TWindow;

implementation

{$R *.lfm}

{ TWindow }



procedure TWindow.RaschitatClick(Sender: TObject);
var
  initialSum, interestRate: Double;
  monthes:Integer;
  simpleInterest, complexInterest, totalSimple, totalComplex: Double;
begin
if (Length(Input_sum.Text) = 0) or (Length(Input_per.Text) = 0) or (Length(Input_mon.Text) = 0) then
  begin
  ShowMessage('Заполните все поля для ввода!')
  end
else
  begin
  initialSum := StrToFloat(Input_sum.Text);
  interestRate := StrToFloat(Input_per.Text) / 100;
  monthes := StrToInt(Input_mon.Text);


  simpleInterest := initialSum * interestRate * monthes;
  totalSimple := initialSum + simpleInterest;
  complexInterest := initialSum * Power(1 + interestRate, monthes) - initialSum;
  totalComplex := initialSum + complexInterest;

  if (simpleInterest < 5.0E-324) or (simpleInterest > 1.7E308) or
   (totalSimple < 5.0E-324) or (totalSimple > 1.7E308) or
    (complexInterest < 5.0E-324) or (complexInterest > 1.7E308) or
    (totalComplex < 5.0E-324) or (totalComplex > 1.7E308) then ShowMessage('Слишком большой набор входных данных')
   else
     begin


  Info_output.Lines.Clear;
  if (CheckBox_Simple.Checked = False) and (CheckBox_Hard.Checked = False) then begin ShowMessage('Необходимо поставить хотя бы одну галочку!'); end;
  if CheckBox_Simple.Checked = True then
    begin
  Info_output.Lines.Add(Format('Простые проценты: %f', [simpleInterest]));
  Info_output.Lines.Add(Format('Окончательная сумма с простыми процентами: %f', [totalSimple]));
     end;
  if CheckBox_Hard.Checked = True then
    begin
  Info_output.Lines.Add(Format('Сложные проценты: %f', [complexInterest]));
  Info_output.Lines.Add(Format('Окончательная сумма со сложными процентами: %f', [totalComplex]));
    end;
    end;
  end;
end;


procedure TWindow.Clear_ButtonClick(Sender: TObject);
var monthes, per:Integer;
begin
  Input_sum.Text:='';
  per:=StrToInt(Input_per.Text);
  per:=0;
  Input_per.Text:=IntToStr(per);
  monthes:=StrToInt(Input_mon.Text);
  monthes:=0;
  Input_mon.Text:=Inttostr(monthes);
  Info_output.Text:='';
end;


end.

