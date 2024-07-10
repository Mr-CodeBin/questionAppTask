import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MultiCircularSlider(
                size: MediaQuery.of(context).size.width * 0.8,
                progressBarType: MultiCircularSliderType.circular,
                values: const [0.2, 0.1, 0.3, 0.28],
                colors: const [
                  Color(0xFFFD1960),
                  Color(0xFF29D3E8),
                  Color(0xFF18C737),
                  Color(0xFFFFCC05)
                ],
                showTotalPercentage: true,
                label: 'DAMN',

                animationDuration: const Duration(milliseconds: 1000),
                animationCurve: Curves.easeInOutCirc,
                innerIcon: const Icon(Icons.integration_instructions),
                trackColor: Colors.white,
                // progressBarWidth: 36.0,
                // trackWidth: 36.0,
                labelTextStyle:
                    GoogleFonts.firaSansCondensed(fontWeight: FontWeight.w500),
                percentageTextStyle: const TextStyle(),
              ),
            ),
            //mcq test timer
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Result",
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
