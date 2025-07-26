import 'package:shared_preferences/shared_preferences.dart';

class DiaryStorage {
  static const String _key = 'diary_entries';

  /// 일기 추가
  static Future<void> saveEntry(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> currentEntries = prefs.getStringList(_key) ?? [];

    final now = DateTime.now();
    final formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final entryWithDate = '$formattedDate|$entry'; // 날짜를 앞에 붙임 (구분자는 | 사용)
    currentEntries.add(entryWithDate);

    await prefs.setStringList(_key, currentEntries);
  }

  /// 저장된 모든 일기 불러오기
  static Future<List<String>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  /// 모든 일기 초기화 (테스트나 리셋용)
  static Future<void> clearEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// 특정 인덱스의 일기 삭제
  static Future<void> deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = prefs.getStringList(_key) ?? [];

    if (index >= 0 && index < entries.length) {
      entries.removeAt(index);
      await prefs.setStringList(_key, entries);
    }
  }
}
