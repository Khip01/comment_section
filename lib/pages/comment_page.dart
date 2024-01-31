import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

const List<String> sortList = <String>[
  "Recently",
  "Oldest",
  "Most Liked",
];

String sortValue = sortList.first;

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 400,
            decoration: const BoxDecoration(
              // color: Colors.red
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 206, 221, 255),
                  Color.fromARGB(0, 206, 221, 255),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: 1315,
              child: ListView(
                children: [
                  _titleSection(),
                  _headingSection(),
                  _yourComment(),
                  _commentSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSection() {
    return SizedBox(
      height: 90,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "COMMENT SECTION",
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 129, 168, 255),
              ),
            ),
          )),
    );
  }

  Widget _headingSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      height: 100,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments (6)",
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 47, 61, 94),
              ),
            ),
          ),
          Text(
            "Start a discussion, not a fire. Post with kindness.",
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 60, 81, 128),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _yourComment() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 80,
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Sort by",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 100, 119, 166),
                    ),
                  ),
                ),
              ),
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    items: sortList
                        .map<DropdownMenuItem<String>>((String value) =>
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 100, 119, 166),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    value: sortValue,
                    onChanged: (value) {
                      setState(() {
                        sortValue = value!;
                      });
                    },
                    dropdownStyleData: const DropdownStyleData(
                      elevation: 1,
                    ),
                    buttonStyleData: const ButtonStyleData(
                      height: 30,
                      width: 120,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Done with the commenting?",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 100, 119, 166),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.goNamed("landing_page");
                  },
                  child: SizedBox(
                    width: 85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 100, 119, 166),
                        ),
                        Text(
                          "Logout",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 100, 119, 166),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _commentSection() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {},
    );
  }
}
