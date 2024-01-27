import 'package:flutter_svg/svg.dart';
import 'package:comment_section/source/source_link.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final SourceLink src = SourceLink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -20,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("wave.png", fit: BoxFit.fitWidth),
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
                    padding: EdgeInsets.only(left: 110),
                    // width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to my Comment Section!",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                                fontSize: 47, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          "This is a platform to comment freely about me, or discuss any topic for free. And of course your identity will remain a secret.",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.goNamed("login_page");
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  surfaceTintColor: Color.fromARGB(255, 129, 168, 255),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color.fromARGB(255, 129, 168, 255),
                                ),
                                child: Text("Sign in"),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.goNamed("register_page");
                              },
                              child: Text("Register for FREE"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(right: 70),
                      // color: Colors.red,
                      // width: 400,
                      // height: 400,
                      child: SvgPicture.asset("chat.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _elevatedBUttonStyle() {
  //   return ElevatedButton.styleFrom(
  //     foregroundColor: Colors.white,
  //     backgroundColor: Colors.blueAccent,
  //   );
  // }
}
