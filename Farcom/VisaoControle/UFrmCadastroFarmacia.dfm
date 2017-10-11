inherited FrmCadastroFarmacia: TFrmCadastroFarmacia
  Caption = 'FrmCadastroFarmacia'
  ClientHeight = 478
  ClientWidth = 727
  Color = clMenuHighlight
  ExplicitWidth = 743
  ExplicitHeight = 517
  DesignSize = (
    727
    478)
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 5
    Height = 438
    Color = clSilver
    ExplicitTop = -1
    ExplicitHeight = 438
    DesignSize = (
      120
      438)
    inherited btnNovo: TLabel
      Left = 37
      Top = 252
      Font.Color = clMaroon
      ExplicitLeft = 37
      ExplicitTop = 252
    end
    object Image2: TImage
      Left = 6
      Top = 245
      Width = 25
      Height = 35
      Cursor = crHandPoint
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000320000
        003208060000001E3F88B10000032C4944415478DAED998B79D3301080CF2C40
        98003341D209E24E9076829A091A1620970908136026204C903041C304752720
        2C40B8F39DA8501CBFE257C0FA3E59B6649DEEB764E974F2E01F095ED70A0C20
        0348CFC3FF0182003E25F714272DEBF599DA8E6A015188078ADF296E9D622EBB
        A3B8D4E7C501E02B09DB55D19AEA4EA8EE8CE5D1FDC8938FF7B60CCC499005C0
        8A0A27242C4881E4BC0DA51EC511DDFFA0788515416C79FA1C52F2A90C4C568F
        6C29D962729BDB307D48B8C6E39E3BAA4715A6E6F920432876E55581691B8465
        CD417A6E6AEAA4819485E9022440897FEA9C022903D37B90A2301701C2216BF2
        E90AE48E2A4507B92F0C627F843E808420D18439E5ED2E0E24A3ADCE407C4A1E
        41C6ED5E87C9FA9C951D6441F55B05D1F21B9035E1EC40207B520431E3433406
        D27618400690016400A90E8232EF93F9934CC1758635C525A64CC3B583A0EC08
        1F69EEFF469557755290CCB96EBCDE503BFBA6414290C5CB2FABA87E04709574
        DE89557ED43448A6C002203C6C3620DBDCADFBCE424D9DB2ED5605610FCAB566
        B1F008A5A7B605F222ADCF21E6E1C91E18ED0903CBEFAEDB0061058DC0B22081
        F6C84F907F8CDF790DA2F8473C614137055269685932621028D4E74092E4474F
        DDCEF61584ADE67B94D9891D7253DD0ABC02E99D2398A6406674B9D2671FC537
        E5E3F3383F9967EE41F633FC9FF13FF1453D9521C8DA74E468680A8417430619
        F1DCBFA4C6F5FD795E9E91A3B3D34B2D7BB2CB30C56BD214C859434BE5707DFE
        E99F40BC23EE02F8170C0A302E4F6CE63A034953B66C796F40EA84C905A1B87A
        01307E4FB69505C26EFF6441A4EE0EB9BBD5811655C9AB03A6080847DBF5C320
        FC639A1EE1D9884D0AB688E32A7975F44CE743AB8CB259E579BED6313EDB548D
        83E4298BB2E6F0299AEF96E71DBD71B73F7896FD731000DF2B79C65724A8F1B8
        C3F475842136AA33E77DB0CB730F4375B3D3CA61A83AEA426A776FC380189406
        2270CB19A6D7C7D396B23188B59C406819E7DF825807B7BD067160DEA16EAD2D
        880064069DF51EC481E161363510681D495C048803638698597FD872F62E06C4
        8661CF3DCFA4BFC480E4E521B8281085B99104C6BA87498E237E030D0B1ECE06
        C39A4F0000000049454E44AE426082}
      Stretch = True
      OnClick = btnNovoClick
    end
  end
  inherited pnlRodape: TPanel
    Top = 443
    Width = 727
    Color = 14869225
    TabOrder = 1
    ExplicitTop = 442
    ExplicitWidth = 727
    inherited Label9: TLabel
      ExplicitLeft = 675
    end
  end
  inherited Panel1: TPanel
    Top = 438
    Width = 727
    Height = 5
    TabOrder = 6
    ExplicitTop = 438
    ExplicitWidth = 705
    ExplicitHeight = 5
  end
  inherited Panel2: TPanel
    Width = 5
    Height = 438
    Anchors = [akTop, akBottom]
    TabOrder = 5
    ExplicitWidth = 5
    ExplicitHeight = 438
  end
  inherited pnlFundo: TPanel
    Left = 125
    Width = 602
    Height = 438
    TabOrder = 4
    ExplicitLeft = 125
    ExplicitTop = 0
    ExplicitWidth = 580
    ExplicitHeight = 438
    inherited pnlCabecalho: TPanel
      Width = 600
      Height = 39
      Color = 11788021
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 578
      ExplicitHeight = 39
      inherited lbCabecalho: TLabel
        Left = 5
        Top = 9
        Width = 194
        Height = 21
        Caption = 'CADASTRO DE FARMACIA'
        Color = clBlack
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = 9934601
        Font.Name = 'Candara'
        ParentColor = False
        ExplicitLeft = 5
        ExplicitTop = 9
        ExplicitWidth = 194
        ExplicitHeight = 21
      end
    end
    inherited gbInformacoes: TGroupBox
      Top = 40
      Width = 600
      Height = 397
      Color = 15000804
      Font.Height = -13
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 6
      ExplicitTop = 40
      ExplicitWidth = 600
      ExplicitHeight = 397
      object aaa: TLabel
        Left = 29
        Top = 114
        Width = 57
        Height = 13
        Caption = 'N'#186' Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 62
        Top = 56
        Width = 25
        Height = 13
        Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 17
        Top = 146
        Width = 69
        Height = 13
        Caption = 'Hora Abertura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 2
        Top = 174
        Width = 85
        Height = 13
        Caption = 'Hora Fechamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edEmail: TLabeledEdit
        Left = 90
        Top = 81
        Width = 368
        Height = 19
        Color = clWhite
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        MaxLength = 60
        ParentFont = False
        TabOrder = 2
      end
      object edNTelefone: TMaskEdit
        Left = 90
        Top = 111
        Width = 93
        Height = 19
        Color = clWhite
        EditMask = '!\(00\)00000-0009;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 3
      end
      object edNome: TLabeledEdit
        Left = 90
        Top = 21
        Width = 452
        Height = 19
        Color = clWhite
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        MaxLength = 60
        ParentFont = False
        TabOrder = 0
      end
      object edCnpj: TMaskEdit
        Left = 90
        Top = 51
        Width = 107
        Height = 19
        Color = clWhite
        EditMask = '!990\.000\.000\-00;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 1
      end
      object edHoraAbertura: TMaskEdit
        Left = 90
        Top = 141
        Width = 90
        Height = 19
        Color = clWhite
        EditMask = '!90:00;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 4
      end
      object edHoraFechamento: TMaskEdit
        Left = 90
        Top = 171
        Width = 90
        Height = 19
        Color = clWhite
        EditMask = '!90:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 5
        Text = '  :  '
      end
    end
  end
  inherited gbLocalizar: TGroupBox
    Left = 417
    Top = -2
    Anchors = [akTop]
    Color = 15000804
    TabOrder = 3
    ExplicitLeft = 400
    ExplicitTop = -2
    inherited edCodigo: TEdit
      Color = clWhite
    end
  end
  object gbEndereco: TGroupBox [6]
    Left = 126
    Top = 241
    Width = 600
    Height = 195
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Endere'#231'o'
    Color = 15000804
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Label2: TLabel
      Left = 54
      Top = 26
      Width = 33
      Height = 13
      Caption = 'Estado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 173
      Top = 26
      Width = 33
      Height = 13
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbEstado: TComboBox
      Left = 89
      Top = 22
      Width = 67
      Height = 19
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = cbEstadoChange
    end
    object cbMunicipio: TComboBox
      Left = 208
      Top = 23
      Width = 152
      Height = 19
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = cbMunicipioExit
    end
    object edBairro: TLabeledEdit
      Left = 89
      Top = 82
      Width = 182
      Height = 19
      Color = clWhite
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'Bairro'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelPosition = lpLeft
      MaxLength = 60
      ParentFont = False
      TabOrder = 3
    end
    object edRua: TLabeledEdit
      Left = 89
      Top = 112
      Width = 286
      Height = 19
      Color = clWhite
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'Rua'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelPosition = lpLeft
      MaxLength = 60
      ParentFont = False
      TabOrder = 4
    end
    object edNumero: TLabeledEdit
      Left = 89
      Top = 171
      Width = 55
      Height = 19
      Color = clWhite
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Numero'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelPosition = lpLeft
      MaxLength = 6
      NumbersOnly = True
      ParentFont = False
      TabOrder = 6
    end
    object edCep: TLabeledEdit
      Left = 89
      Top = 52
      Width = 67
      Height = 19
      Color = clWhite
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'CEP'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelPosition = lpLeft
      MaxLength = 8
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      Text = '00000-000'
    end
    object edComplemento: TLabeledEdit
      Left = 89
      Top = 142
      Width = 216
      Height = 19
      Color = clWhite
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = 'Complemento'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelPosition = lpLeft
      MaxLength = 60
      ParentFont = False
      TabOrder = 5
    end
  end
end
