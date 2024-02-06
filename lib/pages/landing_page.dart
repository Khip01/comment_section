import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final Utils utils = Utils();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth >= 1100){ // Extended
            return _mainPage(context, utils.screenTypes[2]);
          } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1100) { // Medium
            return _mainPage(context, utils.screenTypes[1]);
          } else { // Compact
            return _mainPage(context, utils.screenTypes[0]);
          }
        },
      ),
    );
  }

  Widget _mainPage(BuildContext context, String screenType){
    return Stack(
      children: [
        Positioned(
          bottom: -20,
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/wave.png", fit: BoxFit.fitWidth),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(left: utils.responsive(70, 110, 110, screenType), right: utils.responsive(70, 110, 0, screenType)),
                  // width: 500,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Welcome to my ",
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                                fontSize: utils.responsive(36, 40, 47, screenType), fontWeight: FontWeight.w700,
                            ),
                          ),
                          children: const [
                            TextSpan(
                              text: "Comment Section",
                              style: TextStyle(
                                color: Color.fromARGB(255, 129, 168, 255),),
                            ),
                            TextSpan(text: "!"),
                          ],
                        ),
                        textAlign: utils.responsive(TextAlign.left, TextAlign.center, TextAlign.left, screenType),
                      ),
                      Text(
                        "This is a platform to comment freely about me, or discuss any topic for free. And of course your identity will remain secret on other users.",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            fontSize: utils.responsive(14, 16, 16, screenType),
                            color: const Color.fromARGB(255, 60, 81, 128),
                          ),
                        ),
                        textAlign: utils.responsive(TextAlign.left, TextAlign.center, TextAlign.left, screenType),
                      ),
                      Row(
                        mainAxisAlignment: utils.responsive(MainAxisAlignment.start, MainAxisAlignment.center, MainAxisAlignment.start, screenType),
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 30),
                            width: utils.responsive(150, 165, 170, screenType),
                            height: utils.responsive(50, 50, 60, screenType),
                            child: ElevatedButton(
                              onPressed: () {
                                context.goNamed("login_page");
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                surfaceTintColor:
                                const Color.fromARGB(255, 129, 168, 255),
                                foregroundColor: Colors.white,
                                backgroundColor:
                                const Color.fromARGB(255, 129, 168, 255),
                              ),
                              child: Text(
                                "SIGN IN",
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                      fontSize: utils.responsive(12, 12, 14, screenType),
                                      fontWeight: FontWeight.bold,
                                    ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: utils.responsive(150, 165, 170, screenType),
                            height: utils.responsive(50, 50, 60, screenType),
                            child: ElevatedButton(
                              onPressed: () {
                                context.goNamed("register_page");
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color:
                                      Color.fromARGB(255, 129, 168, 255),
                                      width: 1),
                                ),
                                surfaceTintColor: Colors.white,
                                foregroundColor:
                                const Color.fromARGB(255, 129, 168, 255),
                                backgroundColor: Colors.white,
                              ),
                              child: Text(
                                "Register for FREE",
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    fontSize: utils.responsive(12, 12, 14, screenType),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              utils.responsive(const SizedBox(), const SizedBox(), Flexible(
                  flex: 5,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(right: 70),
                      // color: Colors.red,
                      // width: 400,
                      // height: 400,
                      child: SvgPicture.asset("assets/chat.svg"),
                    ),
                  ),
                ), screenType),
            ],
          ),
        ),
      ],
    );
  }
}