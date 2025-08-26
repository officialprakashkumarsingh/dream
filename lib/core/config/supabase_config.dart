import 'api_config.dart';

class SupabaseConfig {
  // Try to get from build-time variables, otherwise fall back to encrypted config
  static String get supabaseUrl {
    const fromEnv = String.fromEnvironment('SUPABASE_URL');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    return ApiConfig.getSupabaseUrl();
  }

  static String get supabaseAnonKey {
    const fromEnv = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    return ApiConfig.getSupabaseAnonKey();
  }
}