// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/signup_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password1 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool processRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff3531D5),
                          Color(0xff5D5BDD),
                          Color(0xff6A66DA),
                        ],
                      )),
                  alignment: Alignment.center,
                  child: const Text("Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 60,
                  margin: const EdgeInsets.only(right: 30, left: 30, top: 235),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70.withOpacity(0.2),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 250,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 250),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: Colors.white),
                  child: Column(
                    children: [
                      const Text("Welcome",
                          style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Enter your details below",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.5,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width - 60,
                        child: const Text("User Name",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 60,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "username required";
                            } else if (!RegExp(r"^[A-Za-z][A-Za-z0-9_]{7,29}$")
                                .hasMatch(value)) {
                              return "enter valid username";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "user name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.blueAccent)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width - 60,
                        child: const Text("Password",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 60,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: password1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password required";
                            } else if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                .hasMatch(value)) {
                              return "enter valid password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "password",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.blueAccent)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            processRun = true;
                            setState(() {});
                            http.Response response = await http.post(
                                Uri.parse(
                                    "https://todo-list-app-kpdw.onrender.com/api/auth/signin"),
                                body: {
                                  "username": username.text,
                                  "password": password1.text
                                });
                            debugPrint("Status Code = ${response.statusCode}");
                            debugPrint("Body = ${response.body}");
                            debugPrint(
                                "Body = ${jsonDecode(response.body)['accessToken']}");

                            processRun = false;
                            setState(() {});

                            if (response.statusCode == 200) {
                              debugPrint(" Login Successfully");
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              prefs.setString("token",
                                  "${jsonDecode(response.body)['accessToken']}");
                              Fluttertoast.showToast(
                                  msg: "Login Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color(0xff5D5BDD),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                    (route) => false,
                              );
                            } else {
                              debugPrint(
                                  "Body = ${jsonDecode(response.body)['message']}");
                              Fluttertoast.showToast(
                                  msg: "${jsonDecode(response.body)['message']}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color(0xff5D5BDD),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 60,
                          margin: const EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(colors: [
                                Color(0xff3531D5),
                                Color(0xff5D5BDD),
                                Color(0xff6A66DA),
                                Color(0xffD695F9)
                              ])),
                          alignment: Alignment.center,
                          child: processRun == true
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text("login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 29, left: 10),
                        child: Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.black54),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupScreen(),
                                    ));
                              },
                              child: const Text(
                                "Create account",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5D5BDD),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
