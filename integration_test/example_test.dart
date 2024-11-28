// // example/integration_test/example_test.dart
// import 'package:nova_wheels/core/application/my_app.dart';
// import 'package:patrol/patrol.dart';
//
// void main() {
//   patrolTest(
//     'counter state is the same after going to home and going back',
//     ($) async {
//       await $.pumpWidgetAndSettle(const Application());
//
//       // await $(FloatingActionButton).tap();
//       // expect($(#counterText).text, '1');
//       //
//       // await $.native.pressHome();
//       // await $.native.pressDoubleRecentApps();
//       //
//       // expect($(#counterText).text, '1');
//       // await $(FloatingActionButton).tap();
//       // expect($(#counterText).text, '2');
//       //
//       // await $.native.openNotifications();
//       // await $.native.pressBack();
//     },
//   );
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

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
