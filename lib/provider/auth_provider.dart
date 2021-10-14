import 'package:fastfood_app/helpers/auth_helpers.dart';
import 'package:fastfood_app/helpers/firestore_helpers.dart';
import 'package:fastfood_app/model/auth_model/register_request_model.dart';
import 'package:fastfood_app/model/auth_model/user_model.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/auth_screen/login_screen.dart';
import 'package:fastfood_app/view/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  List<UserModel> users = [];
  UserModel? user;
  String? myId;

  getUserFromFirestore() async {
    String userId = AuthHelpers.authHelpers.getUserId();
    user = await FirestoreHelpers.firestoreHelpers.getUserFromFirestore(userId);
    notifyListeners();
  }

  resetController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelpers.authHelpers
          .signUp(emailController.text, passwordController.text);

      RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user!.uid,
        fname: fNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await FirestoreHelpers.firestoreHelpers
          .addUserToFirestore(registerRequest);
      await AuthHelpers.authHelpers.logOut();
      RouteHelper.routeHelper.goToPageReplacement(LoginScreen.routeName);
    } on Exception catch (e) {
      // TODO
    }
    resetController();
  }

  logOut() async {
    await AuthHelpers.authHelpers.logOut();
    RouteHelper.routeHelper.goToPageReplacement(LoginScreen.routeName);
  }

  login() async {
    UserCredential userCredential = await AuthHelpers.authHelpers
        .signIn(emailController.text, passwordController.text);
    FirestoreHelpers.firestoreHelpers
        .getUserFromFirestore(userCredential.user!.uid);
    this.myId = AuthHelpers.authHelpers.getUserId();
    getUserFromFirestore();
    RouteHelper.routeHelper.goToPageReplacement(HomeScreen.routeName);
    resetController();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelpers.authHelpers.checkUserLoging();
    print(FirebaseAuth.instance.currentUser);
    if (isLoggedIn) {
      this.myId = AuthHelpers.authHelpers.getUserId();
      getUserFromFirestore();
      getAllUserFromFirestore();
      RouteHelper.routeHelper.goToPageReplacement(HomeScreen.routeName);
    } else {
      getUserFromFirestore();
      getAllUserFromFirestore();
      RouteHelper.routeHelper.goToPageReplacement(LoginScreen.routeName);
    }
  }

  resetPassword() async {
    AuthHelpers.authHelpers.resetPassword(emailController.text);
    RouteHelper.routeHelper.goToPageReplacement(LoginScreen.routeName);
    resetController();
  }

  getAllUserFromFirestore() async {
    users = await FirestoreHelpers.firestoreHelpers.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id == myId);
    notifyListeners();
  }

  fillControllers() {
    fNameController.text = user!.fname!;
    emailController.text = user!.email!;
  }
}
