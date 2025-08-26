import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static String get supabaseUrl {
    // Prioritize compile-time variables for security in release builds.
    const fromEnv = String.fromEnvironment('SUPABASE_URL');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    // Fallback to .env for local development convenience.
    if (kDebugMode) {
      return dotenv.env['SUPABASE_URL'] ?? '';
    }
    // Return empty string in release if not provided, causing a controlled failure.
    return '';
  }

  static String get supabaseAnonKey {
    // Prioritize compile-time variables for security in release builds.
    const fromEnv = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    // Fallback to .env for local development convenience.
    if (kDebugMode) {
      return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    }
    // Return empty string in release if not provided, causing a controlled failure.
    return '';
  }
}