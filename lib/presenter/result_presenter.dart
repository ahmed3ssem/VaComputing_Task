import 'package:va_task/helper/db_helper.dart';
import 'package:va_task/presenter/result_presenter_componant.dart';
import 'package:va_task/view/result_view_componant.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultPresenter implements ResultPresenterComponant{

  late ResultViewComponant _componant;
  List results = [];

  @override
  void getResults() {
    // TODO: implement getResults
    DBHelper.getData('result_table').then((value){
      if(value.isEmpty){
        _componant.emptyList('emptyList'.tr().toString());
      } else {
        _componant.onSuccess(value);
      }
    });
  }

  @override
  void setView(ResultViewComponant componant) {
    // TODO: implement setView
    _componant = componant;
  }
}