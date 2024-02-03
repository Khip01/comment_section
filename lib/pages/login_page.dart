import 'package:comment_section/controller/user_account_controller.dart';
import 'package:comment_section/object/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller
  final UserController _userController = UserController();

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Error text
  String? _errorEmailText;

  // Email Controller
  final TextEditingController _emailController = TextEditingController();

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
                      child: SizedBox(
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
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Sign ",
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                children: const [
                                  TextSpan(
                                    text: "In",
                                    style: TextStyle(color: Color.fromARGB(255, 129, 168, 255)),
                                  ),
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty){
                                    return "This field is required";
                                  } else {
                                    if (!EmailValidator.validate(value)){
                                      return "Please enter a valid email";
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                style: GoogleFonts.rubik(),
                                decoration: InputDecoration(
                                  errorText: _errorEmailText,
                                  hintText: "Your Email",
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 129, 168, 255),
                                        width: 2),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 129, 168, 255),
                                        width: 1),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 120,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String? username = await _userController.getUsernameFrom(_emailController.text);

                                      setState(() {
                                        if (username == null || username.isEmpty) {
                                          _errorEmailText = "Account has not been registered";
                                          return;
                                        } else {
                                          _errorEmailText = null;
                                        }
                                      });

                                      context.goNamed("comment_page", extra: User(username!));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    surfaceTintColor: const Color.fromARGB(
                                        255, 129, 168, 255),
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color.fromARGB(
                                        255, 129, 168, 255),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.rubik(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
