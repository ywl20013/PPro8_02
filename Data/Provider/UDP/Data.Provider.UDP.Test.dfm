object dmProviderUDPTest: TdmProviderUDPTest
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 144
    Top = 24
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 88
    Top = 56
  end
end
