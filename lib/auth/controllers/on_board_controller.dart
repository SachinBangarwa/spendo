import 'package:get/get.dart';

class OnBoardController extends GetxController{

  RxInt changeIndex=0.obs;

  void changeValue(int index){
    changeIndex.value=index;
  }

}