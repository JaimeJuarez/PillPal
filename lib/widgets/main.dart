import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/blocks/provider.dart';
import 'package:flutter_application_1/objects/cart_model.dart';
import 'package:flutter_application_1/pages/edit_inventary.dart';
import 'package:flutter_application_1/pages/edit_user.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/pastillas.dart';
import 'package:flutter_application_1/pages/pillpal_mainpage.dart';
import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/pages/tratamientos.dart';
import 'package:flutter_application_1/pages/edit_medicine.dart';
import 'package:flutter_application_1/pages/register_medicine.dart';
import 'package:flutter_application_1/pages/cronicalDisease.dart';
import 'package:flutter_application_1/pages/register_cronicaldisease.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../pages/registrer_inventary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: ProviderLogin(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PILL PAL',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: LoginPage.id,
          routes: {
            LoginPage.id: (_) => const LoginPage(),
            RegisterUser.id: (_) => const RegisterUser(),
            RegisterInventary.id: (_) => const RegisterInventary(),
            EditInventary.id: (_) => const EditInventary(),
            EditUser.id: (_) => const EditUser(),
            Tratamientos.id: (_) => const Tratamientos(),
            EditMedicine.id: (_) => const EditMedicine(),
            RegisterMedicine.id: (_) => const RegisterMedicine(),
            CronicalDisease.id: (_) => const CronicalDisease(),
            RegisterCronicalDisease.id: (_) => const RegisterCronicalDisease(),
            PillPalMainPage.id: (_) => const PillPalMainPage(),
            Pastillas.id: (_) => const Pastillas(),
          },
        ),
      ),
    );
  }
}
