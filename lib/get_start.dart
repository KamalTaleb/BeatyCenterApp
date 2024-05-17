import 'package:beauty_center/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool islastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => islastPage = index == 2);
          },
          children: [
            Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'images/onboarding1.PNG',
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                      height:MediaQuery.of(context).size.height /2,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Exclusive Rewards Program",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Join our loyalty program for luxurious rewards. Earn points for purchases and unlock discounts, complimentary treatments, and VIP access to exclusive events.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'images/onboarding2.PNG',
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                      height:MediaQuery.of(context).size.height /2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Seamless Booking Experience",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Say goodbye to waiting lines. Easily schedule appointments, browse available slots, and receive instant confirmations—all from your fingertips",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'images/onboarding3.PNG',
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                      height:MediaQuery.of(context).size.height /2,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Personalized Beauty Recommendations",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Discover your pperfect beauty regimen with tailored suggestions based on your skin type, preferences, and goals. Elevate your beauty routine with expert advice.",
                          textAlign: TextAlign.center,
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
      bottomSheet: islastPage
          ? TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size.fromHeight(80),
              ),
              child: const Text(
                "SIGN UP",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('shoHome', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('SKIP'),
                    onPressed: () => controller.jumpToPage(2),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                    child: const Text('NEXT'),
                    onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
