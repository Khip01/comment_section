import 'package:firebase_database/firebase_database.dart';

class CommentController {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Query getCommentsQueryFromDB(){
    Query commentsQuery = database.ref().child("comments");
    return commentsQuery;
  }

  Future<int> getTotalComments() async {
    // fetch data
    var snapshot = await database.ref().child("comments").get();
    if (snapshot.exists) {
      Map data = snapshot.value as Map;
      return data.length;
    } else {
      return 0;
    }
  }

  void likeTheComment(String commentId, bool likeIt, String yourUsername) async {
    // Init database reference
    DatabaseReference ref = database.ref().child("comments/$commentId");

    final snapshot = await ref.get();

    // Fetch data from reference to Map
    Map<String, dynamic> selectedComment = snapshot.value as Map<String, dynamic>;

    // Fetch Map for updating likes
    Map likeMap = selectedComment["like"] ?? {};

    if (likeIt) {
      likeMap[yourUsername] = true;
    } else {
      likeMap.remove(yourUsername);
    }

    // Then update like data
    ref.update({"like": likeMap});
  }

}