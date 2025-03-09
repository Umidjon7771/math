import 'package:flutter/material.dart';
import 'package:homework_3march/level/level3.dart';
import 'package:homework_3march/pages/home_page.dart';
import 'package:homework_3march/source/colors.dart';
import 'package:just_audio/just_audio.dart';
import '../source/app_texts.dart';
import 'package:lottie/lottie.dart';

class ScorePage extends StatefulWidget {
  final int correctAnswer;
  final int wrongAnswers;

  const ScorePage(
      {super.key, required this.correctAnswer, required this.wrongAnswers});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _playBackgroundMusic();
    _audioPlayer.stop();
    super.dispose();
  }

  @override
  void initState() {
    widget.correctAnswer;
    widget.wrongAnswers;
    _playBackgroundMusic();
    super.initState();
  }

  Future<void> _playBackgroundMusic() async {
    try {
      await _audioPlayer.setFilePath("assets/sound/bcgsound.wav");
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  Widget congratulations() {
    double result = widget.correctAnswer * 10;
    if (0 <= result && result <= 55) {
      return Lottie.asset("assets/animations/sad_anim.json");
    } else if (55 <= result && result <= 75) {
      return Lottie.asset("assets/animations/good.json");
    } else {
      return Lottie.asset("assets/animations/success.json");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned.fill(
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: congratulations(),
                      ),
                    ),
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: white.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: white.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your score",
                                style:
                                    TextStyle(color: mainColor, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${widget.correctAnswer * 10}",
                                style:
                                    TextStyle(color: mainColor, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: black,
                    offset: const Offset(1, 2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                        ),
                        Text(
                          " ${widget.correctAnswer} Correct",
                          style: const TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        ),
                        Text(
                          " ${widget.wrongAnswers} Mistake",
                          style: const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                _audioPlayer.stop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LevelThree()));
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    color: mainColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    AppTexts.playAgain,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: black, fontSize: 22),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _audioPlayer.stop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    color: mainColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    AppTexts.home,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: black, fontSize: 22),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Center(
                  child: Text(
                    AppTexts.quizzly,
                    style: TextStyle(color: white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
