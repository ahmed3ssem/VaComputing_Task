import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:va_task/presenter/result_presenter.dart';
import 'package:va_task/presenter/result_presenter_componant.dart';
import 'package:va_task/view/result_view_componant.dart';

class ResultView extends StatefulWidget{
  const ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> implements ResultViewComponant{
  bool _islistEmpty =  false;
  String _message = '';
  List _results = [];
  late ResultPresenterComponant _componant;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _componant = ResultPresenter();
    _componant.setView(this);
    _componant.getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('resultAppBar'.tr().toString()),
      ),
      body: _islistEmpty ? Center(child:  Text(_message , style: const TextStyle(color: Colors.blueGrey , fontSize: 20 , fontWeight: FontWeight.bold),),) : ListView.builder(itemCount: _results.length , itemBuilder: (ctx , pos){
        return Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation:  8,
            child: ListTile(
              leading:CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(pos.toString()),
              ),
              title: Text(_results[pos]['name'] , style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
        );
      })
    );
  }


  @override
  void emptyList(String message) {
    // TODO: implement emptyList
    setState(() {
      _islistEmpty = true;
      _message = message;
    });
  }

  @override
  void onError(String message) {
    // TODO: implement onError
    setState(() {
      _islistEmpty = true;
      _message = message;
    });
  }

  @override
  void onSuccess(List results) {
    // TODO: implement onSuccess
    setState(() {
      _results = results;
    });
  }
}
