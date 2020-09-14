# Lightdm on Ubuntu with systemd
## Files

```
.
├── etc
│  ├── alternatives
│  │  └── lightdm-greeter -> usr/share/xgreeters/lightdm-gtk-greeter.desktop
│  ├── init
│  │  └── lightdm.conf
│  ├── init.d
│  │  └── lightdm
│  ├── pam.d
│  │  ├── lightdm
│  │  ├── lightdm-autologin
│  │  ├── lightdm-greeter
│  │  └── lightdm.backup
│  ├── share
│  │  └── lightdm
│  │     ├── lightdm-gtk-greeter.conf
│  │     ├── lightdm.conf
│  │     ├── lightdm.conf.d
│  │     └── users.conf
│  └── systemd
│     └── system
│        └── lightdm.service
├── HOME
├── lib
│  └── systemd
│     └── system
│        └── display-manager.service -> etc/systemd/system/lightdm.service
├── README.md
└── usr
   └── share
      └── xgreeters
         ├── lightdm-greeter.desktop -> etc/alternatives/lightdm-greeter
         ├── lightdm-gtk-greeter.desktop
         └── unity-greeter.desktop
```
