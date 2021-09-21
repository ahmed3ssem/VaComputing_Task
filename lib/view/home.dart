import 'package:flutter/material.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:va_task/home_model.dart';
import 'package:va_task/presenter/home_presenter.dart';
import 'package:va_task/presenter/home_presenter_componant.dart';
import 'package:va_task/utils/common.dart';
import 'package:va_task/view/result_view.dart';
import 'package:va_task/widget/show_message.dart';
import 'package:va_task/widget/textfield_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import 'home_view_componant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeViewComponent{

  String operaion = '' , result = '';
  late HomePresenterComponant _componant;
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operaion = Common.operations[0];
    _componant =  HomePresenter();
    _componant.setView(this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            TextFieldWidget(_firstNumberController , 'firstNumber'.tr().toString() , TextInputType.number),
            TextFieldWidget(_secondNumberController , 'secondNumber'.tr().toString() , TextInputType.number),
            operationDropDownMenu(),
            TextFieldWidget(_timeController , 'timeInSec'.tr().toString() , TextInputType.number),
            resultText(),
            calculateButton(),
            locationButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                showResultsButton(),
                showPendingsButton()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget operationDropDownMenu(){
    return FractionallySizedBox(
      widthFactor: 0.92,
      child: Container(
        margin: const EdgeInsets.only(top: 10 , bottom: 10),
        padding: const EdgeInsets.only(right: 10 , left: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey
            ),
            borderRadius:const  BorderRadius.all(Radius.circular(10))
        ),
        child: DropdownButton<String>(
          value: operaion,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          underline: const Text(''),
          elevation: 10,
          onChanged: (String? newValue) {
            setState(() {
              operaion = newValue!;
            });
          },
          items: Common.operations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget calculateButton(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue
        ),
        onPressed: (){
          HomeModel _model =  HomeModel(_firstNumberController.value.text.toString(), _secondNumberController.value.text.toString(), operaion, _timeController.value.text.toString());
          _componant.validateFields(_model);
          _firstNumberController.clear();
          _secondNumberController.clear();
          _timeController.clear();
        },
        child:  Text('calculate'.tr().toString() , style:  const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget locationButton(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue
        ),
        onPressed: ()=>_componant.getLocation(),
        child:  Text('location'.tr().toString() , style:  const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget resultText(){
    return Container(
      margin: const EdgeInsets.only(top: 10 , bottom: 10),
      child: Text(result , style: const TextStyle(color: Colors.green , fontSize: 18),),
    );
  }

  Widget showResultsButton(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue
        ),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ResultView()),),
        child:  Text('showResults'.tr().toString() , style:  const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget showPendingsButton(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue
        ),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ResultView()),),
        child:  Text('showPending'.tr().toString() , style:  const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void showLocation(LocationData location) {
    // TODO: implement showLocation
    ToastMessage.showSnackBar('longitude'.tr().toString()+location.longitude.toString()+"\n"+"latitude".tr().toString()+location.latitude.toString(), context, const Duration(seconds: 10));
  }

  @override
  void onError(String message) {
    // TODO: implement onError
    ToastMessage.showSnackBar(message, context,const Duration(seconds: 5));
  }

  @override
  void onSuccess(String message) {
    // TODO: implement onSuccess
    setState(() {
      result = message;
    });
  }
}
