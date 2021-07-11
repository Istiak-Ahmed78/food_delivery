import 'package:flutter/cupertino.dart';

class TabIndex extends ChangeNotifier {
  int localIndex = 2;
  int get currentIndex => localIndex;
  setIndex(index) {
    localIndex = index;
    notifyListeners();
  }
}
