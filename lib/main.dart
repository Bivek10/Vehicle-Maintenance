import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';
import 'package:vehicle_maintainance/src/home_page.dart';
import 'package:vehicle_maintainance/src/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckLogin(),
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  SessionManager sessionManager = SessionManager();
  String? userid;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    userid = await sessionManager.getUserID();
    //print(userid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return userid == null ? LoginPage() : HomePage();
  }
}
