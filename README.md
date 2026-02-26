# Ripple

A Swift iOS application built with UIKit.

## Requirements

- **Xcode 15.0+**
- **iOS 17.0+** deployment target
- **Swift 5.0+**
- **macOS** (required for Xcode and iOS development)

## Project Structure

```
Ripple/
├── Ripple.xcodeproj/          # Xcode project file
├── Ripple/                    # Main app source
│   ├── AppDelegate.swift      # Application lifecycle
│   ├── SceneDelegate.swift    # Scene lifecycle (multi-window support)
│   ├── ViewController.swift   # Main view controller
│   ├── Info.plist             # App configuration
│   ├── Assets.xcassets/       # Asset catalog (icons, colors, images)
│   └── Base.lproj/
│       ├── Main.storyboard        # Main UI storyboard
│       └── LaunchScreen.storyboard # Launch screen
├── .github/
│   └── copilot-instructions.md
├── .gitignore
└── README.md
```

## Getting Started

1. **Open the project** in Xcode:

   ```bash
   open Ripple.xcodeproj
   ```

2. **Select a simulator** or connected device from the Xcode toolbar.

3. **Build and run** the project:
   - Press `Cmd + R` to build and run
   - Press `Cmd + B` to build only

## Architecture

This project follows the **MVC (Model-View-Controller)** pattern:

- **Model**: Data and business logic
- **View**: Storyboards and UIKit views
- **Controller**: View controllers managing UI state

## Configuration

| Setting           | Value            |
| ----------------- | ---------------- |
| Bundle Identifier | `com.ripple.app` |
| Deployment Target | iOS 17.0         |
| Swift Version     | 5.0              |
| Supported Devices | iPhone & iPad    |

## License

This project is proprietary. All rights reserved.
