
### Puppet Module for deploy Kaspersky Endpoint Security 11 for Linux

#### Example usage hiera,

```
---
classes:
  - kesl

kesl::ensure: '11.1.0-3013'
kesl::autoinstall:
     params:
        'EULA_AGREED': 'Yes'
        'PRIVACY_POLICY_AGREED': 'Yes'
        'USE_KSN': 'No'
        'UPDATE_SOURCE': 'KLServers'
        'UPDATE_EXECUTE': 'No'
        'KERNEL_SRCS_INSTALL': 'No'
        'USE_GUI': 'No'
        'IMPORT_SETTINGS': 'Yes'
        'INSTALL_LICENSE': '*****-*****-*****-*****'

kesl::customconfigversion: '11.1.0.3013'
kesl::customimports:
     AppSettings:
        'SambaConfigPath': '/test'
        'NfsExportPath': '/test'
 
```

#### Example of custom import settings,
```
     AppSettings:
         SambaConfigPath: /etc/samba/smb.conf
         NfsExportPath: /etc/exports
         TraceFolder: /var/log/kaspersky/kesl/
         TraceLevel: None
         TraceMaxFileCount: 5
         TraceMaxFileSize: 500
         BlockFilesGreaterMaxFileNamePath: 16384
         DetectOtherObjects: No
         UseKSN: No
         UseProxy: No
         ProxyServer: 
         MaxEventsNumber: 500000
         LimitNumberOfScanFileTasks: 0
         UseSyslog: No
         EventsStoragePath: /var/opt/kaspersky/kesl/private/storage/events.db
         InterceptorProtectionMode: Full
         NamespaceMonitoring: Yes
         DockerSocket: /var/run/docker.sock
         ContainerScanAction: StopContainerIfFailed
     NetSettings:
         EncryptedConnectionsScan: Yes
         EncryptedConnectionsScanErrorAction: AddToAutoExclusions
         ManageExclusions: No
         UntrustedCertificateAction: Allow
         CertificateVerificationPolicy: FullCheck
         MonitorNetworkPorts: Selected
     NetSettings.NetworkPorts.item_0000:
         PortName: HTTP
         Port: 80
     NetSettings.NetworkPorts.item_0001:
         PortName: HTTP
         Port: 81
     NetSettings.NetworkPorts.item_0002:
         PortName: HTTP
         Port: 82
     NetSettings.NetworkPorts.item_0003:
         PortName: HTTP
         Port: 83
     NetSettings.NetworkPorts.item_0004:
         PortName: HTTPS
         Port: 443
     NetSettings.NetworkPorts.item_0005:
         PortName: HTTP
         Port: 968
     NetSettings.NetworkPorts.item_0006:
         PortName: HTTP
         Port: 1080
     NetSettings.NetworkPorts.item_0007:
         PortName: Default Proxy
         Port: 3128
     NetSettings.NetworkPorts.item_0008:
         PortName: HTTP
         Port: 7900
     NetSettings.NetworkPorts.item_0009:
         PortName: HTTP
         Port: 8000
     NetSettings.NetworkPorts.item_0010:
         PortName: HTTP
         Port: 8080
     NetSettings.NetworkPorts.item_0011:
         PortName: HTTP
         Port: 8088
     NetSettings.NetworkPorts.item_0012:
         PortName: HTTP
         Port: 8888
     NetSettings.NetworkPorts.item_0013:
         PortName: HTTP
         Port: 11523
     MonitoringTask.item_0000:
         TaskName: File_Threat_Protection
         AdminKitTaskName: 
         TaskType: OAS
         Active: Yes
     MonitoringTask.item_0000.Settings:
         ScanArchived: No
         ScanSfxArchived: No
         ScanMailBases: No
         ScanPlainMail: No
         TimeLimit: 60
         SizeLimit: 0
         FirstAction: Recommended
         SecondAction: Block
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportPackedObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         UseIChecker: Yes
         ScanByAccessType: SmartCheck
     MonitoringTask.item_0000.Settings.ScanScope.item_0000:
         AreaDesc: All objects
         UseScanArea: Yes
         Path: /
         AreaMask.item_0000: '*'
     MonitoringTask.item_0001:
         TaskName: System_Integrity_Monitoring
         AdminKitTaskName: 
         TaskType: OAFIM
         Active: No
     MonitoringTask.item_0001.Settings:
         UseExcludeMasks: No
     MonitoringTask.item_0001.Settings.ScanScope.item_0000:
         AreaDesc: Kaspersky internal objects
         UseScanArea: Yes
         Path: /opt/kaspersky/kesl/
         AreaMask.item_0000: '*'
     MonitoringTask.item_0002:
         TaskName: Firewall_Management
         AdminKitTaskName: 
         TaskType: Firewall
         Active: No
     MonitoringTask.item_0002.Settings:
         DefaultIncomingAction: Allow
         DefaultIncomingPacketAction: Allow
         OpenNagentPorts: Yes
     MonitoringTask.item_0002.Settings.NetworkZonesTrusted:
     MonitoringTask.item_0002.Settings.NetworkZonesLocal:
     MonitoringTask.item_0002.Settings.NetworkZonesPublic:
     MonitoringTask.item_0003:
         TaskName: Anti_Cryptor
         AdminKitTaskName: 
         TaskType: AntiCryptor
         Active: No
     MonitoringTask.item_0003.Settings:
         UseHostBlocker: Yes
         BlockTime: 30
         UseExcludeMasks: No
     MonitoringTask.item_0003.Settings.ScanScope.item_0000:
         AreaDesc: All shared folders
         UseScanArea: Yes
         Path: AllShared
         AreaMask.item_0000: '*'
     MonitoringTask.item_0004:
         TaskName: Web_Threat_Protection
         AdminKitTaskName: 
         TaskType: WTP
         Active: No
     MonitoringTask.item_0004.Settings:
         UseTrustedAddresses: Yes
         ActionOnDetect: Block
         CheckMalicious: Yes
         CheckPhishing: Yes
         UseHeuristicForPhishing: Yes
         CheckAdware: No
         CheckOther: No
     MonitoringTask.item_0005:
         TaskName: Device_Control
         AdminKitTaskName: 
         TaskType: DeviceControl
         Active: Yes
     MonitoringTask.item_0005.Settings:
     MonitoringTask.item_0005.Settings.DeviceClass:
         HardDrive: DependsOnBus
         RemovableDrive: DependsOnBus
         Printer: DependsOnBus
         FloppyDrive: DependsOnBus
         OpticalDrive: DependsOnBus
         Modem: DependsOnBus
         TapeDrive: DependsOnBus
         MultifuncDevice: DependsOnBus
         SmartCardReader: DependsOnBus
         PortableDevice: DependsOnBus
         WiFiAdapter: DependsOnBus
         NetworkAdapter: DependsOnBus
         BluetoothDevice: DependsOnBus
         ImagingDevice: DependsOnBus
         SerialPortDevice: DependsOnBus
         ParallelPortDevice: DependsOnBus
         InputDevice: DependsOnBus
         SoundAdapter: DependsOnBus
     MonitoringTask.item_0005.Settings.DeviceBus:
         USB: Allow
         FireWire: Allow
     MonitoringTask.item_0005.Settings.Schedules.item_0000:
         ScheduleName: Default
         DaysHours: All
     MonitoringTask.item_0005.Settings.HardDrivePrincipals.item_0000:
         Principal: \Everyone
     MonitoringTask.item_0005.Settings.HardDrivePrincipals.item_0000.AccessRules.item_0000:
         UseRule: Yes
         ScheduleName: Default
         Access: Allow
     MonitoringTask.item_0005.Settings.RemovableDrivePrincipals.item_0000:
         Principal: \Everyone
     MonitoringTask.item_0005.Settings.RemovableDrivePrincipals.item_0000.AccessRules.item_0000:
         UseRule: Yes
         ScheduleName: Default
         Access: Allow
     MonitoringTask.item_0005.Settings.FloppyDrivePrincipals.item_0000:
         Principal: \Everyone
     MonitoringTask.item_0005.Settings.FloppyDrivePrincipals.item_0000.AccessRules.item_0000:
         UseRule: Yes
         ScheduleName: Default
         Access: Allow
     MonitoringTask.item_0005.Settings.OpticalDrivePrincipals.item_0000:
         Principal: \Everyone
     MonitoringTask.item_0005.Settings.OpticalDrivePrincipals.item_0000.AccessRules.item_0000:
         UseRule: Yes
         ScheduleName: Default
         Access: Allow
     MonitoringTask.item_0006:
         TaskName: Removable_Drives_Scan
         AdminKitTaskName: 
         TaskType: RDS
         Active: No
     MonitoringTask.item_0006.Settings:
         ScanRemovableDrives: NoScan
         ScanOpticalDrives: NoScan
         BlockDuringScan: No
     MonitoringTask.item_0007:
         TaskName: Network_Threat_Protection
         AdminKitTaskName: 
         TaskType: NTP
         Active: No
     MonitoringTask.item_0007.Settings:
         BlockAttackingHosts: Yes
         BlockDurationMinutes: 60
         UseExcludeIPs: No
     MonitoringTask.item_0008:
         TaskName: Behavior_Detection
         AdminKitTaskName: 
         TaskType: BehaviorDetection
         Active: Yes
     OnDemandTask.item_0000:
         TaskName: Scan_My_Computer
         AdminKitTaskName: 
         TaskType: ODS
         TaskId: 2
     OnDemandTask.item_0000.Settings:
         ScanArchived: Yes
         ScanSfxArchived: Yes
         ScanMailBases: No
         ScanPlainMail: No
         TimeLimit: 0
         SizeLimit: 0
         FirstAction: Recommended
         SecondAction: Skip
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportPackedObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         UseIChecker: Yes
         ScanPriority: Idle
     OnDemandTask.item_0000.Settings.ScanScope.item_0000:
         AreaDesc: All objects
         UseScanArea: Yes
         Path: /
         AreaMask.item_0000: '*'
     OnDemandTask.item_0000.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0001:
         TaskName: Scan_File
         AdminKitTaskName: 
         TaskType: ODS
         TaskId: 3
     OnDemandTask.item_0001.Settings:
         ScanArchived: Yes
         ScanSfxArchived: Yes
         ScanMailBases: No
         ScanPlainMail: No
         TimeLimit: 0
         SizeLimit: 0
         FirstAction: Recommended
         SecondAction: Skip
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportPackedObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         UseIChecker: Yes
         ScanPriority: Normal
     OnDemandTask.item_0001.Settings.ScanScope.item_0000:
         AreaDesc: All objects
         UseScanArea: Yes
         Path: /
         AreaMask.item_0000: '*'
     OnDemandTask.item_0001.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0002:
         TaskName: Boot_Scan
         AdminKitTaskName: 
         TaskType: BootScan
         TaskId: 4
     OnDemandTask.item_0002.Settings:
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         Action: Disinfect
         DeviceNameMasks.item_0000: /'*''*'
     OnDemandTask.item_0002.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0003:
         TaskName: Memory_Scan
         AdminKitTaskName: 
         TaskType: MemoryScan
         TaskId: 5
     OnDemandTask.item_0003.Settings:
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportUnprocessedObjects: No
         Action: Disinfect
     OnDemandTask.item_0003.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0004:
         TaskName: Update
         AdminKitTaskName: 
         TaskType: Update
         TaskId: 6
     OnDemandTask.item_0004.Settings:
         SourceType: KLServers
         UseKLServersWhenUnavailable: Yes
         IgnoreProxySettingsForKLServers: No
         IgnoreProxySettingsForCustomSources: No
         ConnectionTimeout: 10
         ApplicationUpdateMode: DownloadOnly
     OnDemandTask.item_0004.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0005:
         TaskName: Rollback
         AdminKitTaskName: 
         TaskType: Rollback
         TaskId: 7
     OnDemandTask.item_0005.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0006:
         TaskName: Container_Scan
         AdminKitTaskName: 
         TaskType: ContainerScan
         TaskId: 18
     OnDemandTask.item_0006.Settings:
         ScanArchived: Yes
         ScanSfxArchived: Yes
         ScanMailBases: No
         ScanPlainMail: No
         TimeLimit: 120
         SizeLimit: 0
         FirstAction: Recommended
         SecondAction: Skip
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportPackedObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         UseIChecker: Yes
         ScanContainers: Yes
         ContainerNameMask: '*'
         ScanImages: Yes
         ImageNameMask: '*'
         DeepScan: No
         ScanPriority: Idle
         ContainerScanAction: StopContainerIfFailed
         ImageAction: Skip
     OnDemandTask.item_0006.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     OnDemandTask.item_0007:
         TaskName: Custom_Container_Scan
         AdminKitTaskName: 
         TaskType: ContainerScan
         TaskId: 19
     OnDemandTask.item_0007.Settings:
         ScanArchived: Yes
         ScanSfxArchived: Yes
         ScanMailBases: No
         ScanPlainMail: No
         TimeLimit: 120
         SizeLimit: 0
         FirstAction: Recommended
         SecondAction: Skip
         UseExcludeMasks: No
         UseExcludeThreats: No
         ReportCleanObjects: No
         ReportPackedObjects: No
         ReportUnprocessedObjects: No
         UseAnalyzer: Yes
         HeuristicLevel: Recommended
         UseIChecker: Yes
         ScanContainers: Yes
         ContainerNameMask: '*'
         ScanImages: Yes
         ImageNameMask: '*'
         DeepScan: No
         ScanPriority: Idle
         ContainerScanAction: StopContainerIfFailed
         ImageAction: Skip
     OnDemandTask.item_0007.Schedule:
         RuleType: 6
         StartTime: 
         RandomInterval: 0
         RunMissedStartRules: 0
     BackupTask:
         TaskName: Backup
         AdminKitTaskName: 
         TaskType: Backup
     BackupTask.Settings:
         DaysToLive: 90
         BackupSizeLimit: 0
         BackupFolder: /var/opt/kaspersky/kesl/common/objects-backup
```



