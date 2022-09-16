import 'package:bright_fit/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///Keep device in vertical orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
    runApp(LoginView());
  });
}
