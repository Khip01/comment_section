import 'package:comment_section/controller/comments_controller.dart';
import 'package:comment_section/controller/user_account_controller.dart';
import 'package:comment_section/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../object/user.dart';

class CommentPage extends StatefulWidget {
  final User user;

  const CommentPage({super.key, required this.user});

  @override
  State<CommentPage> createState() => _CommentPageState();
}


final UserController _userController = UserController();
final CommentController _commentController = CommentController();

String sortValue = _commentController.sortList.first;

class _CommentPageState extends State<CommentPage> {
  Utils utils = Utils();

  // Text Controller
  TextEditingController commentFieldController = TextEditingController();

  // Stream
  Stream? _stream;

  // FirebaseAnimatedList
  var _firebaseKey = Key(DateTime.now().millisecondsSinceEpoch.toString());

  @override
  void initState() {
    _stream = _userController.database.ref().child("comments").onValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            if(constraints.maxWidth >= 1100){ // Extended
              return _mainPage(utils.screenTypes[3]);
            } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1100) { // Medium
              return _mainPage(utils.screenTypes[2]);
            } else if (constraints.maxWidth > 480 && constraints.maxWidth < 600) { // Compact
              return _mainPage(utils.screenTypes[1]);
            } else { // Very Compact
              return _mainPage(utils.screenTypes[0]);
            }
          },
      ),
    );
  }

  Widget _mainPage(String screenType) {
    return StreamBuilder(
      stream: _stream!,
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return _bodyPageError();
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _bodyPageShimmer();
            case ConnectionState.waiting:
              return _bodyPageShimmer();
            case ConnectionState.active:
              Map<String, dynamic>? comments = (snapshot.data!.snapshot.value ?? new Map<String, dynamic>()) as Map<String, dynamic>?;
              return _bodyPage(comments, comments?.keys.toList(), screenType);
            case ConnectionState.done:
              Map<String, dynamic>? comments = (snapshot.data!.snapshot.value ?? new Map<String, dynamic>()) as Map<String, dynamic>?;
              return _bodyPage(comments, comments?.keys.toList(), screenType);
          }
        }
      },
    );
  }

  Widget _bodyPage(Map<String, dynamic>? comments, List<String>? keysComment, String screenType) {
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
              padding: EdgeInsets.symmetric(horizontal: utils.responsive(20, 20, 40, 115, screenType)),
              children: [
                _titleSection(screenType),
                _headingSection(comments, screenType),
                _menuSection(screenType),
                _myCommentSection(screenType),
                _commentSection(keysComment, screenType),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyPageError() {
    return const SizedBox();
  }

  Widget _bodyPageShimmer() {
    return const SizedBox();
  }

  Widget _titleSection(String screenType) {
    return SizedBox(
      height: utils.responsive(75, 80, 85, 90, screenType),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "COMMENT SECTION",
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: utils.responsive(28, 32, 34, 36, screenType),
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 129, 168, 255),
              ),
            ),
          )),
    );
  }

  Widget _headingSection(Map<String, dynamic>? comments, String screenType) {
    return Container(
      padding: EdgeInsets.only(bottom: utils.responsive(16, 16, 18, 20, screenType)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: utils.responsive(0.1, 0.1, 0.1, 0.2, screenType)),
        ),
      ),
      height: utils.responsive(85, 90, 95, 100, screenType),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments (${comments?.length ?? 0})",
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: utils.responsive(20, 20, 22, 24, screenType),
                color: const Color.fromARGB(255, 47, 61, 94),
              ),
            ),
          ),
          Text(
            "Start a discussion, not a fire. Post with kindness.",
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: utils.responsive(14, 14, 16, 18, screenType),
                color: const Color.fromARGB(255, 60, 81, 128),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuSection(String screenType) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: utils.responsive(16, 16, 18, 20, screenType)),
      height: utils.responsive(60, 60, 70, 80, screenType),
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: utils.responsive(8, 8, 9, 10, screenType)),
                child: Text(
                  "Sort by",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: utils.responsive(12, 12, 14, 16, screenType),
                      color: const Color.fromARGB(255, 100, 119, 166),
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
                    items: _commentController.sortList
                        .map<DropdownMenuItem<String>>((String value) =>
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: utils.responsive(12, 12, 14, 16, screenType),
                                    color: const Color.fromARGB(255, 100, 119, 166),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    value: sortValue,
                    onChanged: (value) {
                      setState(() {
                        sortValue = value!;
                        _firebaseKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
                      });
                    },
                    dropdownStyleData: const DropdownStyleData(
                      elevation: 1,
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 30,
                      width: utils.responsive(100, 100, 110, 120, screenType),
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
            width: utils.responsive(null, null, 300, 320, screenType),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                utils.responsive(const SizedBox(), const SizedBox(),
                  Text("Done with the commenting?",
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 100, 119, 166),
                      ),
                    ),
                  ),
                  Text("Done with the commenting?",
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 100, 119, 166),
                      ),
                    ),
                  ), screenType),
                InkWell(
                  onTap: () {
                    context.goNamed("landing_page");
                  },
                  child: SizedBox(
                    width: utils.responsive(70, 70, 80, 90, screenType),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.logout,
                          color: const Color.fromARGB(255, 100, 119, 166),
                          size: utils.responsive(20, 20, 22, 24, screenType),
                        ),
                        Text(
                          "Logout",
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              fontSize: utils.responsive(12, 12, 14, 16, screenType),
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 100, 119, 166),
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

  Widget _myCommentSection(String screenType) {
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
              child: Image.network(
                "https://api.dicebear.com/7.x/thumbs/jpg?seed=${widget.user.username}",
                height: utils.responsive(55, 55, 50, 60, screenType),
                width: utils.responsive(55, 55, 50, 60, screenType),
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
                      controller: commentFieldController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: utils.responsive(12, 12, 14, 16, screenType)),
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
                          suffixIcon: const SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: utils.responsive(2, 2, 3, 3, screenType),
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        height: 50,
                        width: 40,
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: () {
                            if (commentFieldController.text.isNotEmpty) {
                              _commentController.writeComment(widget.user.username, commentFieldController.text).then((_) => commentFieldController.clear());
                            }
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

  Widget _commentSection(List<String>? keysComment, screenType) {
    return FirebaseAnimatedList(
      physics: const NeverScrollableScrollPhysics(),
      key: _firebaseKey,
      query: _commentController.getCommentsQueryFromDB(sortValue),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map<String, dynamic> firebaseComments = snapshot.value as Map<String, dynamic>;

          return SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://api.dicebear.com/7.x/thumbs/jpg?seed=${firebaseComments["username"]}",
                    height: utils.responsive(45, 45, 50, 60, screenType),
                    width: utils.responsive(45, 45, 50, 60, screenType),
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.1),
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
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: utils.responsive(12, 12, 14, 16, screenType),
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: "  •  ${timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(firebaseComments["date_time"])))}",
                                    style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: utils.responsive(10, 10, 12, 14, screenType),
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
                              textStyle: TextStyle(fontSize: utils.responsive(12, 12, 14, 16, screenType)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Text(
                                "${(firebaseComments["likeCount"] != 0) ? (firebaseComments["likeCount"] * -1) : 0} Like   •   ",
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                      fontSize: utils.responsive(10, 10, 12, 14, screenType), color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (firebaseComments["like"]?[widget.user.username] ?? false) {
                                    _commentController.likeTheComment(firebaseComments["index"], false, widget.user.username);
                                  } else {
                                    _commentController.likeTheComment(firebaseComments["index"], true, widget.user.username);
                                  }
                                },
                                child: Icon(
                                  Icons.thumb_up,
                                  color: (firebaseComments["like"]?[widget.user.username] ?? false) ? const Color.fromARGB(255, 129, 168, 255) : Colors.grey,
                                  size: utils.responsive(14, 14, 16, 18, screenType),
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
