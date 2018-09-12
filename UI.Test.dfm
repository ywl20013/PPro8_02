object fmTest: TfmTest
  Left = 0
  Top = 0
  Caption = 'fmTest'
  ClientHeight = 454
  ClientWidth = 663
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
    663
    454)
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
  object chkSendTestUDPData: TCheckBox
    Left = 8
    Top = 74
    Width = 449
    Height = 17
    Caption = 'chkSendTestUDPData'
    TabOrder = 2
    OnClick = chkSendTestUDPDataClick
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
  object Memo1: TMemo
    Left = 8
    Top = 152
    Width = 647
    Height = 294
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      
        'LocalTime=22:36:37.962,Message=L2,MarketTime=10:36:38.975,Symbol' +
        '=1988.HK,Mmid=HKE,Side=A,Price=5.33000,Volume=97'
      '000,Depth=1,SequenceNumber=1992600')
    TabOrder = 4
  end
  object btn2: TButton
    Left = 8
    Top = 99
    Width = 273
    Height = 25
    Caption = 'btn1'
    TabOrder = 3
    OnClick = btn2Click
  end
  object tmrLabelFormSizeDisplay: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = tmrLabelFormSizeDisplayTimer
    Left = 400
    Top = 8
  end
end
