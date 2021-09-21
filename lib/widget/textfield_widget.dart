import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {

  final TextEditingController _controller;
  final String name;
  final TextInputType _inputType;


  TextFieldWidget(this._controller, this.name, this._inputType);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10 , right: 15 , left: 15),
      //height: 55,
      child: TextField(
        controller: widget._controller,
        keyboardType: widget._inputType,
        decoration: InputDecoration(
          labelText: widget.name,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
