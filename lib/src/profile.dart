import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/src/Widget/circularprogess.dart';
import 'package:vehicle_maintainance/src/booking_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List allCenter = [];

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('bookingdetail');

  Future<List> getData() async {
    allCenter.clear();
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // print(querySnapshot.docs.asMap().);
    // Get data from docs and convert map to List
    // querySnapshot.docs.forEach(
    //   (element) {
    //     Map x = {"id": element.id};
    //     x.addAll(element.data() as Map);
    //     allCenter.add(x);
    //   },
    // );

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
    allCenter = allData;
    return allData;
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
            size: 35,
          ),
        ),
        title: Text(
          "Booking Details",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Object>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: allCenter.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: BookingCard(details: allCenter[index]),
                    );
                  }),
                );
                // return GridView.count(
                //   crossAxisCount: 2,
                //   mainAxisSpacing: 6,
                //   crossAxisSpacing: 6,
                //   childAspectRatio: 1 / 1.45,
                //   children: List.generate(
                //     allCenter.length,
                //     (index) => ServiceCenter(
                //       centerdata: allCenter[index],
                //     ),
                //   ),
                // );
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
