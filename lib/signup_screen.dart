import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final email2 = TextEditingController();
  final password2 = TextEditingController();
  final confirmPassword2 = TextEditingController();
  bool processRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 205,
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
                child: const Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 60,
                margin: const EdgeInsets.only(right: 30, left: 30, top: 160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70.withOpacity(0.2),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 140,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 175),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Text("Welcome",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
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
                        controller: userName,
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
                          hintText: "username",
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
                      child: const Text("Email Address",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: email2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email required";
                          } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)) {
                            return "enter valid email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "email address",
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
                        controller: password2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password required";
                          } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$')
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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width - 60,
                      child: const Text("Confirm Password",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: confirmPassword2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password required";
                          } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "enter valid password";
                          } else if (password2.text != confirmPassword2.text) {
                            return "check password";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: " confirm password",
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
                                  "https://todo-list-app-kpdw.onrender.com/api/auth/signup"),
                              body: {
                                "username": userName.text,
                                "email": email2.text,
                                "password": password2.text
                              });

                          debugPrint("Status Code = ${response.statusCode}");
                          debugPrint("Body = ${response.body}");
                          debugPrint(
                              "message = ${jsonDecode(response.body)['message']}");

                          processRun = false;
                          setState(() {});

                          if (response.statusCode == 200) {
                            debugPrint(" ${jsonDecode(response.body)['message']}");
                            Fluttertoast.showToast(
                                msg: "${jsonDecode(response.body)['message']}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: const Color(0xff5D5BDD),
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          } else {
                            debugPrint(
                                "Message = ${jsonDecode(response.body)['message']}");
                            Fluttertoast.showToast(
                                msg: "${jsonDecode(response.body)['message']}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: const Color(0xff5D5BDD),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          debugPrint("Invalid Data");
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
                              Color(0xffD695F9),
                            ])),
                        alignment: Alignment.center,
                        child: processRun == true
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text("sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 50),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account?",
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
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5D5BDD),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
