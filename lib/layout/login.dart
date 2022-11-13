import 'package:bycatering/layout/navigasiadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homecustomer.dart';
import 'homeadmin.dart';
import 'register.dart';
import 'lupapassword.dart';
import 'navigasi.dart';
import 'navigasiadmin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  bool? rememberMe = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe == true) {
          print('clicked');
        } else {
          // TODO: Forget the user
        }
      });
  void _togglePasswordView() {
    setState(() {
      _isObscure3 = !_isObscure3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDEE6E8),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 20,
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'Silahkan Masuk',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xff267ac0),
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // contentPadding: EdgeInsets.all(20),
                  ),
                  autofillHints: [AutofillHints.email],
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please enter a valid email");
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  //  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xff267ac0),
                        ),
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isObscure3
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xff267ac0),
                          )),
                      contentPadding: EdgeInsets.all(20),
                    ),
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return ("please enter valid password min. 6 character");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(
                        children: [
                          Checkbox(
                              value: rememberMe,
                              onChanged: _onRememberMeChanged),
                          Text(
                            'Ingat Saya',
                            style: TextStyle(
                              fontFamily: "Nunito",
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        child: Text(
                          'Lupa password ?',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LupaPassword()));
                        },
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  elevation: 5.0,
                  height: 40,
                  onPressed: () {
                    setState(() {
                      visible = true;
                    });
                    signIn(emailController.text, passwordController.text);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  color: Colors.white,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Belum punya akun ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nunito",
                          fontSize: 14,
                        ),
                      ),
                      MaterialButton(
                        textColor: Colors.black,
                        child: Text(
                          'Buat akun',
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: Text(
                    'atau Lanjutkan dengan',
                    style: TextStyle(
                        fontFamily: "Nunito",
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 35,
                        width: 35,
                        child: InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            child: Image.asset('assets/images/FB.png',
                                height: 30, width: 30),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            // onPressed: () {},
                            // heroTag: null,
                            child: Image.asset('assets/images/Google.png',
                                height: 24, width: 24),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigasiAdmin(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Navigasi(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
