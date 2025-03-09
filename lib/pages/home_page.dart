import 'package:flutter/material.dart';
import 'package:homework_3march/level/level1.dart';
import 'package:homework_3march/level/level2.dart';
import 'package:homework_3march/level/level3.dart';
import 'package:homework_3march/source/app_texts.dart';
import 'package:homework_3march/source/colors.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSoundWrong() async {
    try {
      await _audioPlayer.setFilePath("assets/sound/button-305770.mp3");
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  AppTexts.quizzly,
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  AppTexts.welcomeToQuizly,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      AppTexts.introduction,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  AppTexts.choosing,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _playSoundWrong();
                    setState(() {});
                    // go level 1
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LevelOne()));
                  },
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                    child: const Center(
                      child: Text(
                        AppTexts.level1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _playSoundWrong();
                    // go level 2
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LevelTwo()));
                  },
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        AppTexts.level2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _playSoundWrong();
                    // go level 3
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LevelThree()));
                  },
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        AppTexts.level3,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
