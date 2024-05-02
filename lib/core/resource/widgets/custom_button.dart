import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color color;
  final Color textColor;
  final Widget? leadingImage;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color = const Color(0xff0D986A),
    this.textColor = const Color(0xFFFFFFFF),
    this.leadingImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 50,
          width: 360,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (leadingImage != null) leadingImage!,
                      if (leadingImage != null)
                        SizedBox(
                            width: 8), // Add spacing between image and text
                      Text(
                        title,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
