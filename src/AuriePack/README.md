# AuriePack

> by tomat

---

AuriePack bundles the binaries for Aurie and YYTK, allowing for convenient native GameMaker modding.

Aurie and YYTK are common base dependencies of GameMaker mods.

## Installation

Once you download the archive, extract it to a directory of your choosing. It should produce the following directory structure:

```
.
├── AuriePack/           
│   ├── AurieInstaller/
│   │   └── ...
│   └── mods/            <-- Copy this
│       └── ...
├── CHANGELOG.md
├── icon.png
├── LICENSE
├── manifest.json
├── README.md
├── run-installer.cd     <-- Run this
└── versions.txt
```

Run `run-installer.bat` and select Risk of Rain Returns (you may need to navigate to it).

Assuming it is installed correctly, proceed to copy the `mods` directory within the `AuriePack` directory into the Risk of Rain Returns folder such that the following directory structure is produced:

```
.
├── data/
│   └── ...
├── language/
│   └── ...
├── mods/                     <-- Make sure this directory exists with these files
│   ├── Aurie/
│   │   └── YYToolkit.dll
│   ├── Native/
│   │   └── AurieCore.dll
│   └── AurieLoader.exe
├── data.win
├── Risk of Rain Returns.exe
└── ...
```

You may verify that the installation was successful by running the game and looking for a console window.

## Versions

You can check the versions used in the `versions.txt` file.
