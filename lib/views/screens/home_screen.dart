import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcqtest/models/question_model.dart';
import 'package:mcqtest/viewModels/auth_vm.dart';
import 'package:mcqtest/viewModels/ques_vm.dart';
import 'package:mcqtest/views/Auth/login.dart';
import 'package:mcqtest/views/screens/Streaks_screen.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  // final fetchQuestions = _questionViewModel.initializeQuestion();
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel questionViewModel =
        Provider.of<QuestionViewModel>(context);
    int questionsIndex = questionViewModel.questions.length;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //mcq test
          SingleChildScrollView(
            child: SafeArea(
              child: questionViewModel.questions.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        //

                        // //mcq test timer
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 36, horizontal: 20),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 5,
                        //         blurRadius: 7,
                        //         offset: const Offset(0, 3),
                        //       ),
                        //     ],
                        //   ),
                        //   child: const Column(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'Time Left',
                        //         style: TextStyle(
                        //           fontSize: 24,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       SizedBox(height: 20),
                        //       Text(
                        //         '00:00:00',
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        //
                        const SizedBox(height: 10),
                        //mcq test questions number icons in sliding tray format
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...List.generate(
                                questionsIndex,
                                (index) {
                                  // shuffle options

                                  return InkWell(
                                    onTap: () {
                                      log('index: $index');

                                      questionViewModel
                                          .setCurrentQuestionIndex(index);
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      margin: const EdgeInsets.all(4),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: questionViewModel
                                                    .currentQuestionIndex ==
                                                index
                                            ? Colors.purple
                                            : Colors.purple.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        //mcq test questions
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Question ${questionViewModel.currentQuestionIndex + 1}",
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Divider(
                                color: Colors.purple,
                                thickness: 2,
                              ),
                              Text(
                                questionViewModel
                                    .questions[
                                        questionViewModel.currentQuestionIndex]
                                    .question,
                                // 'What is the capital of India?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: questionViewModel
                                    .questions[
                                        questionViewModel.currentQuestionIndex]
                                    .options
                                    .length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (questionViewModel
                                                .questions[questionViewModel
                                                    .currentQuestionIndex]
                                                .selectedAnswer !=
                                            null) {
                                          return;
                                        }
                                        //
                                        // _questionViewModel.;

                                        setState(() {
                                          questionViewModel
                                                  .questions[questionViewModel
                                                      .currentQuestionIndex]
                                                  .selectedAnswer =
                                              questionViewModel
                                                  .questions[questionViewModel
                                                      .currentQuestionIndex]
                                                  .options[index];

                                          if (questionViewModel
                                                  .questions[questionViewModel
                                                      .currentQuestionIndex]
                                                  .selectedAnswer ==
                                              questionViewModel
                                                  .questions[questionViewModel
                                                      .currentQuestionIndex]
                                                  .answer) {}
                                        });
                                        await questionViewModel.updateStreak(
                                            questionViewModel.questions[
                                                questionViewModel
                                                    .currentQuestionIndex]);
                                      },
                                      child: CustomQuestionButton(
                                        question: questionViewModel.questions[
                                            questionViewModel
                                                .currentQuestionIndex],
                                        optionIndex: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (questionViewModel.currentQuestionIndex ==
                                questionViewModel.questions.length - 1) {
                              //
                              //fetching new questions after 10 questions
                              questionViewModel.fetchQuestions();
                              return;
                            }
                            questionViewModel.setCurrentQuestionIndex(
                                questionViewModel.currentQuestionIndex + 1);
                          },
                          child: questionViewModel.currentQuestionIndex ==
                                  questionsIndex - 1
                              ? Text(
                                  'Submit',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  'Next',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ],
                    ),
            ),
          ),

          //streaks screen
          const StreaksScreen(),
        ],
      ),
      floatingActionButton: //logout button
          IconButton(
        iconSize: 20,
        padding: const EdgeInsets.all(10),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple[300]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        onPressed: () {
          //dialog box alert to confirm logout and exit the app using systemNavigator.pop()
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<AuthViewModel>(context, listen: false)
                          .signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.logout),
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: 'Home',
        labels: const ['Home', 'Streaks'],
        icons: const [Icons.home, Icons.stacked_line_chart],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.purple,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.purple,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int index) {
          setState(() {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          });
        },
      ),
    );
  }
}

class CustomQuestionButton extends StatefulWidget {
  const CustomQuestionButton({
    super.key,
    required this.question,
    required this.optionIndex,
    this.selectedIcon,
  });

  final int optionIndex;
  final IconData? selectedIcon;
  final QuestionModel question;

  @override
  State<CustomQuestionButton> createState() => _CustomQuestionButtonState();
}

class _CustomQuestionButtonState extends State<CustomQuestionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration: BoxDecoration(
        color: widget.question.selectedAnswer ==
                widget.question.options[widget.optionIndex]
            ? widget.question.selectedAnswer == widget.question.answer
                ? Colors.green
                : Colors.red
            : Colors.purple,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          widget.question.options[widget.optionIndex],
          style: GoogleFonts.firaSansCondensed(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
