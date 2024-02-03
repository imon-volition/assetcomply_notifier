import 'package:assetcomply_notifier/constants/colors.dart';
import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:assetcomply_notifier/screens/otp_screen.dart';
import 'package:assetcomply_notifier/screens/select_lab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set full-screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
        ),
        home: const OtpScreen(),
      ),
    );
  }
}

