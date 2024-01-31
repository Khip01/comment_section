import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    padding: const EdgeInsets.only(left: 110),
                    // width: 500,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Welcome to my ",
                            style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  fontSize: 47, fontWeight: FontWeight.w700),
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
                        ),
                        Text(
                          "This is a platform to comment freely about me, or discuss any topic for free. And of course your identity will remain secret on other users.",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 60, 81, 128),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 30),
                              width: 170,
                              height: 60,
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
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
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
                                  style: GoogleFonts.rubik(),
                                ),
                              ),
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
                      padding: const EdgeInsets.only(right: 70),
                      // color: Colors.red,
                      // width: 400,
                      // height: 400,
                      child: SvgPicture.asset("assets/chat.svg"),
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
