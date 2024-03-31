import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';

class ButtonComponent extends StatelessWidget {
  final String buttonText;
  final Widget targetPage;
  final bool isReplacementPush ;

  const ButtonComponent({
    super.key,
    required this.buttonText,
    required this.targetPage,
    this.isReplacementPush = false
  });

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
          onPressed: () {
            !isReplacementPush ? () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => targetPage,
              ),
            ) : Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => targetPage
                  ),
                  (route) => false,
                );
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