# expensive-app

Flutter expense sharing app using multi-agent Orquestador pattern with specialist agents for data, UI, integration, config, run, and security tasks. Features real-time expense tracking with in-memory storage (Firebase-ready), modern card-based UI, and screens for listing, creating, and visualizing expenses and balances. Clean architecture with clear separation of concerns.

## Getting Started

This project is a Flutter application that implements:

- Multi-agent architecture with Orquestador coordinating specialist agents
- Real-time expense tracking using StreamController for in-memory updates
- Modern UI with card-based design, proper spacing, and visual hierarchy
- Expense creation with validation and loading states
- Balance calculation showing who owes whom
- Firebase-ready configuration (dependencies configured, google-services.json placeholder)

### Prerequisites

- Flutter SDK
- Android Studio / Xcode (for mobile development)
- Firebase project (for production use)

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. For Firebase integration, replace `expensiveapp/android/app/google-services.json` with your Firebase config file

### How to Run

#### Using Android Emulator (Recommended for Testing)

1. Open Android Studio and create/set up an emulator (or use an existing one)
2. Start the emulator
3. Run the app with: `flutter run`

#### Using Physical Device

1. Connect your Android/iOS device with USB debugging enabled
2. Run the app with: `flutter run`

### Technology Stack

- **AI Model Interface**: `opencode/minimax-m2.5-free` (user-facing agent model)
- **Underlying AI Model**: `nemotron-3-super-free` (actual model powering the agents)
- **Framework**: Flutter SDK
- **State Management**: StreamController for real-time updates
- **Storage**: In-memory (Firebase-ready configuration included)
- **UI**: Material Design with card-based layouts

### Architecture

The app follows a multi-agent pattern:
- **Orquestador**: Decomposes objectives into technical tasks
- **Data Logic Agent**: Handles data models and business logic
- **UI Flutter Agent**: Creates modern, responsive interfaces
- **Integration Agent**: Manages external services (Firebase)
- **Config Agent**: Handles project configuration
- **Run Agent**: Builds and runs the application
- **Security Agent**: Ensures secure practices

Each agent executes only the specific technical tasks assigned to it without assuming business logic.

### Screens

1. **Expense List**: Shows all expenses with modern card design
2. **Create Expense**: Form with validation and loading state
3. **Balance Screen**: Displays totals and debt relationships

### Current State

- ✅ All agents created and configured
- ✅ Gasto model with amount, description, date, payer, and creation timestamp
- ✅ GastoService with in-memory storage and real-time updates
- ✅ Modern UI screens with cards, shadows, and proper spacing
- ✅ Firebase dependencies configured in pubspec.yaml
- ✅ Android configuration with google-services.json placeholder
- ✅ Non-mobile platforms removed (web, windows, linux, macos, ios)
- ✅ App builds successfully and installs on Android emulator

### Next Steps

- Launch Android emulator and test the complete flow
- Replace google-services.json placeholder with real Firebase config
- Consider adding user settings to customize participant names
- Implement actual Firebase/Firestore persistence

---

Built with Flutter and following clean architecture principles.