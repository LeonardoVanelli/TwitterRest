inherited FrmCadastroPrescricao: TFrmCadastroPrescricao
  Caption = 'Cadastro Prescri'#231#227'o'
  ClientHeight = 476
  ClientWidth = 720
  ExplicitWidth = 736
  ExplicitHeight = 515
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Width = 123
    Height = 476
    Color = 12370373
    ExplicitWidth = 123
    ExplicitHeight = 476
    inherited Image1: TImage
      Left = 77
      Top = -2
      ExplicitLeft = 87
      ExplicitTop = -2
    end
    inherited imgNovo: TImage
      Left = 3
      Top = 67
      ExplicitLeft = 3
      ExplicitTop = 67
    end
    inherited imgGravar: TImage
      Left = 3
      Top = 359
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 359
    end
    inherited imgExcluir: TImage
      Left = 3
      Top = 400
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 400
    end
    inherited imgLimpar: TImage
      Left = 3
      Top = 157
      ExplicitLeft = 3
      ExplicitTop = 157
    end
    inherited imgOpenLocalizar: TImage
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnLocalizar: TLabel
      Left = 37
      ExplicitLeft = 37
    end
    inherited btnNovo: TLabel
      Left = 34
      Top = 79
      Width = 37
      Height = 22
      Font.Height = -16
      ExplicitLeft = 34
      ExplicitTop = 79
      ExplicitWidth = 37
      ExplicitHeight = 22
    end
    inherited btnGravar: TLabel
      Left = 34
      Top = 369
      Width = 60
      Height = 22
      Caption = 'Finalizar'
      Font.Height = -16
      Visible = False
      ExplicitLeft = 34
      ExplicitTop = 369
      ExplicitWidth = 60
      ExplicitHeight = 22
    end
    inherited btnExcluir: TLabel
      Left = 37
      Top = 406
      Visible = False
      ExplicitLeft = 37
      ExplicitTop = 406
    end
    inherited btnLimpar: TLabel
      Left = 34
      Top = 176
      Width = 73
      Height = 22
      Caption = 'Prescri'#231#227'o'
      Font.Height = -16
      OnClick = btnLimparClick
      ExplicitLeft = 34
      ExplicitTop = 176
      ExplicitWidth = 73
      ExplicitHeight = 22
    end
    object imgCancelar: TLabel
      Left = 34
      Top = 160
      Width = 61
      Height = 22
      Cursor = crHandPoint
      Caption = 'Cancelar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = btnLimparClick
    end
    object imgFinalizar2: TLabel
      Left = 34
      Top = 126
      Width = 60
      Height = 22
      Cursor = crHandPoint
      Caption = 'Finalizar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      OnClick = imgFinalizarClick
    end
    object imgFinalizar: TImage
      Left = 3
      Top = 116
      Width = 25
      Height = 35
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
      OnClick = imgFinalizarClick
    end
  end
  inherited pnlFundo: TPanel
    Left = 123
    Width = 597
    Height = 476
    ExplicitLeft = 123
    ExplicitWidth = 597
    ExplicitHeight = 476
    inherited pnlCabecalho: TPanel
      Width = 595
      Color = 11040548
      ExplicitWidth = 595
      inherited lbCabecalho: TLabel
        Width = 228
        Caption = 'CADASTRO DE PRESCRIC'#195'O'
        Font.Color = clWhite
        ExplicitWidth = 228
      end
    end
    inherited gbInformacoes: TGroupBox
      Width = 595
      Height = 117
      Align = alTop
      Color = 14606046
      ExplicitWidth = 595
      ExplicitHeight = 117
      object Label1: TLabel
        Left = 54
        Top = 23
        Width = 15
        Height = 13
        Caption = 'Dr.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 28
        Top = 44
        Width = 41
        Height = 13
        Caption = 'Paciente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object stNomeMedico: TStaticText
        Left = 72
        Top = 19
        Width = 361
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
        TabOrder = 0
        Transparent = False
      end
      object RadioGroup1: TRadioGroup
        Left = 72
        Top = 68
        Width = 500
        Height = 45
        Caption = ' Reincid'#234'ncia'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Items.Strings = (
          'Primeira Consulta'
          'Retorno')
        ParentFont = False
        TabOrder = 4
      end
      object edPaciente: TEdit
        Left = 72
        Top = 43
        Width = 121
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
        OnExit = edPacienteExit
      end
      object btnLocalizarPaciente: TButton
        Left = 193
        Top = 42
        Width = 30
        Height = 21
        Cursor = crHandPoint
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
      end
      object stNomeDoPaciente: TStaticText
        Left = 223
        Top = 43
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
        TabOrder = 3
        Transparent = False
      end
    end
    inherited gbLocalizar: TGroupBox
      Width = 595
      Color = 14606046
      TabOrder = 4
      ExplicitWidth = 595
      inherited edCodigo: TEdit
        Color = clWhite
      end
    end
    object pnlMedicamento: TPanel [3]
      Left = 1
      Top = 213
      Width = 595
      Height = 137
      Align = alTop
      BevelOuter = bvNone
      Color = 14606046
      ParentBackground = False
      TabOrder = 2
      object Label2: TLabel
        Left = 6
        Top = 7
        Width = 63
        Height = 13
        Caption = 'Medicamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Vencimento: TLabel
        Left = 14
        Top = 93
        Width = 55
        Height = 13
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 23
        Top = 47
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edMedicamento: TEdit
        Left = 70
        Top = 5
        Width = 121
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
        OnExit = edMedicamentoExit
      end
      object btnLocalizarMedicamento: TButton
        Left = 191
        Top = 4
        Width = 30
        Height = 21
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
      end
      object stDescricaoMedicamento: TStaticText
        Left = 221
        Top = 5
        Width = 262
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
        TabOrder = 2
        Transparent = False
      end
      object mmInstrucaoDosagem: TMemo
        Left = 70
        Top = 47
        Width = 493
        Height = 41
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object btnAdicionar: TButton
        Left = 498
        Top = 91
        Width = 33
        Height = 32
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnGravarClick
      end
      object btnRemover: TButton
        Left = 530
        Top = 91
        Width = 33
        Height = 32
        Caption = '-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = btnRemoverClick
      end
      object dtpVencimento: TDateTimePicker
        Left = 70
        Top = 89
        Width = 121
        Height = 20
        Date = 42973.815900520840000000
        Time = 42973.815900520840000000
        Color = 15658734
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object stApresentacao: TStaticText
        Left = 70
        Top = 27
        Width = 385
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
        TabOrder = 3
        Transparent = False
      end
    end
    object lvMedicamentos: TListView [4]
      AlignWithMargins = True
      Left = 4
      Top = 353
      Width = 589
      Height = 84
      Align = alClient
      BevelOuter = bvNone
      BevelKind = bkSoft
      BorderStyle = bsNone
      Color = 14737632
      Columns = <
        item
          AutoSize = True
          Caption = 'Nome Medicamento'
        end
        item
          AutoSize = True
          Caption = 'Apresenta'#231#227'o Medicamento'
        end
        item
          AutoSize = True
          Caption = 'Instru'#231#245'es \ Dosagem'
        end
        item
          Caption = 'Data Vencimento'
          Width = 100
        end>
      FlatScrollBars = True
      GridLines = True
      Groups = <
        item
          GroupID = 0
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end>
      SortType = stText
      TabOrder = 3
      ViewStyle = vsReport
    end
    inherited pnlRodape: TPanel
      Top = 440
      Width = 595
      Color = 5329233
      TabOrder = 5
      ExplicitTop = 440
      ExplicitWidth = 595
      inherited Label9: TLabel
        Left = 550
        Top = 3
        ExplicitLeft = 550
        ExplicitTop = 3
      end
    end
  end
  inherited pmOpcoes: TPopupMenu
    Left = 32
    Top = 336
  end
end
