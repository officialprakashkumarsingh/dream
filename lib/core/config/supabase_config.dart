import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static String _decode(String value) {
    if (value.isEmpty) return '';
    try {
      return utf8.decode(base64.decode(value));
    } catch (e) {
      // Return the original value if it's not valid base64
      return value;
    }
  }

  // Try to get from build-time variables, otherwise fall back to .env file
  static String get supabaseUrl {
    const fromEnv = String.fromEnvironment('SUPABASE_URL');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    return _decode(dotenv.env['SUPABASE_URL'] ?? '');
  }

  static String get supabaseAnonKey {
    const fromEnv = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }
    return _decode(dotenv.env['SUPABASE_ANON_KEY'] ?? '');
  }
}