import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountController extends GetxController {
  // this is a counter controller for increment decrement and also a API EXAMPLE
  // Basically counter controller is working like a simple data handler for application
  // This fetches the data and communicates the presention screen with what is neeeded
  // and most importantly updates only the part required.

  // Getx comes up with its inbuilt highly custom components like dialog , snackbar, etc.

  static CountController get to => Get.find();
  // OBS values are something which are observed via widget tree for updates and builds ui accordingly
  var obxCount = 0.obs;
  int simpleCount = 0;
  String? msg;

  void increment() {
    obxCount.value++;
    if (obxCount.value >= 1 && obxCount.value <= 1) {
      Get.snackbar(
        'Incremented',
        'Count incremented to ${obxCount.value.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } else if (obxCount.value % 2 == 0) {
      Get.snackbar('Even Count', 'Even number is ${obxCount.value.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1));
    } else if (obxCount.value % 5 == 0) {
      // Snackbar example
      Get.snackbar('hi', 'Count has reached ${obxCount.value.toString()}',
          borderRadius: 2, icon: const Icon(Icons.abc));
    }
  }

  // Decrement counter with inbuilt dialog
  void decrement() {
    obxCount.value--;
    if (obxCount.value <= 0) {
      obxCount.value = 0;
      Get.defaultDialog(
        radius: 10.0,
        contentPadding: const EdgeInsets.all(20.0),
        title: 'Brr No Negative',
        middleText: 'You cannot decrement counter into negative number',
        textConfirm: 'Okay',
        confirm: OutlinedButton.icon(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.check,
            color: Colors.blue,
          ),
          label: const Text(
            'Okay',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      );
    }
  }

  void simpleDecrement() {
    simpleCount--;
    update();
  }

  void simpleIncrement() {
    simpleCount++;
    update();
  }

  Dio dio = Dio();

  Future getMainData() async {
    try {
      var response = await Dio().get('https://reqres.in/api/users/2');
      String _firstName = response.data['data']['first_name'];
      String _lastName = response.data['data']['last_name'];
      Get.snackbar('Example from Reqres.in', _firstName + " " + _lastName,
          borderRadius: 2, icon: const Icon(Icons.person));
    } catch (e) {
      debugPrint("$e");
    }
  }
}
