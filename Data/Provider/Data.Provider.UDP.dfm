object dmProviderUDP: TdmProviderUDP
  OldCreateOrder = False
  Height = 150
  Width = 215
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    Left = 88
    Top = 56
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 144
    Top = 24
  end
end
