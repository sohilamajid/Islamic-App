import 'package:hive/hive.dart';

class HiveHelper {
  static const tasbihBox = "TASBIH_BOX";
  static const tasbihBoxKey = "TASBIH_BOX_KEY";
  static const historyKey = "HISTORY_COUNTS";
  static var myBox = Hive.box(tasbihBox);
  static List<Map<String, dynamic>> tasbihList = [];
  static List<Map<String, dynamic>> historyList = [];

  static Future<void> initializeTasbihList() async {
    await getList();
  }

  static int getHistoryCount(String thikr) {
    final historyMap = Map<String, int>.from(myBox.get(historyKey, defaultValue: {}));
    return historyMap[thikr] ?? 0;
  }
  static int getHistoryTotalCount() {
    final historyMap = Map<String, int>.from(myBox.get(historyKey, defaultValue: {}));
    return historyMap.values.fold(0, (a, b) => a + b);
  }

  static void saveCount(String thikr, int count) {
    myBox.put(thikr, count);
    _saveHistoryCount(thikr);
  }

  static void _saveHistoryCount(String thikr) {
    Map<String, int> historyMap =
    Map<String, int>.from(myBox.get(historyKey, defaultValue: {}));

    historyMap[thikr] = (historyMap[thikr] ?? 0) + 1;
    myBox.put(historyKey, historyMap);
  }
  static Future<void> clearHistory() async {
    await myBox.put(historyKey, {});
  }

  static void resetCount()async{
    for (var thikr in ['لا إله إلا الله','استغفر الله', 'الحمد لله', 'سبحان الله', 'الله أكبر']) {
      myBox.put(thikr, 0);
    }
    await getList();
  }

  static int getCount(String thikr) {
    return myBox.get(thikr, defaultValue: 0);
  }

  static Future<void> removeAll() async {
    tasbihList.clear();
    await myBox.clear();
    await clearHistory();
    // await myBox.put(tasbihBoxKey, tasbihList);
  }

  static Future<void> getList() async {
    if (myBox.isNotEmpty) {
      List<Map<String, dynamic>> loadedList = List<Map<String, dynamic>>.from(myBox.get(tasbihBoxKey, defaultValue: []));
      tasbihList = loadedList;

      if (tasbihList.isEmpty) {
        tasbihList = [
          {'text': 'استغفر الله', 'count': getCount('استغفر الله')},
          {'text': 'الحمد لله', 'count': getCount('الحمد لله')},
          {'text': 'سبحان الله', 'count': getCount('سبحان الله')},
          {'text': 'الله أكبر', 'count': getCount('الله أكبر')},
          {'text': 'لا إله إلا الله', 'count': getCount('لا إله إلا الله')},
        ];
      }
    }
  }

  static int getTotalCount() {
    return tasbihList.fold<int>(0, (sum, item) => sum + (item['count'] as int)); // Ensure count is treated as int
  }
}