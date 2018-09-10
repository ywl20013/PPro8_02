object dmProviderUDPServer: TdmProviderUDPServer
  OldCreateOrder = False
  Height = 150
  Width = 215
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 88
    Top = 56
  end
end
