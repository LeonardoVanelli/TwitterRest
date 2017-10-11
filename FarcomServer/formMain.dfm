object frmMain: TfrmMain
  Left = 405
  Top = 86
  Caption = 'Rest Web Service Application'
  ClientHeight = 485
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 123
    Top = 42
    Width = 237
    Height = 66
    Alignment = taCenter
    Caption = 'Rest WebService Application'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 150
    Width = 56
    Height = 13
    Caption = 'Requisi'#231#245'es'
  end
  object Label2: TLabel
    Left = 8
    Top = 294
    Width = 50
    Height = 13
    Caption = 'Respostas'
  end
  object txtInfoLabel: TStaticText
    Left = 173
    Top = 124
    Width = 157
    Height = 17
    Alignment = taCenter
    Caption = 'Aguardando Requisi'#231#245'es...'
    Color = clMedGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoBk
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
  end
  object btnAtivar: TBitBtn
    Left = 165
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Ativar WS'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnAtivarClick
  end
  object btnParar: TBitBtn
    Left = 246
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Parar WS'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnPararClick
  end
  object memoReq: TMemo
    Left = 8
    Top = 169
    Width = 473
    Height = 112
    TabOrder = 3
  end
  object memoResp: TMemo
    Left = 8
    Top = 313
    Width = 473
    Height = 112
    TabOrder = 4
  end
  object apl1: TApplicationEvents
    OnMinimize = apl1Minimize
    Left = 448
    Top = 32
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8080
    ListenQueue = 100
    OnCommandOther = IdHTTPServer1CommandOther
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 24
    Top = 16
  end
  object TrayIcon1: TTrayIcon
    BalloonHint = 'RestWebService Application'
    BalloonFlags = bfInfo
    OnClick = TrayIcon1Click
    Left = 96
    Top = 16
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 384
    Top = 32
  end
end
