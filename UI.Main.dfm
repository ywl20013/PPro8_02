object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'fmMain'
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
  object Memo1: TMemo
    Left = 8
    Top = 93
    Width = 619
    Height = 196
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object chkStoreToSqlite: TCheckBox
    Left = 8
    Top = 66
    Width = 449
    Height = 17
    Caption = 'chkStoreToSqlite'
    TabOrder = 2
    OnClick = chkStoreToSqliteClick
  end
  object chkListening: TCheckBox
    Left = 8
    Top = 39
    Width = 449
    Height = 17
    Caption = 'chkListening'
    TabOrder = 1
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
end
