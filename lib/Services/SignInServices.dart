import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:venofy/SERVICES_Screens/GoogleSignInProvider.dart';
import 'package:firebase_database/firebase_database.dart';

class Services {
// if (_email.isNotEmpty && _password.isNotEmpty) {
//   if (_password == _confirmPassword) {
//     setState(() {
//       _progress = true;
//     });
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      // Navigator.pushNamed(context, HomeScreen.Intent);
//       setState(() {
//         _progress = false;
//       });
//     } catch (e) {
//       _error_ = true;
//       setState(() {
//         _progress = false;
//       });
//       print(e);
//     } // try
//   }
// }

  // final _auth = FirebaseAuth.instance;
  // final _googleSignIn = GoogleSignIn();

  // signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       await _auth.signInWithCredential(authCredential);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }
  // signOut() async {
  //   await _auth.signOut();
  //   await _googleSignIn.signOut();
  // }
}