import 'package:fibro_pred/Components/CustomDateTimeInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Components/CustomButton.dart';
import '../Components/CustomTextInput.dart';
import '../Utils/AccessNavigator.dart';
import '../Utils/CustomColors.dart';
import '../Utils/ToastService.dart';
import '../Utils/WebService/AuthService.dart';
import 'LoginActivity.dart';
import 'MainPage.dart';

class RegisterActivity extends StatefulWidget {
  const RegisterActivity({super.key});

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedGender;

  bool isLoading = false;
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(fit: BoxFit.fill, 'assets/logo.svg'),
                  Text(
                    "FibroPred",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      children: [
                        _buildAccountInfoPage(),
                        _buildAdditionalInfoPage(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custombutton(
                              text: "Back",
                              onPress: () {
                                pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ),
                      if (currentPage < 1)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custombutton(
                              text: "Next",
                              onPress: () {
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ),
                      if (currentPage == 1)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custombutton(
                              text: "Registra't",
                              onPress: () async {
                                setState(() => isLoading = true);
                                await AuthService.register().then((value) {
                                  if (value.statusCode != 200) {
                                    ToastService.showError(
                                        message: "Register Failed!");
                                  } else {
                                    AccessNavigator.goToAndReplace(
                                        context, MainPage());
                                  }
                                  setState(() => isLoading = false);
                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Custombutton(
                      shadow: false,
                      text: "Tens compte? Inicia sessió",
                      onPress: () {
                        AccessNavigator.goTo(context, Loginactivity());
                      },
                      textColor: CustomColors.primary,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfoPage() {
    return Column(
      children: [
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
              placeholder: "Contrasenya"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              obscure: true,
              controller: repeatPasswordController,
              placeholder: "Repeteix la contrasenya"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: dniController, placeholder: "DNI / NIE"),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: phoneController, placeholder: "Phone Number"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomDateTimeInput(
              placeholder: "Fecha de nacimiento", controller: dateController),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, right: 8.0, bottom: 8.0, left: 24.0),
          child: Text("Gender",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: const Text("Male"),
                leading: Radio<String>(
                  value: "Male",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Female"),
                leading: Radio<String>(
                  value: "Female",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Other"),
                leading: Radio<String>(
                  value: "Other",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
