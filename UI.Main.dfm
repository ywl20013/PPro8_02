object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'fmMain'
  ClientHeight = 492
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    557
    492)
  PixelsPerInch = 96
  TextHeight = 13
  object chkStoreToSqlite: TCheckBox
    Left = 8
    Top = 66
    Width = 449
    Height = 17
    Caption = 'chkStoreToSqlite'
    TabOrder = 3
    OnClick = chkStoreToSqliteClick
  end
  object chkListening: TCheckBox
    Left = 8
    Top = 39
    Width = 449
    Height = 17
    Caption = 'chkListening'
    TabOrder = 2
    OnClick = chkListeningClick
  end
  object edtUDPPort: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edtUDPPort'
    OnChange = edtUDPPortChange
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 120
    Width = 538
    Height = 364
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Market Depth'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1095
      ExplicitHeight = 355
      object Splitter1: TSplitter
        Left = 257
        Top = 0
        Width = 5
        Height = 336
        AutoSnap = False
        ExplicitLeft = 513
        ExplicitHeight = 355
      end
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 257
        Height = 336
        Align = alLeft
        ItemHeight = 13
        TabOrder = 0
        ExplicitHeight = 355
      end
      object ListBox2: TListBox
        Left = 262
        Top = 0
        Width = 268
        Height = 336
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
        ExplicitLeft = 263
        ExplicitTop = -24
        ExplicitHeight = 355
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      ExplicitWidth = 1095
      ExplicitHeight = 355
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 530
        Height = 336
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
        WordWrap = False
        ExplicitWidth = 1095
        ExplicitHeight = 355
      end
    end
  end
  object Button1: TButton
    Left = 1040
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Test From'
    TabOrder = 1
    OnClick = Button1Click
  end
  object chkCalcLevel2: TCheckBox
    Left = 8
    Top = 93
    Width = 449
    Height = 17
    Caption = 'chkCalcLevel2'
    TabOrder = 4
  end
end
