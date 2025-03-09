import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:homework_3march/source/app_texts.dart';
import 'package:homework_3march/source/colors.dart';
import 'package:just_audio/just_audio.dart';
import '../pages/score_page.dart';

class LevelOne extends StatefulWidget {
  const LevelOne({super.key});

  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int timeLeft = 20;
  double progress = 1;
  int firstNumber = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  String operator = '+';
  int secondNumber = 0;
  int result = 0;
  List<int> options = [];
  int questionCount = 0;
  int totalQuestion = 10;

  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        nextQuesiton();
      }
    });
  }

  void check(int timeLeft) {
    if (timeLeft == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScorePage(
                  correctAnswer: correctAnswers, wrongAnswers: wrongAnswers)));
    } else {
      setState(() {
        startTimer();
      });
    }
  }

  void nextQuesiton() {
    if (questionCount < totalQuestion - 1) {
      setState(() {
        questionCount++;
        generateQuestion();
        timeLeft = 20;
        startTimer();
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScorePage(
                    correctAnswer: correctAnswers,
                    wrongAnswers: wrongAnswers,
                  )));
    }
  }

  Future<void> _playSoundWrong() async {
    try {
      await _audioPlayer.setFilePath("assets/sound/button.wav");
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer;
    super.dispose();
  }

  void generateQuestion() {
    Random random = Random();
    firstNumber = random.nextInt(10);
    secondNumber = random.nextInt(10);

    List<String> math = ["+", "-"];
    math.shuffle();

    operator = math[0];
    if (operator == "+") {
      result = firstNumber + secondNumber;
    } else {
      if (firstNumber < secondNumber) {
        int temp = firstNumber;
        firstNumber = secondNumber;
        secondNumber = temp;
      }
      result = firstNumber - secondNumber;
    }

    Set<int> wrongAnswer = {};
    while (wrongAnswer.length < 3) {
      int wrong = random.nextInt(10 + 1);
      if (wrong != result) {
        wrongAnswer.add(wrong);
      }
    }

    options = [result, ...wrongAnswer.toList()];
    options.shuffle();
    setState(() {});
  }

  void checkAnswer(int selected) {
    _timer.cancel();
    if (selected == result) {
      correctAnswers++;
    } else {
      wrongAnswers++;
    }

    nextQuesiton();
  }

  @override
  void initState() {
    super.initState();
    generateQuestion();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: black,
                      blurRadius: 10,
                      offset: const Offset(1, 2),
                    ),
                  ],
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: white),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: mainColor,
                          value: timeLeft / 20,
                        ),
                      ),
                    ),
                    Text(
                      "$timeLeft",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${AppTexts.currentQuestion} $questionCount/$totalQuestion",
                      style: TextStyle(color: mainColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "$firstNumber $operator $secondNumber = ?",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 10,
              children: options.map(
                (option) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        _playSoundWrong();
                        checkAnswer(option);
                      },
                      child: Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            color: white,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "$option",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
