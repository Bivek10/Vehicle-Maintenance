import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/circularprogess.dart';
import 'data/session_data.dart';

class ReviewDetails extends StatefulWidget {
  const ReviewDetails({Key? key}) : super(key: key);

  @override
  State<ReviewDetails> createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  SessionManager sessionManager = SessionManager();
  List allCenter = [];

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('servicecenter');

  Future<List> getData() async {
    allCenter.clear();
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    List centerID = [];
    querySnapshot.docs.forEach(
      (element) {
        centerID.add(element.id);
      },
    );
    for (var i = 0; i < centerID.length; i++) {
      QuerySnapshot querySnapshot1 = await _collectionRef
          .doc(centerID[i].toString())
          .collection("review")
          .get();
      querySnapshot1.docs.forEach((element) {
        allCenter.add(element.data());
      });
    }
    //print(allCenter);
    return allCenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Text(
          "Review Details",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            color: Color.fromARGB(255, 60, 57, 57),
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: FutureBuilder<Object>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return allCenter.isEmpty
                  ? Center(
                      child: Text("No Review "),
                    )
                  : ListView.builder(
                      itemCount: allCenter.length,
                      itemBuilder: (context, index) {
                        return ReivewCard(
                          username: allCenter[index]["username"] ?? "",
                          message: allCenter[index]["message"],
                        );
                      },
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
    );
  }
}

class ReivewCard extends StatelessWidget {
  final String username;
  final String message;
  const ReivewCard({Key? key, required this.username, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {
          //press();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(username),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
