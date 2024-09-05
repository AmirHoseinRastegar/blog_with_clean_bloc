import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onCallBack;
  const CustomButton({super.key, required this.title, required this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
        ],
        begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onCallBack,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppPallete.transparentColor,
          fixedSize: const Size(395, 70),
          shadowColor: AppPallete.transparentColor,
        ),
        child:  Text(
         title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
        ),
      ),
    );
  }
}
