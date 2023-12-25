import 'package:chat_app/Modules/Views/Login_screen/Model/SignIn_model/signin_model.dart';
import 'package:chat_app/Modules/Views/Login_screen/Model/SignUp_model/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Cloud_firestore_helper/firestore_helper.dart';

class Auth_helper {
  Auth_helper._();

  static final Auth_helper auth_helper = Auth_helper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map> AnnoynimousLogin() async {
    Map res = {};

    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signUp({required SignUp data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signIn({required SignIn data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: data.email, password: data.password);

      Firestore_Helper.firestore_helper.addUser(user_data: {
        "name": (userCredential.user?.displayName == null)
            ? userCredential.user?.email?.split("@")[0]
            : userCredential.user?.displayName,
        "email": userCredential.user?.email,
        "photo": (userCredential.user?.photoURL == null)
            ? "https://simg.nicepng.com/png/small/853-8534448_cartoon-suit-and-tie.png"
            : userCredential.user?.photoURL,
        "uid": userCredential.user?.uid,
      });

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    Map<String, dynamic> res = {};
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      Firestore_Helper.firestore_helper.addUser(user_data: {
        "name": userCredential.user?.displayName,
        "email": userCredential.user?.email,
        "photo": userCredential.user?.photoURL,
        "uid": userCredential.user?.uid,
      });

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  void signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
