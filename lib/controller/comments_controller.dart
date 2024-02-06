import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class CommentController {
  final List<String> sortList = <String>[
    "Recently",
    "Oldest",
    "Most Liked",
  ];

  FirebaseDatabase database = FirebaseDatabase.instance;

  Query getCommentsQueryFromDB(String sortType){
    if (sortType == sortList[1]) { // Oldest
      Query commentsQuery = database.ref().child("comments").orderByChild("date_time");
      return commentsQuery;
    } else if (sortType == sortList[2]){ // Most Liked
      Query commentsQuery = database.ref().child("comments").orderByChild("likeCount");
      return commentsQuery;
    } else { // Recently
      Query commentsQuery = database.ref().child("comments").orderByChild("index");
      return commentsQuery;
    }
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

  void likeTheComment(int uniqIndex, bool likeIt, String yourUsername) async {
    // Stored keys, well, this will likely only contain 1 value hehe
    List<String> storedKey = [];

    // Get Key that equal to uniqIndex
    DatabaseEvent event = await database.ref().child("comments").orderByChild("index").equalTo(uniqIndex).once();
    DataSnapshot snapshotComments = event.snapshot;
    Map<String, dynamic> comments = (snapshotComments.value ?? new Map<String, dynamic>()) as Map<String, dynamic>;
    comments.forEach((key, value) {
      storedKey.add(key);
    });

    // Init database reference from one object that we will change/update
    DatabaseReference ref = database.ref().child("comments/${storedKey.first}");

    final snapshotComment = await ref.get();

    // Fetch data from reference to Map
    Map<String, dynamic> selectedComment = snapshotComment.value as Map<String, dynamic>;

    // Fetch Map for updating likes
    Map likeMap = selectedComment["like"] ?? {};
    // int likeCount = ((selectedComment["like"] ?? {}) as Map).length;
    int likeCount = selectedComment["likeCount"];

    // is i liked the comment?
    if (likeIt) {
      likeMap[yourUsername] = true;
      likeCount--;
    } else {
      likeMap.remove(yourUsername);
      likeCount++;
    }

    // Store updated data before update to ref
    Map<String, dynamic> updatedData = {
      "like": likeMap,
      "likeCount": likeCount
    };

    // Then update like data
    ref.update(updatedData);
  }

  Future<void> writeComment(String currentUsername, String message) async {

    // init timestamp dateTime now dd/mm/yy hh/mm
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    int timeStampNow = DateTime.parse(dateFormat.format(DateTime.now()).toString()).millisecondsSinceEpoch;

    // init generated index
    int index = await _generateIndex();

    // init post comment
    final postComment = {
      "date_time" : "$timeStampNow",
      "like" : {},
      "message" : message,
      "username" : currentUsername,
      "index" : index,
    };

    // Get a key for a new Post.
    final newPostKey = FirebaseDatabase.instance.ref().child('comments').push().key;

    // Write the new post's data simultaneously in the posts list and the
    // user's post list.
    final Map<String, Map> updates = {};
    updates['/comments/$newPostKey'] = postComment;

    return FirebaseDatabase.instance.ref().update(updates);
  }

  Future<int> _generateIndex() async {
    DatabaseEvent event = await database.ref().child("comments").orderByChild("index").once();
    Map<String, dynamic> comments = (event.snapshot.value ?? {}) as Map<String, dynamic>;

    // If empty return default index value
    if(comments.isEmpty){
      return 10000000000;
    }

    return comments.values.last["index"] -= 1;
  }
}