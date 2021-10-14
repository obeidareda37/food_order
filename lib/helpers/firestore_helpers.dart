import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/model/auth_model/register_request_model.dart';
import 'package:fastfood_app/model/auth_model/user_model.dart';

class FirestoreHelpers {
  FirestoreHelpers._();

  static FirestoreHelpers firestoreHelpers = FirestoreHelpers._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      await firebaseFirestore
          .collection('User')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('User').doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data() as Map);
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('User').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
}
