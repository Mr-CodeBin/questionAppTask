import 'dart:developer';

import 'package:clean_calendar/clean_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mcqtest/services/Firestore/firestore_collections.dart';
import 'package:mcqtest/viewModels/ques_vm.dart';
import 'package:provider/provider.dart';

class StreaksScreen extends StatefulWidget {
  const StreaksScreen({super.key});

  @override
  State<StreaksScreen> createState() => _StreaksScreenState();
}

class _StreaksScreenState extends State<StreaksScreen> {
  List<DateTime> streakDates = [];

  @override
  void initState() {
    super.initState();

    //
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<String> dates = await FireStoreCollections.getStreakDates(
          FirebaseAuth.instance.currentUser!.uid);

      List<DateTime> streakDates = dates.map((e) => DateTime.parse(e)).toList();
      log(streakDates.toString());
      setState(() {
        this.streakDates = streakDates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionViewModel =
        Provider.of<QuestionViewModel>(context);

    List<DateTime> formattedDates =
        streakDates.map((date) => DateTime.parse(date.toString())).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Streaks',
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //glassmorphism container to show the streak count
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      minHeight: MediaQuery.of(context).size.height * 0.15,
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Streak',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_questionViewModel.streakCount}',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //glassmorphism container to show the all time highest streak
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      minHeight: MediaQuery.of(context).size.height * 0.15,
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Highest Streak',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_questionViewModel.allTimeHighestStreak}',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //a stylish divider
              Divider(
                color: Colors.purple,
                thickness: 2,
              ),

              //streakcalendar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CleanCalendar(
                  datesForStreaks: [
                    ...formattedDates,
                  ],
                  headerProperties: HeaderProperties(
                    monthYearDecoration: MonthYearDecoration(
                      monthYearTextStyle: GoogleFonts.firaSansCondensed(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    navigatorDecoration: NavigatorDecoration(
                      navigateLeftButtonIcon: Icon(
                        Iconsax.arrow_left,
                        color: Colors.purple.shade400,
                      ),
                      navigateRightButtonIcon: Icon(
                        Iconsax.arrow_right,
                        color: Colors.purple.shade400,
                      ),
                    ),
                  ),

                  enableDenseSplashForDates: true,
                  monthsSymbol: const Months(
                    january: 'jan',
                    february: 'feb',
                    march: 'mar',
                    april: 'apr',
                    may: 'may',
                    june: 'jun',
                    july: 'jul',
                    august: 'aug',
                    september: 'sep',
                    october: 'oct',
                    november: 'nov',
                    december: 'dec',
                  ),

                  currentDateProperties: DatesProperties(
                    datesDecoration: DatesDecoration(
                      datesBackgroundColor: Colors.purple.shade400,
                      datesTextColor: Colors.white,
                      datesTextStyle: GoogleFonts.firaSansCondensed(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      datesBorderColor: Colors.amber,
                      datesBorderRadius: 4,
                    ),
                  ),

                  generalDatesProperties: DatesProperties(
                    datesDecoration: DatesDecoration(
                      datesBorderRadius: 4,
                      datesBorderColor: Colors.purple.shade400,
                      datesBackgroundColor: Colors.white,
                      datesTextColor: Colors.purple.shade400,
                      datesTextStyle: GoogleFonts.firaSansCondensed(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //styling the calendar
                  streakDatesProperties: DatesProperties(
                    datesDecoration: DatesDecoration(
                      datesBorderRadius: 4,
                      datesBorderColor: Colors.amber.shade400,
                      datesBackgroundColor: Colors.purple.shade400,
                      datesTextColor: Colors.white,
                      datesTextStyle: GoogleFonts.firaSansCondensed(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              //a list of streak dates
              Expanded(
                child: ListView.builder(
                  itemCount: streakDates.length,
                  itemBuilder: (context, index) {
                    streakDates.sort((a, b) => b.compareTo(a));
                    return ListTile(
                      title: Text(
                        ' ${streakDates[index].toString().substring(0, 10)}',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
