import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/Logo/Logo.png',
          width: 100,
        ),
        Text(
          'Chatty',
          style: GoogleFonts.pacifico(fontSize: 23),
        )
      ],
    );
  }
}
