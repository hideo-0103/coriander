import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  String nameText = 'hideoさん';

  void changeNameText(){
    nameText = 'hideoさんかっこいい';
    notifyListeners();
  }
}