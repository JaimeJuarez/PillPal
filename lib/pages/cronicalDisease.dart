// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocks/provider.dart';
import 'package:flutter_application_1/pages/register_cronicaldisease.dart';
import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/pages/tratamientos.dart';
import 'package:flutter_application_1/pages/user_page.dart';
import 'package:flutter_application_1/pages/pillpal_mainpage.dart';

class CronicalDisease extends StatefulWidget {
  static String id = "cronical_disease";
  final userName;
  // const CronicalDisease({Key key,}) : super(key: key);
  // const CronicalDisease({Key key, userName}) : super(key: key);
  const CronicalDisease({Key key, this.userName}) : super(key: key);

  @override
  State<CronicalDisease> createState() => _CronicalDiseaseState();
}

class _CronicalDiseaseState extends State<CronicalDisease> {
  @override
  Widget build(BuildContext context) {
    final bloc = ProviderLogin.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: CustomAppBar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Bienvenido, ${widget.userName}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 62, 100, 104),
                      fontFamily: 'Heebo',
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      // padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "¿TIENES ALGUNA ENFERMEDAD CRONICA?",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromARGB(255, 22, 22, 22),
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [],
                ),
                _columnLogin(bloc),
              ],
            ),
          )),
      // ),
    );
  }

  Widget _buttonAffirmative() {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 115.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, RegisterCronicalDisease.id);
          setState(() {});
        },
        // color: const Color.fromARGB(255, 0, 0, 0),
        color: Color.fromARGB(255, 62, 100, 104),
        child: Text(
          'Afirmativo'.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: ""),
        ));
  }

  Widget _buttonNegative() {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 125.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, PillPalMainPage.id);
          setState(() {});
        },
        // color: const Color.fromARGB(255, 0, 0, 0),
        color: Color.fromARGB(255, 62, 100, 104),
        child: Text(
          'Negativo'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _columnLogin(LoginBloc bloc) {
    return Column(
      children: [
        const SizedBox(
          height: 45.0,
        ),
        Align(
          alignment: Alignment.center,
          child: _buttonAffirmative(),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Align(
          alignment: Alignment.center,
          child: _buttonNegative(),
        ),
        // _buttonRegister(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 62, 100, 104),
            Color.fromARGB(255, 34, 54, 66),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   width: 1,
          // )
          SizedBox(height: 35.0)
        ],
      ),
    );
  }
}
