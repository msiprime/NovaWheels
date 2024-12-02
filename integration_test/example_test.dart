import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

// void main() {
//   patrolTest(
//     'counter state is the same after going to home and switching apps',
//     ($) async {
//       $.native.pressHome();
//       $.native.enableBluetooth();
//       $.native.openApp(appId: 'com.example.nova_wheels');
//       $.native.pressVolumeUp();
//       $.native.pressVolumeDown();
//       $.native.disableBluetooth();
//
//       await $.pumpWidgetAndSettle(Application());
//
//       await $(#emailTextField).enterText('charlie@root.me');
//       await $(#nameTextField).enterText('Charlie');
//       await $(#passwordTextField).enterText('ny4ncat');
//       await $(#termsCheckbox).tap();
//       await $(#signUpButton).tap();
//
//       await $('Welcome, Charlie!').waitUntilVisible();
//
//       expect($('app'), findsOneWidget);
//       if (!Platform.isMacOS) {
//         await $.native.pressHome();
//       }
//     },
//   );
// }

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      // Replace later with your app's main widget
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('app')),
            backgroundColor: Colors.blue,
          ),
        ),
      );

      expect($('app'), findsOneWidget);
      if (!Platform.isMacOS) {
        await $.native.pressHome();
      }
    },
  );
}
