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

---

## Fiscal Atelier Design System

A premium editorial finance experience built on precision and tonal elegance.

### Core Principle

**"Precision Journal"** — A premium editorial finance experience that treats numbers with the refinement of a luxury publication. Every interaction should feel like reading a thoughtfully designed financial magazine.

### Color Palette

| Role | Hex Code | Usage |
|------|----------|-------|
| Primary | `#0a8d6a` | CTAs, active states, positive indicators |
| Secondary | `#597f6e` | Supporting elements, subtle interactions |
| Accent | `#c4645b` | Highlights, alerts, important markers |
| Neutral Base | `#737874` | Body text, secondary content |

### Layout Rules

- **Spacing**: 8px base unit (8, 16, 24, 32, 40, 48)
- **Tonal Layering**: Use opacity/lightness to create depth, not borders
- **Floating Cards**: Elevated surfaces with shadows, no border outlines
- **No Borders**: Avoid 1px borders entirely — use tonal differences instead

### Typography Hierarchy

| Style | Usage | Weight |
|-------|-------|--------|
| Display | Large hero numbers, totals | 700 |
| Headline | Screen titles, section headers | 600 |
| Title | Card titles, important labels | 500 |
| Body | Descriptions, amounts | 400 |
| Label | Timestamps, metadata | 400 |

### Forbidden Patterns

- ❌ No 1px borders on cards or inputs
- ❌ No dividers (use spacing and tonal shifts instead)
- ❌ No pure black (`#000000`) text — use neutral base or opacity variants
- ❌ No flat designs — always use shadows for elevation

---

## Engram

Persistent memory system for AI coding agents — remembers what you build so you never have to repeat yourself.

### What is Engram?

Engram is a persistent memory system designed for AI coding agents. It stores architectural decisions, bug fixes, patterns, and discoveries that survive across sessions and compactions. Think of it as a collective memory for your development workflow.

### Installation

#### macOS / Linux

```bash
brew install gentleman-programming/tap/engram
```

#### Windows

```bash
go install github.com/Gentleman-Programming/engram/cmd/engram@latest
```

### Setup for OpenCode

```bash
engram setup opencode
```

### Available MCP Tools

| Tool | Purpose |
|------|---------|
| `mem_save` | Save important observations with title, type, and structured content |
| `mem_search` | Full-text search across all past sessions |
| `mem_context` | Get recent context from previous sessions |
| `mem_session_start` | Mark the beginning of a coding session |
| `mem_session_end` | Mark session completion with summary |
| `mem_session_summary` | Save comprehensive end-of-session summaries |
| `mem_get_observation` | Retrieve full untruncated content of specific observations |
| `mem_update` | Update existing observations by ID |
| `mem_suggest_topic_key` | Suggest stable topic keys for evolving topics |

### Agent Compatibility

Engram is agent-agnostic and works with:
- **OpenCode** (current)
- **Claude Code**
- **Gemini CLI**
- **Other MCP-compatible agents**

### Repository

For more information, visit: https://github.com/Gentleman-Programming/engram

### Importing Memories

If you already have memories stored locally and want to import them after pulling from git:

```bash
engram sync --import
```

This command imports memories from another machine or restores your synced memories.

### Syncing Memories

Before pushing to GitHub, export your memories as a compressed chunk:

```bash
engram sync
git add .engram/
git commit -m "sync engram memories"
git push
```

---

### Screens

1. **Expense List**: Shows all expenses with modern card design
2. **Create Expense**: Form with validation and loading state
3. **Balance Screen**: Displays totals and debt relationships

### Current State

- ✅ All agents created and configured
- ✅ Gasto model with amount, description, date, payer, and creation timestamp
- ✅ GastoService as singleton for data sharing across screens
- ✅ Fiscal Atelier theme implemented (Precision Journal design system)
- ✅ Color palette: Primary #0a8d6a, Secondary #597f6e, Accent #c4645b, Neutral #737874
- ✅ Dropdown for payer selection (Sienna, Robert)
- ✅ Loading state fixed with proper loading indicators
- ✅ Modern UI screens with floating cards, shadows, and 8px spacing
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
