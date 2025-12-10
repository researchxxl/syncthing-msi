Build a Syncthing MSI package running as a service under local SYSTEM account or LocalService account.
You may set registry keys to change Syncthing's default settings for a new configuration to your likes.

### Prerequisites

- Windows 10, 11
- 64 Bit OS

### The generated installer package contains:

- [Syncthing release](https://github.com/syncthing/syncthing/releases)
- [NSSM](https://nssm.cc/download)

### The installer package is built by using third party tools

- [WiX Toolset](https://github.com/wixtoolset/wix3/releases)

### Supported registry keys to adjust Syncthing settings


`HKLM\SOFTWARE\Policies\Syncthing`
```
addDeviceHost, REG_SZ, "localhost.localdomain"
addDeviceID, REG_SZ, "(deviceId)"
addDevicePort, REG_SZ, "22000"
dataTcpPort, REG_SZ, "22000"
defaultVersioningMode, REG_SZ, "none"
enableAutoUpgrade, REG_SZ, "1"
enableGlobalDiscovery, REG_SZ, "1"
enableLocalDiscovery, REG_SZ, "1"
enableNAT, REG_SZ, "1"
enableRelays, REG_SZ, "1"
enableRemoteWebUi, REG_SZ, "0"
enableTelemetry, REG_SZ, "1"
hashers, REG_SZ, "0"
setDevicenameToComputername, REG_SZ, "1"
webUiTcpPort, REG_SZ, "8384"
```
