import 'dart:convert';

import 'package:fibro_pred/Activities/MainPage.dart';
import 'package:fibro_pred/Components/CustomButton.dart';
import 'package:fibro_pred/Components/CustomTextInput.dart';
import 'package:fibro_pred/Utils/AccessNavigator.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:fibro_pred/Utils/StorageService.dart';
import 'package:fibro_pred/Utils/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/WebService/AuthService.dart';
import '../Utils/WebService/WebService.dart';
import '../Utils/WebService/WebServicesVariables.dart';
import 'RegisterActivity.dart';

class Loginactivity extends StatefulWidget {
  const Loginactivity({super.key});

  @override
  State<Loginactivity> createState() => _LoginactivityState();
}

class _LoginactivityState extends State<Loginactivity> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkSession() async {
    String? token = await StorageService().getSessionToken();
    if (token != null || token != "") {
      AccessNavigator.goToAndReplace(context, MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(fit: BoxFit.fill, 'assets/logo.svg'),
                          Text("FibroPred",
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: CustomColors.primary,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextInput(
                          controller: emailController, placeholder: "E-mail"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextInput(
                          obscure: true,
                          controller: passwordController,
                          placeholder: "Password"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: CustomColors.primary,
                          )
                        : Custombutton(
                            text: "Entrar",
                            onPress: () async {
                              isLoading = true;
                              WebService(baseUrl: WebServicesVariables.BASE_URL)
                                  .post(
                                      "login",
                                      {
                                        "mail": emailController.text,
                                        "password": passwordController.text
                                      },
                                      false)
                                  .then((value) {
                                if (value.statusCode != 200) {
                                  print(value.body);

                                  ToastService.showError(
                                      message: "Login Failed!");
                                } else {
                                  print(value.body);
                                  StorageService().saveSessionToken(
                                      jsonDecode(value.body)["token"]);
                                  AccessNavigator.goToAndReplace(
                                      context, MainPage());
                                }
                              });
                              isLoading = false;
                            }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custombutton(
                      shadow: false,
                      text: "No Tens compte? Registra't",
                      onPress: () {
                        AccessNavigator.goTo(context, RegisterActivity());
                      },
                      textColor: CustomColors.primary,
                      color: Colors.transparent),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
