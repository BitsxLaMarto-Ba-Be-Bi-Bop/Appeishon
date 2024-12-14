import 'dart:math';

import 'package:fibro_pred/Components/CustomDateTimeInput.dart';
import 'package:fibro_pred/Utils/WebService/WebServicesVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import '../Components/CustomButton.dart';
import '../Components/CustomSelectorInput.dart';
import '../Components/CustomTextInput.dart';
import '../Utils/AccessNavigator.dart';
import '../Utils/CustomColors.dart';
import '../Utils/ToastService.dart';
import '../Utils/WebService/AuthService.dart';
import '../Utils/WebService/WebService.dart';
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
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController familyHistoryPersonController =
      TextEditingController(text: "");
  TextEditingController familyHistoryController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController tratmentController = TextEditingController();
  TextEditingController pillsController = TextEditingController();
  String? selectedGender;
  String? smoker;
  // String? treatment;

  bool isLoading = false;
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                      _buildHealthInfoPage(),
                    ],
                  ),
                ),
                _buildNavigationButtons(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custombutton(
                    shadow: false,
                    text: "Tens compte? Inicia sessió",
                    onPress: () {
                      AccessNavigator.goToAndReplace(context, Loginactivity());
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

  Widget _buildAdditionalMedication() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: tratmentController, placeholder: "Tractament"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: pillsController, placeholder: "Medicacio"),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoPage() {
    return Column(
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
        _buildGenderSelector(),
      ],
    );
  }

  Widget _buildHealthInfoPage() {
    return Column(
      children: [
        _buildSmokerSelector(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: familyHistoryController,
              placeholder: "Antecedentes familiares (Persona)"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: familyHistoryPersonController,
              placeholder: "Antecedentes familiares (Malaltia) "),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: allergiesController, placeholder: "Alergias"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomDropDown(
            values: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
            placeholder: "Tipo de Sangre",
            items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
            controller: bloodTypeController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: weightController, placeholder: "Peso (kg)"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextInput(
              controller: heightController, placeholder: "Altura (cm)"),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      children: [
        ListTile(
          title: const Text("Male"),
          leading: Radio<String>(
            value: "Male",
            groupValue: selectedGender,
            onChanged: (value) => setState(() => selectedGender = value),
          ),
        ),
        ListTile(
          title: const Text("Female"),
          leading: Radio<String>(
            value: "Female",
            groupValue: selectedGender,
            onChanged: (value) => setState(() => selectedGender = value),
          ),
        ),
        ListTile(
          title: const Text("Other"),
          leading: Radio<String>(
            value: "Other",
            groupValue: selectedGender,
            onChanged: (value) => setState(() => selectedGender = value),
          ),
        ),
      ],
    );
  }

  Widget _buildSmokerSelector() {
    return Column(
      children: [
        ListTile(
          title: const Text("¿Fumas?"),
          leading: Checkbox(
            value: smoker == "Yes",
            onChanged: (value) =>
                setState(() => smoker = value! ? "Yes" : "No"),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentPage > 0)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Custombutton(
                text: "Back",
                onPress: () => pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        if (currentPage < 2)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Custombutton(
                text: "Next",
                onPress: () => pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        if (currentPage == 2)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Custombutton(
                text: "Registra't",
                onPress: () async {
                  setState(() => isLoading = true);
                  collectRegistrationData();
                  setState(() => isLoading = false);
                },
              ),
            ),
          ),
      ],
    );
  }

  Future<void> collectRegistrationData() async {
    Response response =
        await WebService(baseUrl: WebServicesVariables.BASE_URL).post(
            "users/patients",
            {
              "name": emailController.text,
              "nif": dniController.text,
              "email": emailController.text,
              "password": passwordController.text,
              "birtdate": dateController.text.split("-").reversed.join("-"),
              "gender": selectedGender ?? "",
              "tobaco": smoker == "Yes",
              "tratment": tratmentController.text ?? "",
              "pills": pillsController.text,
              "blood_type": bloodTypeController.text,
              "preceding_person": familyHistoryPersonController.text,
              "preceding_illnes": familyHistoryController.text,
              "alergies": allergiesController.text,
              "weight": int.tryParse(weightController.text) ?? 0,
              "height": int.tryParse(heightController.text) ?? 0
            },
            false);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      ToastService.showError(message: "Error registering patient!");
    } else {
      ToastService.showSuccess(message: "Patient Registered!");
      AccessNavigator.goToAndReplace(context, Loginactivity());
    }
  }
}
