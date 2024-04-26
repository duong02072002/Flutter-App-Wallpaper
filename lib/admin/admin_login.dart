import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaper/admin/add_wallpaper.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    110,
                  ))),
            ),
            Container(
              margin: EdgeInsets.only(top: 65, left: 30, right: 30),
              child: Form(
                key: formkey,
                child: Column(children: [
                  Text(
                    "Let's Start with\nAmin",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, left: 20, bottom: 5),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: usernamecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 160, 160, 147))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, left: 20, bottom: 5),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextFormField(
                                obscureText: true,
                                controller: userpasswordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 160, 160, 147))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              LoginAdmin();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content:
                Text('Your id is not correct', style: TextStyle(fontSize: 18)),
          ));
        }
        if (result.data()['password'] != userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Your password is not correct',
                style: TextStyle(fontSize: 18)),
          ));
        } else {
          Route route = MaterialPageRoute(builder: (context) => AddWallpaper());
          Navigator.pushReplacement(context, route);
        }
      }
    });
  }
}
