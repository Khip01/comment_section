import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey(); // FormKey Validation

  final OverlayPortalController _emailToolTip =
      OverlayPortalController(); // For Email OverlayController
  final _linkEmail = LayerLink(); // For CompositedTransform Email Link

  final OverlayPortalController _usernameToolTip =
      OverlayPortalController(); // For Username OverlayController
  final _linkUsername = LayerLink(); // For CompositedTransform Username Link

  final OverlayPortalController _agreementTooltip =
      OverlayPortalController(); // For agreement OverlayController
  final _linkAgreement = LayerLink(); // For CompositedTransform agreement Link
  bool agreementIsCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: 500,
            width: 400,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: _arrowBack(),
                    ),
                    Flexible(
                      flex: 10,
                      child: _formSection(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _arrowBack() {
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 129, 168, 255),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formSection() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text.rich(
            TextSpan(
              text: "Sign ",
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              children: const [
                TextSpan(
                  text: "Up",
                  style: TextStyle(
                    color: Color.fromARGB(255, 129, 168, 255),
                  ),
                ),
              ],
            ),
          ),
          // TextFormField Email Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              style: GoogleFonts.rubik(),
              decoration: InputDecoration(
                hintText: "Email",
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 129, 168, 255),
                    width: 2,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 129, 168, 255), width: 1),
                ),
                suffixIcon: CompositedTransformTarget(
                  link: _linkEmail,
                  child: OverlayPortal(
                    controller: _emailToolTip,
                    overlayChildBuilder: (BuildContext context) {
                      return CompositedTransformFollower(
                        link: _linkEmail,
                        targetAnchor: Alignment.topRight,
                        followerAnchor: Alignment.bottomRight,
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: _customTooltip(
                              "Don't worry, you can use a fake email :D.",
                              300,
                              70,
                              8,
                              "email"),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () => _emailToolTip.toggle(),
                      child: const Icon(
                        Icons.help_outline,
                        color: Color.fromARGB(255, 129, 168, 255),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // TextFormField Username
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              style: GoogleFonts.rubik(),
              decoration: InputDecoration(
                hintText: "Username Custom",
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 129, 168, 255), width: 2),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 129, 168, 255), width: 1),
                ),
                suffixIcon: CompositedTransformTarget(
                  link: _linkUsername,
                  child: OverlayPortal(
                    controller: _usernameToolTip,
                    overlayChildBuilder: (BuildContext context) {
                      return CompositedTransformFollower(
                        link: _linkUsername,
                        targetAnchor: Alignment.topRight,
                        followerAnchor: Alignment.bottomRight,
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: _customTooltip(
                              "This username will appear as your identity in comments",
                              350,
                              100,
                              8,
                              "username"),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () => _usernameToolTip.toggle(),
                      child: const Icon(Icons.help_outline,
                          color: Color.fromARGB(255, 129, 168, 255), size: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Checkbox Agreement Section
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Checkbox(
                  value: agreementIsCheck,
                  onChanged: (value) {
                    setState(() {
                      agreementIsCheck = value!;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  activeColor: const Color.fromARGB(255, 129, 168, 255),
                  hoverColor: const Color.fromARGB(26, 129, 168, 255),
                  checkColor: Colors.white,
                  splashRadius: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        agreementIsCheck = !agreementIsCheck;
                      });
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: CompositedTransformTarget(
                      link: _linkAgreement,
                      child: OverlayPortal(
                        controller: _agreementTooltip,
                        overlayChildBuilder: (BuildContext context) {
                          return CompositedTransformFollower(
                            link: _linkAgreement,
                            targetAnchor: Alignment.topCenter,
                            followerAnchor: Alignment.bottomCenter,
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: _customTooltip(
                                  "The data we save is the email data and custom username that you provided above.",
                                  420,
                                  100,
                                  165,
                                  "agreement"),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                              text: "You agree that we will ",
                              style: GoogleFonts.rubik(),
                              children: [
                                TextSpan(
                                  text: "collect",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 129, 168, 255),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _agreementTooltip.toggle(),
                                ),
                                const TextSpan(
                                  text: " your data.",
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Button Section
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: agreementIsCheck ? () {
                  context.goNamed("comment_page");
                } : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  surfaceTintColor: const Color.fromARGB(255, 129, 168, 255),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 129, 168, 255),
                ),
                child: Text(
                  "Create",
                  style: GoogleFonts.rubik(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTooltip(String custMessage, double custWidth, double custHeight,
      double trianglePadding, String type) {
    // Position ex: "onAbove" or "onBelow"

    return SizedBox(
      height: custHeight,
      width: custWidth,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                if (type == "agreement") {
                  _agreementTooltip.toggle();
                } else if (type == "email") {
                  _emailToolTip.toggle();
                } else if (type == "username") {
                  _usernameToolTip.toggle();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromARGB(255, 129, 168, 255),
                ),
                width: custWidth,
                height: custHeight - 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      custMessage,
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      "*click this buble to close",
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: trianglePadding),
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  color: const Color.fromARGB(255, 129, 168, 255),
                  height: 10,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Triangle Shape
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
