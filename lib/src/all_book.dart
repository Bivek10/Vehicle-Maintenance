import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';

import 'Widget/circularprogess.dart';
import 'booking_card.dart';

class AllBookDetails extends StatefulWidget {
  const AllBookDetails({Key? key}) : super(key: key);

  @override
  State<AllBookDetails> createState() => _AllBookDetailsState();
}

class _AllBookDetailsState extends State<AllBookDetails> {
  List allCenter = [];
  SessionManager sessionManager = SessionManager();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('bookingdetail');

  Future<List> getData() async {
    allCenter.clear();

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // QuerySnapshot querySnapshot =
    //     await _collectionRef.where("userid", isEqualTo: userid).get();

    querySnapshot.docs.forEach(
      (element) {
        Map x = {"bookid": element.id};
        x.addAll(element.data() as Map);
        allCenter.add(x);
      },
    );

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
          "Booking Details",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Object>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return allCenter.isEmpty
                    ? Center(child: CircularProgress())
                    : ListView.builder(
                        itemCount: allCenter.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: BookingCard(
                              details: allCenter[index],
                              isAdmin: true,
                            ),
                          );
                        }),
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

  Widget BookingCard({required details, required isAdmin}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 133, 225, 138),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Username: ${details["username"]} ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Booked DateTime: ${details["date"]} ${details["time"]}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Service center name: ${details["centername"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Repairing Parts: ${details["partname"].trim()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Message: ${details["message"].trim()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAdmin
                    ? InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("bookingdetail")
                              .doc(details["bookid"])
                              .delete();
                          setState(() {});
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Chip(
                            backgroundColor: Colors.white,
                            label: Text(
                              "Delete",
                              style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            deleteIcon: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.pink,
                                child: Icon(
                                  Icons.delete,
                                )),
                            onDeleted: () async {
                              await FirebaseFirestore.instance
                                  .collection("bookingdetail")
                                  .doc(details["bookid"])
                                  .delete();
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    : Container(),
                isAdmin
                    ? InkWell(
                        onTap: () async {
                          if (details["bookstatus"] == false) {
                            print("on click");
                            await FirebaseFirestore.instance
                                .collection("bookingdetail")
                                .doc(details["bookid"])
                                .update({"bookstatus": true});
                            setState(() {});
                          }
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Chip(
                            backgroundColor: Colors.white,
                            label: details["bookstatus"] == true
                                ? Text(
                                    "Accepted",
                                    style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )
                                : Text(
                                    "Accept Booking",
                                    style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                            deleteIcon: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.pink,
                              child: details["bookstatus"] == true
                                  ? Icon(
                                      Icons.check,
                                    )
                                  : Icon(
                                      Icons.remove,
                                    ),
                            ),
                            onDeleted: () async {
                              if (details["bookstatus"] == false) {
                                print("on click");
                                await FirebaseFirestore.instance
                                    .collection("bookingdetail")
                                    .doc(details["bookid"])
                                    .update({"bookstatus": true});
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Chip(
                          backgroundColor: Colors.white,
                          label: details["bookstatus"] == true
                              ? Text(
                                  "Book Status: Confirm",
                                  style: GoogleFonts.roboto(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )
                              : Text(
                                  "Book Status: Pending",
                                  style: GoogleFonts.roboto(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                          deleteIcon: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.pink,
                            child: Icon(
                              Icons.refresh,
                            ),
                          ),
                          onDeleted: () async {
                            if (details["bookstatus"] == false) {
                              print("on click");
                              await FirebaseFirestore.instance
                                  .collection("bookingdetail")
                                  .doc(details["bookid"])
                                  .update({"bookstatus": true});
                            }
                          },
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
