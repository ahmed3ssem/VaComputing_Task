import 'dart:async';
import 'package:va_task/helper/db_helper.dart';
import 'package:va_task/home_model.dart';
import 'package:va_task/presenter/home_presenter_componant.dart';
import 'package:location/location.dart';
import 'package:va_task/view/home_view_componant.dart';

class HomePresenter implements HomePresenterComponant{

  late HomeViewComponent _component;

  @override
  getLocation() async{
    var location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _component.showLocation(_locationData);
  }

  @override
  void setView(HomeViewComponent value) {
    // TODO: implement setView
    _component = value;
  }

  @override
  validateFields(HomeModel model) {
    // TODO: implement validateFields
    if (model.firstName.isEmpty) {
      _component.onError('Please Enter First Number');
    } else if (model.secondName.isEmpty) {
      _component.onError('Please Enter Second Number');
    } else if (model.operator.isEmpty) {
      _component.onError('Please Enter the operator');
    } else if (model.time.toString().isEmpty) {
      _component.onError('Please Enter the time');
    } else {
      addToQueue(model);
    }
  }

  addToQueue(HomeModel model) async{
    String message = '';
    double sum = 0;
    scheduleMicrotask(() {
      Future.delayed(Duration(seconds:int.parse(model.time)), () {
        if(model.operator == '+'){
          sum = double.parse(model.firstName) + double.parse(model.secondName);
        } else if(model.operator == '-'){
          sum = double.parse(model.firstName) - double.parse(model.secondName);
        } else if(model.operator == '*'){
          sum = double.parse(model.firstName) * double.parse(model.secondName);
        } else {
          sum = double.parse(model.firstName) / double.parse(model.secondName);
        }
        message = 'The Operation '+model.firstName.toString()+model.operator+model.secondName.toString()+' result = '+sum.toString();
        DBHelper.addResult('result_table', {
          'name': message,
        }).then((value) => print('done'));
        _component.onSuccess(message);
      });
    });
  }
}