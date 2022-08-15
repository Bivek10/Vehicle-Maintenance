import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/src/Widget/circularprogess.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';
import 'package:vehicle_maintainance/src/loginPage.dart';
import 'package:vehicle_maintainance/src/profile.dart';

import 'Widget/service_center.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SessionManager sessionManager = SessionManager();
  List allCenter = [];
  @override
  void initState() {
    super.initState();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('servicecenter');

  Future<List> getData() async {
    allCenter.clear();
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // print(querySnapshot.docs.asMap().);
    // Get data from docs and convert map to List
    querySnapshot.docs.forEach(
      (element) {
        Map x = {"id": element.id};
        x.addAll(element.data() as Map);
        allCenter.add(x);
      },
    );
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    //print(allData);
    //allCenter = allData;
    return allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text(
          "List of Service Center",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () async {
                await sessionManager.deleteUserID();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), (route) => false);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Object>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1 / 1.45,
                  children: List.generate(
                    allCenter.length,
                    (index) => ServiceCenter(
                      centerdata: allCenter[index],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.hasError.toString(),
                  ),
                );
              }
              return Center(
                child: CircularProgress(),
              );
            }),
      ),
    );
  }
}
