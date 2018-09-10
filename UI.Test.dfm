object fmTest: TfmTest
  Left = 0
  Top = 0
  Caption = 'fmTest'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    635
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 8
    Top = 19
    Width = 273
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 152
    Width = 619
    Height = 139
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object chkListening: TCheckBox
    Left = 8
    Top = 97
    Width = 449
    Height = 17
    Caption = 'chkListening'
    TabOrder = 3
    OnClick = chkListeningClick
  end
  object chkSendTestUDPData: TCheckBox
    Left = 8
    Top = 74
    Width = 449
    Height = 17
    Caption = 'chkSendTestUDPData'
    TabOrder = 2
    OnClick = chkSendTestUDPDataClick
  end
  object chkStoreToSqlite: TCheckBox
    Left = 8
    Top = 120
    Width = 449
    Height = 17
    Caption = 'chkStoreToSqlite'
    TabOrder = 4
    OnClick = chkStoreToSqliteClick
  end
  object edtUDPPort: TEdit
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtUDPPort'
    OnChange = edtUDPPortChange
  end
  object tmrLabelFormSizeDisplay: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = tmrLabelFormSizeDisplayTimer
    Left = 400
    Top = 8
  end
end
