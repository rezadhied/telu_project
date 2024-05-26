import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ButtonComponent extends StatelessWidget {
  final String buttonText;
  final Widget targetPage;
  final bool isReplacementPush;
  final String action;
  final dynamic? data;
  final Function(String)? callback;
  final VoidCallback onPressed;

  const ButtonComponent({
    super.key,
    required this.buttonText,
    required this.targetPage,
    this.isReplacementPush = false,
    this.action = "",
    this.data,
    this.callback,
    VoidCallback? onPressed, // Removed the default value here
  }) : onPressed = onPressed ?? _defaultOnPressed; // Assign a default value

  // Named function for default onPressed
  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.black),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          onPressed: () async {
            final apiUrlProvider =Provider.of<ApiUrlProvider>(context, listen: false);
            
            bool berhasil = false;
            String callbackValue = "";

            // Action Logic Gate
            if (action == "signin") {
              berhasil = await AuthProvider().loginUser(data['email'], data['password'], apiUrlProvider.baseUrl);
              callbackValue = "Email or password are incorrect";
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("isStudent", data['email'].contains("student") ? "true" : "");
            } else if (action == "reg-1") {
              if (data['username'].isNotEmpty && data['password'].isNotEmpty && data['confirmPassword'].isNotEmpty) {
                if (data['password'] == data['confirmPassword']) {
                  berhasil = true;
                  callbackValue = "";
                } else {
                  callbackValue = "Missmatch confirm password value";
                }
              } else {
                callbackValue = "Fill out all fields";
              }
            } else if (action == "reg-2") {
              if (data?.values.every((value) => value != "") ?? false) {
                berhasil = await AuthProvider().registerUser(data);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("isStudent", data['isStudent'] == "true" ? "true" : "false");
              } else {
                callbackValue = "Fill out all fields";
              }

            } else {
              berhasil = true;
            }


            if (berhasil) {
              onPressed!.call();
              if (!isReplacementPush) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => targetPage,
                  ),
                );
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => targetPage),
                  (route) => false,
                );
              }
              callback!(callbackValue);
            } else {
              callback!(callbackValue);
            }
            
          },
          child: Text(
            buttonText,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
