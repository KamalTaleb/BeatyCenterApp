import 'package:beauty_center/get_start.dart';
import 'package:beauty_center/sign_in.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.99,
                  decoration: BoxDecoration(
                    color: Color(0xFF4d6972),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/logo1.PNG',
                      scale: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.99,
                decoration: BoxDecoration(
                  color: Color(0xFF4d6972),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.99,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "BySabeen",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "TEXT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
<<<<<<< HEAD
                      color: Colors.teal.shade700,
=======
                      color: Color(0xFF4d6972),
>>>>>>> 06e82f64041ae2dbfd91fea1c2aa20724d828ac0
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          child: Text(
                            "Let's get started",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
<<<<<<< HEAD
                                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.teal.shade700),
                          ),
                        )
=======
                                fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF4d6972),),
                          ),
                        ),
>>>>>>> 06e82f64041ae2dbfd91fea1c2aa20724d828ac0
                      ],
                    ),
                    SizedBox(height:5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Only here for the services?"),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Guest Mode",
                            style: TextStyle(
<<<<<<< HEAD
                                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.teal.shade700),
=======
                                fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF4d6972),),
>>>>>>> 06e82f64041ae2dbfd91fea1c2aa20724d828ac0
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
