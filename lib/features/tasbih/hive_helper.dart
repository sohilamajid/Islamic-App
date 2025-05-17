import 'package:hive/hive.dart';

class HiveHelper {
  static const tasbihBox = "TASBIH_BOX";
  static const tasbihBoxKey = "TASBIH_BOX_KEY";
  static var myBox = Hive.box(tasbihBox);
  static List<Map<String, dynamic>> tasbihList = [];

  static Future<void> initializeTasbihList() async {
    await getList();
  }

  static void saveCount(String thikr, int count) {
    myBox.put(thikr, count);
  }

  static void resetCount()async{

  }

  static int getCount(String thikr) {
    return myBox.get(thikr, defaultValue: 0);
  }

  static Future<void> removeAll() async {
    tasbihList.clear();
    await myBox.clear();
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
        ];
      }
    }
  }

  static int getTotalCount() {
    return tasbihList.fold<int>(0, (sum, item) => sum + (item['count'] as int)); // Ensure count is treated as int
  }
}