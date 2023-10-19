import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setRouting();
  }

  setRouting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Future.delayed(const Duration(seconds: 4), () {
      if (token == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
                (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3531D5),
                  //Color(0xff5D5BDD),
                  Color(0xff6A66DA),
                ],
              )),
          child: SizedBox(
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://brigada.org/wp-content/uploads/2014/11/task.jpg",
              ),
            ),
          ),
        ),
      ),
      // body: appTheme(height: MediaQuery.of(context).size.height!,width: MediaQuery.of(context).size.width!,widget: Text("TASK",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 60),)),
    );
  }
}



