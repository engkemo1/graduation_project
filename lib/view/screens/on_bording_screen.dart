import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/starting_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../view_model/database/local.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

const Color whiteColor = Color(0xffD9D9D9);

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const StartingScreen()),
    );
    CacheHelper.put(key: "isFirstTime", value: false);

  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.zero,
      fullScreen: true,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: false,
          infiniteAutoScroll: false,
          pages: [
            PageViewModel(
              title: "",
              body: "",
              image: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(children: [
                  Image.asset(
                    "assets/images/onBording1.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      width: double.infinity,
                      height: 225,
                      child: const Padding(
                        padding: EdgeInsets.all(41.0),
                        child: Text(
                          "Create memories that will last a lifetime!",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              image: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(children: [
                  Image.asset(
                    "assets/images/onBording2.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      width: double.infinity,
                      height: 225,
                      child: const Padding(
                        padding: EdgeInsets.all(41.0),
                        child: Text(
                          "Experience the magic of cinema, anytime, anywhere",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              image: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(children: [
                  Image.asset(
                    "assets/images/onBording3.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      width: double.infinity,
                      height: 225,
                      child: const Padding(
                        padding: EdgeInsets.all(41.0),
                        child: Text(
                          "Don't be left out - get your tickets today",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              decoration: pageDecoration,
            ),

            PageViewModel(
              title: "",
              body: "",
              image: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(children: [
                  Image.asset(
                    "assets/images/onBording4.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      width: double.infinity,
                      height: 225,
                      child: const Padding(
                        padding: EdgeInsets.all(41.0),
                        child: Text(
                          "Your adventure awaits",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              decoration: pageDecoration,
            ),

          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          showBottomPart: true,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:  const Text('Skip',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff656565) ,
                  fontSize: 16)),
          next: const Text(
            "Next",
            style: TextStyle(
                color: redLevelColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),

          done:
              const Text('Get Started', style: TextStyle(fontWeight: FontWeight.w800,color: redLevelColor,fontSize: 16)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.only(top: 40,bottom: 16,left: 16,right: 16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            spacing: EdgeInsets.only(bottom: 40,left: 5),
            color: Color(0xffBDBCBC),
            activeColor: redLevelColor,
            activeSize: Size(58.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          )),
    );
  }
}

