# Architecture Documentation

## Overview

Focus Quest follows a **Feature-First Clean Architecture** pattern with clear separation between Domain, Data, and Presentation layers. The application uses **Riverpod** for state management and dependency injection.

## Architecture Layers

### 1. Domain Layer (`lib/features/*/domain`)
- Contains business logic and rules
- Defines abstract repository interfaces
- Independent of frameworks and implementation details
- Example: `TaskRepository` interface

### 2. Data Layer (`lib/features/*/data`)
- Implements repository interfaces
- Manages data sources (local DB, remote API)
- Handles data transformations
- Example: `LocalTaskRepository` implementation

### 3. Presentation Layer (`lib/features/*/presentation`)
- UI components and screens
- Uses Riverpod for state management
- Consumes data through repositories
- Example: `DashboardScreen`, `CreateTaskScreen`

## Core Infrastructure

### Configuration (`lib/core/config`)
- **EnvConfig**: Centralizes environment-specific configuration
- Supports environment variables for sensitive data
- Default values for development

### Utilities (`lib/core/utils`)
- **AppLogger**: Centralized logging utility
  - Respects debug/release modes
  - Provides structured logging with tags
  - Can be extended with proper logging frameworks
  
- **Result**: Type-safe error handling
  - Replaces exceptions for expected errors
  - Enables exhaustive error handling
  - Pattern matching support

### Database (`lib/core/database`)
- **Drift** for local SQLite storage
- Offline-first architecture
- Sync with Supabase backend

### Services (`lib/core`)
- **SyncService**: Handles data synchronization
  - Push local changes to remote
  - Pull remote changes to local
  - Conflict resolution (last-write-wins strategy)
  
### Router (`lib/core/router`)
- **GoRouter** for navigation
- Auth state-based routing
- Guest mode support

## Best Practices

### 1. Dependency Injection
All services and dependencies are registered as Riverpod providers:
- `databaseProvider`: App database instance
- `syncServiceProvider`: Sync service instance
- Repository providers in feature modules

### 2. Error Handling
- Use `Result<T, E>` type for operations that can fail
- Log errors using `AppLogger` instead of `print()`
- Provide meaningful error messages to users

### 3. Configuration Management
- Never hardcode credentials in source code
- Use `EnvConfig` for all environment-specific values
- Keep `.env` files out of version control

### 4. Code Organization
```
lib/
├── core/                    # Shared infrastructure
│   ├── config/             # Configuration
│   ├── database/           # Database setup
│   ├── router/             # Navigation
│   ├── utils/              # Utilities
│   └── providers.dart      # Core providers
└── features/               # Feature modules
    └── feature_name/
        ├── domain/         # Business logic
        ├── data/           # Data sources
        └── presentation/   # UI
```

## Security Considerations

1. **Credentials**: All sensitive credentials are managed through `EnvConfig`
2. **Logging**: Debug logs are disabled in release builds
3. **Type Safety**: Explicit type checking for external data

## Future Improvements

1. **Domain Entities**: Create separate domain models independent of Drift
2. **DTOs**: Add Data Transfer Objects for API communication
3. **Use Cases**: Add explicit use case layer for complex business logic
4. **Proper Logging Framework**: Consider adding `talker` or similar
5. **Advanced Conflict Resolution**: Implement CRDTs or operational transforms
6. **Unit Testing**: Add comprehensive test coverage for business logic

## Development Workflow

1. Run code generation:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. Lint code:
   ```bash
   flutter analyze
   ```

3. Run tests:
   ```bash
   flutter test
   ```

## References

- [Riverpod Documentation](https://riverpod.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
