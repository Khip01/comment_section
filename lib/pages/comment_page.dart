import 'package:comment_section/controller/comments_controller.dart';
import 'package:comment_section/controller/user_account_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../object/user.dart';

class CommentPage extends StatefulWidget {
  final User user;

  const CommentPage({super.key, required this.user});

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
  final UserController _userController = UserController();
  final CommentController _commentController = CommentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _userController.database.ref().child("comments").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _bodyPageError();
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _bodyPageShimmer();
              case ConnectionState.waiting:
                return _bodyPageShimmer();
              case ConnectionState.active:
                Map<String, dynamic> comments = snapshot.data!.snapshot.value as Map<String, dynamic>;
                return _bodyPage(comments, comments.keys.toList());
              case ConnectionState.done:
                Map<String, dynamic> comments = snapshot.data!.snapshot.value as Map<String, dynamic>;
                return _bodyPage(comments, comments.keys.toList());
            }
          }
        },
      ),
    );
  }

  Widget _bodyPage(Map<String, dynamic> comments, List<String> keysComment) {
    return Stack(
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
          child: SizedBox(
            // margin: const EdgeInsets.symmetric(horizontal: 40),
            // width: 1315,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 115),
              children: [
                _titleSection(),
                _headingSection(comments),
                _menuSection(),
                _myCommentSection(),
                _commentSection(keysComment),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyPageError() {
    return SizedBox();
  }

  Widget _bodyPageShimmer() {
    return SizedBox();
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

  Widget _headingSection(Map<String, dynamic> comments) {
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
            "Comments (${comments.length})",
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

  Widget _menuSection() {
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

  Widget _myCommentSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 180,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SvgPicture.network(
                "https://api.dicebear.com/7.x/thumbs/svg?seed=${widget.user.username}",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Stack(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                      decoration: InputDecoration(
                          hintText: "Add a comment as ${widget.user.username} ...",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 129, 168, 255),
                                width: 1.2),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.1),
                          ),
                          suffixIcon: const SizedBox.shrink()),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 3,
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        height: 50,
                        width: 40,
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: () {
                            // TODO: Send Message
                          },
                          child: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 129, 168, 255),
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
    );
  }

  Widget _commentSection(List<String> keysComment) {
    return FirebaseAnimatedList(
      query: _commentController.getCommentsQueryFromDB(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map<String, dynamic> firebaseComments = snapshot.value as Map<String, dynamic>;

          return SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SvgPicture.network(
                    "https://api.dicebear.com/7.x/thumbs/svg?seed=${firebaseComments["username"]}",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text.rich(
                            TextSpan(
                                text: firebaseComments["username"],
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: "  •  ${firebaseComments["date_time"]}",
                                    style: GoogleFonts.rubik(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            firebaseComments["message"],
                            style: GoogleFonts.rubik(
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Text(
                                "${firebaseComments["like"]?.length ?? 0} Like   •   ",
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (firebaseComments["like"]?[widget.user.username] ?? false) {
                                    _commentController.likeTheComment(keysComment[index], false, widget.user.username);
                                  } else {
                                    _commentController.likeTheComment(keysComment[index], true, widget.user.username);
                                  }
                                },
                                child: Icon(
                                  Icons.thumb_up,
                                  color: (firebaseComments["like"]?[widget.user.username] ?? false) ? const Color.fromARGB(255, 129, 168, 255) : Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
