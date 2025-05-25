import 'package:bloc/bloc.dart';
import 'package:islamic/features/tasbih/hive_helper.dart';
import 'package:meta/meta.dart';
part 'athkar_state.dart';

class AthkarCubit extends Cubit<AthkarState> {
  AthkarCubit() : super(AthkarInitial());
  int totalCount = 0 ;
  int historyCount = 0;
  int historyTotalCount = 0;
  List<String> athkarList = [
    'استغفر الله',
    'الحمد لله',
    'سبحان الله',
    'الله أكبر',
    'لا إله إلا الله',
  ];
  String selectedThikr = 'استغفر الله';
  int count = 0;

  void resetCount(){
    emit(AthkarLoading());
    HiveHelper.resetCount();
    totalCount = HiveHelper.getTotalCount();
    count = HiveHelper.getCount(selectedThikr);
    emit(AthkarGetSuccess());
  }

  void loadCount() {
      totalCount = HiveHelper.getTotalCount();
      count = HiveHelper.getCount(selectedThikr);
      historyCount = HiveHelper.getHistoryCount(selectedThikr);
      historyTotalCount = HiveHelper.getHistoryTotalCount();
      emit(AthkarGetSuccess());
  }
  void incrementCount() {
    count++;
    totalCount++;
    HiveHelper.saveCount(selectedThikr, count);
    HiveHelper.getList();
    historyCount = HiveHelper.getHistoryCount(selectedThikr);
    historyTotalCount = HiveHelper.getHistoryTotalCount();
    emit(AthkarGetSuccess());
  }

  void saveCount(String thikr , int count){
    HiveHelper.saveCount(thikr, count);
    emit(AthkarGetSuccess());
  }

  void getCount(String thikr){
    HiveHelper.getCount(thikr);
    emit(AthkarGetSuccess());
  }

  void removeAll() async {
    emit(AthkarLoading());
    await HiveHelper.removeAll();
    emit(AthkarGetDeleteSuccess());
  }

  void getList()async{
    emit(AthkarLoading());
    await HiveHelper.getList();
    emit(AthkarGetSuccess());
  }

  void getTotalCount() {
    HiveHelper.getTotalCount();
    emit(AthkarGetSuccess());
  }

}
