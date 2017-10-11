object FrmPrincipal: TFrmPrincipal
  Left = 245
  Top = 191
  Caption = 'Bootstrap'
  ClientHeight = 345
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbPrincipal: TStatusBar
    Left = 0
    Top = 326
    Width = 693
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object mmPrincipal: TMainMenu
    Left = 640
    Top = 8
    object miSair: TMenuItem
      Caption = '&Sair'
      OnClick = miSairClick
    end
  end
end
