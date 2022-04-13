import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ty_project0/screens/checkFilesPage.dart';
import 'package:ty_project0/screens/checkMeetingLinksPage.dart';
import 'package:ty_project0/screens/profilePage.dart';
import 'package:ty_project0/screens/startPage.dart';

class HomePage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoggedIn = false;

  final carouselImages = [
    'assets/images/win.png',
    'assets/images/grad.png',
    'assets/images/math.png'
  ];

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StartPage()));
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            if (!snapshot.data!.exists) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data?['role'] == 'students') {
                return clientHome();
              } else {
                return notClient();
              }
            }
          default:
            if (snapshot.data?['role'] == 'students') {
              return clientHome();
            } else {
              return notClient();
            }
        }
      },
    );
  }

  Widget notClient() {
    return Scaffold(
      body: SafeArea(
          child: AlertDialog(
        title: Text("Access denied"),
        content: Text("Download ADMIN app, If you are teacher!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => StartPage(),
                ),
              );
            },
            child: Text("OK"),
          )
        ],
      )),
    );
  }

  Widget clientHome() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text("Logout")
                  ],
                ),
              ),
            ],
            onSelected: (item) => handleClick(context, item),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: double.infinity,
          child: !isLoggedIn
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CarouselSlider.builder(
                            itemCount: carouselImages.length,
                            itemBuilder: (context, index, realIndex) {
                              final carouselImage = carouselImages[index];
                              return buildImage(carouselImage, index);
                            },
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              enableInfiniteScroll: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 05.0),
                        child: ElevatedButton(
                          child: Container(
                            child: Center(
                              child: Row(
                                children: [
                                  Spacer(),
                                  Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 05.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckMeetingLinksPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Spacer(flex: 2),
                                        Icon(
                                          Icons.collections_bookmark_outlined,
                                          size: 55,
                                        ),
                                        Spacer(flex: 1),
                                        Text(
                                          "View Links",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Spacer(flex: 2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 05.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckFilesPage()));
                                },
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Spacer(flex: 2),
                                        Icon(
                                          Icons.document_scanner,
                                          size: 55,
                                        ),
                                        Spacer(flex: 1),
                                        Text(
                                          "View Files",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Spacer(flex: 2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildImage(String img, int) => Container(
        color: Colors.white,
        child: Image(
          image: AssetImage(img),
          fit: BoxFit.fitWidth,
        ),
      );

  void handleClick(BuildContext context, item) {
    switch (item) {
      case 0:
        _auth.signOut();
        break;
    }
  }
}
