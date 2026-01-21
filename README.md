# Focus Quest 🧠

An ADHD-friendly Task Scheduling App built with Flutter.

## 🚀 Getting Started

This project is an **Offline-First** application that uses **Supabase** for the backend and **Drift** for local storage.

### Prerequisites

1.  **Flutter SDK**: Ensure Flutter is installed and in your PATH.
2.  **Supabase Account**: You need a Supabase project.

### 🛠 Setup Instructions

1.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Generate Code**:
    This project uses `build_runner` for Riverpod and Drift. You MUST run this command before the app will compile:
    ```bash
    dart run build_runner build -d
    ```

3.  **Supabase Setup**:
    - Go to your Supabase Dashboard -> SQL Editor.
    - Copy the contents of `supabase_schema.sql` and run it.
    - Copy your Supabase URL and Anon Key.
    - For development: Update the default values in `lib/core/config/env_config.dart`.
    - For production: Set `SUPABASE_URL` and `SUPABASE_ANON_KEY` environment variables.

4.  **Run the App**:
    ```bash
    flutter run
    ```

## 🏗 Architecture

The app follows a **Feature-First** architecture with **Riverpod** for state management.

-   **Domain Layer**: Defines entities and abstract repositories (`lib/features/tasks/domain`).
-   **Data Layer**: Implements repositories using Drift (`lib/features/tasks/data`).
-   **Presentation Layer**: UI logic and Widgets (`lib/features/tasks/presentation`).

For detailed architecture documentation, see [ARCHITECTURE.md](./ARCHITECTURE.md).

## 📱 Features Implemented (MVP)

-   **Offline-First Database**: Tasks are saved locally in SQLite.
-   **Dashboard**: "Quick Start" algorithm to suggest tasks based on available time.
-   **Task Creation**: Create tasks with urgency, duration, and deadline.
-   **Calm UI**: Designed with specific colors to reduce anxiety.

## 🧩 Outstanding Tasks

-   **Supabase Integration**: initialize Supabase in `main.dart`.
-   **Sync Logic**: Implement the background sync worker.
-   **Gamification**: Add the reward system.
