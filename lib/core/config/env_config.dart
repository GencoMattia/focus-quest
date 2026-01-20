/// Environment configuration for the application.
/// 
/// This class manages environment-specific settings like API keys and URLs.
/// For production, these values should be loaded from environment variables.
class EnvConfig {
  /// Supabase project URL
  /// 
  /// For development: Set directly in code (not recommended for production)
  /// For production: Load from environment variable or secure storage
  static String get supabaseUrl {
    // TODO: Load from environment variable in production
    // For now, return the development value
    return const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://zsoedqtarozpwnpxajrc.supabase.co',
    );
  }

  /// Supabase anonymous (public) key
  /// 
  /// For development: Set directly in code (not recommended for production)
  /// For production: Load from environment variable or secure storage
  static String get supabaseAnonKey {
    // TODO: Load from environment variable in production
    // For now, return the development value
    return const String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpzb2VkcXRhcm96cHducHhhanJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg4NDQxMDcsImV4cCI6MjA4NDQyMDEwN30.Z7CI8yhdABNk8GKzlGNG5a9A_U4lybrbFFv5P09cuLM',
    );
  }
}
