inherited FrmCadastroCompra: TFrmCadastroCompra
  Caption = 'FrmCadastroCompra'
  ClientHeight = 450
  ClientWidth = 781
  ExplicitWidth = 797
  ExplicitHeight = 489
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 450
    Color = 15658734
    ExplicitHeight = 450
    DesignSize = (
      120
      450)
    inherited imgGravar: TImage
      Top = 414
      Height = 34
      Visible = False
      ExplicitTop = 414
      ExplicitHeight = 34
    end
    inherited imgExcluir: TImage
      Left = 0
      Top = 233
      Height = 36
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 233
      ExplicitHeight = 36
    end
    inherited imgLimpar: TImage
      Top = 168
      OnClick = Label2Click
      ExplicitTop = 168
    end
    inherited imgOpenLocalizar: TImage
      Top = 376
      Visible = False
      ExplicitTop = 376
    end
    inherited btnLocalizar: TLabel
      Left = 224
      ExplicitLeft = 224
    end
    inherited btnNovo: TLabel
      Left = 30
      Top = 60
      Width = 36
      Height = 22
      AutoSize = False
      Caption = 'Nova'
      Font.Height = -16
      ExplicitLeft = 30
      ExplicitTop = 60
      ExplicitWidth = 36
      ExplicitHeight = 22
    end
    inherited btnGravar: TLabel
      Left = 30
      Top = 411
      Width = 48
      Height = 22
      AutoSize = False
      Caption = 'Gravar'
      Font.Height = -16
      Visible = False
      ExplicitLeft = 30
      ExplicitTop = 411
      ExplicitWidth = 48
      ExplicitHeight = 22
    end
    inherited btnExcluir: TLabel
      Left = 31
      Top = 245
      AutoSize = False
      Font.Height = -16
      Visible = False
      ExplicitLeft = 31
      ExplicitTop = 245
    end
    inherited btnLimpar: TLabel
      Left = 32
      Top = 168
      Width = 61
      Height = 22
      Caption = 'Cancelar'
      Font.Height = -16
      ExplicitLeft = 32
      ExplicitTop = 168
      ExplicitWidth = 61
      ExplicitHeight = 22
    end
    object Label1: TLabel
      Left = 30
      Top = 383
      Width = 73
      Height = 22
      Cursor = crHandPoint
      Caption = 'Prescri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      Visible = False
      OnClick = btnLocalizarClick
    end
    object lblNovo: TLabel
      Left = 30
      Top = 77
      Width = 55
      Height = 22
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = btnNovoClick
    end
    object lblGravar: TLabel
      Left = 30
      Top = 428
      Width = 55
      Height = 22
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      Visible = False
      OnClick = btnGravarClick
    end
    object Label4: TLabel
      Left = 22
      Top = 353
      Width = 56
      Height = 24
      Cursor = crHandPoint
      Caption = 'Farcon'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      Visible = False
      OnClick = btnOpenLocalizarClick
    end
    object lblFinalizaCompra1: TLabel
      Left = 31
      Top = 130
      Width = 55
      Height = 22
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = btnFinalizaCompraClick
    end
    object lblFinalizaCompra: TLabel
      Left = 30
      Top = 114
      Width = 67
      Height = 22
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'Finalizar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = btnFinalizaCompraClick
    end
    object btnFinalizaCompra: TImage
      Left = 1
      Top = 114
      Width = 25
      Height = 34
      Cursor = crHandPoint
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000320000
        003208060000001E3F88B10000015B4944415478DAEDDAF151C2301406F0D709
        D0092C132813881B384299009D409C003780516402650261026002FC722D5E68
        4BD342C24BE27B77DF1FF4E8F5FBD103428E84229984BB802BC814794652EE62
        986FE409D976857C2063EEF6E76274C806B96978EE02C99095C3E22932471EBB
        6274C8DE7091BE63848EF9291D3362BA406C7E307C210FA5A2034397460C17A4
        EE5A6DBA9CC4840639890911528B091552C1840C3960063140FECE1388402283
        A837E9BDF67849C7DFF44E21B7D472497DE1A4545D6B59857C222372BFFA9D21
        4397105F4720BE8D407C1B81F8369D213B6442F92E87EB2F46B59B9315D7EBD9
        86BC52BEF775CD79A17CD3D02AE45A4B147DD49DD9D88670ED13B7EA25108108
        44200211884004121824291DE78694FBFC3F08D59DC00869EC152544FD68EA99
        4EF00CB2A6E2EF267AB909F2C654F6DC792F7A575E65753043EEB81B1A46DD89
        F90151070976A281FC0245A28433EFD884EB0000000049454E44AE426082}
      Stretch = True
      OnClick = btnFinalizaCompraClick
    end
    object lblLimpar1: TLabel
      Left = 32
      Top = 185
      Width = 55
      Height = 22
      Cursor = crHandPoint
      Caption = 'Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = Label2Click
    end
  end
  inherited pnlFundo: TPanel
    Width = 661
    Height = 450
    ExplicitWidth = 661
    ExplicitHeight = 450
    inherited pnlCabecalho: TPanel
      Width = 659
      Color = 11040548
      Font.Color = -1
      ExplicitWidth = 659
      inherited lbCabecalho: TLabel
        Left = 4
        Top = 10
        Width = 192
        Caption = 'CADASTRO DE COMPRA'
        Font.Color = clWhite
        ExplicitLeft = 4
        ExplicitTop = 10
        ExplicitWidth = 192
      end
    end
    inherited gbInformacoes: TGroupBox
      Width = 659
      Height = 121
      Align = alTop
      Color = 14606046
      ExplicitWidth = 659
      ExplicitHeight = 121
      object Label5: TLabel
        Left = 30
        Top = 39
        Width = 52
        Height = 13
        Caption = 'ID Produto'
      end
      object Label6: TLabel
        Left = 55
        Top = 65
        Width = 27
        Height = 13
        Caption = 'Pre'#231'o'
      end
      object Label2: TLabel
        Left = 174
        Top = 64
        Width = 19
        Height = 19
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 284
        Top = -1
        Width = 33
        Height = 13
        Caption = 'Farcon'
      end
      object lblPrecoProduto: TStaticText
        Left = 88
        Top = 63
        Width = 84
        Height = 20
        AutoSize = False
        BorderStyle = sbsSingle
        Color = 11382189
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 5
        Transparent = False
      end
      object edProduto: TEdit
        Left = 88
        Top = 36
        Width = 89
        Height = 21
        Color = 15658734
        NumbersOnly = True
        TabOrder = 0
        OnChange = edProdutoChange
        OnExit = edProdutoExit
        OnKeyDown = edProdutoKeyDown
      end
      object btnLocalizarProduto: TButton
        Left = 284
        Top = 12
        Width = 31
        Height = 19
        Cursor = crHandPoint
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnLocalizarProdutoClick
      end
      object btnAdicionaCompra: TButton
        Left = 217
        Top = 90
        Width = 26
        Height = 25
        Caption = '+'
        TabOrder = 2
        OnClick = btnAdicionaCompraClick
      end
      object btnLimparDadosProduto: TButton
        Left = 245
        Top = 90
        Width = 26
        Height = 25
        Caption = '-'
        TabOrder = 3
        OnClick = btnLimparDadosProdutoClick
      end
      object lblNomeProduto: TStaticText
        Left = 217
        Top = 37
        Width = 342
        Height = 19
        AutoSize = False
        BorderStyle = sbsSingle
        Color = 11382189
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 4
        Transparent = False
      end
      object lblDescricaoProduto: TStaticText
        Left = 217
        Top = 62
        Width = 438
        Height = 19
        AutoSize = False
        BorderStyle = sbsSingle
        Color = 11382189
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 6
        Transparent = False
      end
      object Button1: TButton
        Left = 181
        Top = 37
        Width = 31
        Height = 19
        Cursor = crHandPoint
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        TabStop = False
      end
    end
    inherited gbLocalizar: TGroupBox
      Width = 659
      Color = 14606046
      TabOrder = 3
      ExplicitWidth = 659
      inherited edCodigo: TEdit
        Left = 5
        Top = 23
        Color = 15658734
        ExplicitLeft = 5
        ExplicitTop = 23
      end
    end
    object lvProdutos: TListView [3]
      Left = 1
      Top = 217
      Width = 659
      Height = 173
      Align = alClient
      Color = 14737632
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = 'Nome Produto'
          Width = 250
        end
        item
          AutoSize = True
          Caption = 'Apresenta'#231#227'o'
        end
        item
          Caption = 'Pre'#231'o Produto'
          Width = 100
        end>
      DoubleBuffered = False
      GridLines = True
      Groups = <
        item
          GroupID = 0
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end>
      ReadOnly = True
      ParentDoubleBuffered = False
      TabOrder = 2
      ViewStyle = vsReport
    end
    object Panel3: TPanel [4]
      Left = 1
      Top = 390
      Width = 659
      Height = 24
      Align = alBottom
      TabOrder = 4
      object Label7: TLabel
        Left = 5
        Top = 2
        Width = 54
        Height = 23
        Caption = 'Total: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblTotal: TLabel
        Left = 64
        Top = 2
        Width = 180
        Height = 19
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 180
        Top = 0
        Width = 22
        Height = 23
        AutoSize = False
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    inherited pnlRodape: TPanel
      Top = 414
      Width = 659
      Color = 5329233
      TabOrder = 5
      ExplicitTop = 414
      ExplicitWidth = 659
      DesignSize = (
        659
        35)
      inherited Label9: TLabel
        Left = 606
        Top = 5
        ExplicitLeft = 600
        ExplicitTop = 5
      end
    end
  end
  inherited pmOpcoes: TPopupMenu
    Left = 64
    Top = 355
  end
end
