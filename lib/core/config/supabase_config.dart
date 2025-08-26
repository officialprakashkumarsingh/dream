class SupabaseConfig {
  // Get keys from compile-time variables.
  // Throws an error if the key is not provided during build, ensuring a secure-by-default setup.
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}