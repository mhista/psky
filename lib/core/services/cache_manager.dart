
// ============================================================================
// CACHE MANAGER
// ============================================================================

import 'package:injectable/injectable.dart';

@lazySingleton
class ExamCacheManager {
  final Map<String, String> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  
  static const Duration _cacheExpiry = Duration(hours: 1);

  void cache(String key, String hash) {
    _cache[key] = hash;
    _cacheTimestamps[key] = DateTime.now();
  }

  bool isCached(String key) {
    if (!_cache.containsKey(key)) return false;

    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return false;

    // Check if cache has expired
    if (DateTime.now().difference(timestamp) > _cacheExpiry) {
      remove(key);
      return false;
    }

    return true;
  }

  String? getHash(String key) => _cache[key];

  void remove(String key) {
    _cache.remove(key);
    _cacheTimestamps.remove(key);
  }

  void clearAll() {
    _cache.clear();
    _cacheTimestamps.clear();
  }

  int get size => _cache.length;
}

