import 'package:firebase_database/firebase_database.dart';

// Initial Database Default
FirebaseDatabase database = FirebaseDatabase.instance;

class UserController {

  Future<void> createAccount(String username, String email) async {
    // Initial Database Reference
    DatabaseReference ref = database.ref("user/$username");

    // save

    await ref.set({
      "email"   : email,
    });
  }

  Future<bool> checkEmailAlreadyExist(String email) async{
    // Initial Database Reference
    DatabaseReference ref = database.ref("user");
    Query query = ref.orderByChild("email").equalTo(email);

    // Check Already Exist
    final databaseEvent = await query.once();

    return databaseEvent.snapshot.exists;
  }

  Future<bool> checkUsernameAlreadyExist(String username) async {
    // Initial Database Reference
    DatabaseReference ref = database.ref();
    // Snapshot
    final snapshot = await ref.child("user").get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
      for (String key in data.keys) {
        if (key == username) {
          return true;
        }
      }
      return false;
    } else {
      // data not available
      return false;
    }
  }

  Future<String?> getUsernameFrom(String email) async {
    // Initial Database Reference
    DatabaseReference ref = database.ref("user");
    Query query = ref.orderByChild("email").equalTo(email);

    final databaseEvent = await query.once();

    if (databaseEvent.snapshot.exists) {
      Map<String, dynamic> dataFound = databaseEvent.snapshot.value as Map<String, dynamic>;
      return dataFound.keys.first;
    } else {
      return null;
    }
  }

}

