object srvBackup: TsrvBackup
  OldCreateOrder = False
  DisplayName = 'Servi'#231'o de backup autom'#225'rico HRM'
  Interactive = True
  AfterInstall = ServiceAfterInstall
  OnStart = ServiceStart
  Height = 150
  Width = 215
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 64
    Top = 48
  end
end
