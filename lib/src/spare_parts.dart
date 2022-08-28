import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/src/booking_form.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';

import 'Widget/circularprogess.dart';

class SpareParts extends StatefulWidget {
  final String centerID;
  final String centerName;
  const SpareParts({Key? key, required this.centerID, required this.centerName})
      : super(key: key);

  @override
  State<SpareParts> createState() => _SparePartsState();
}

class _SparePartsState extends State<SpareParts> {
  List allCenter = [];
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
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text(
          "List of Spare parts",
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
              onTap: () async {},
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
      body: FutureBuilder<Object>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return allCenter.isEmpty
                  ? Center(
                      child: Text("No spares part are available!"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: allCenter.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 133, 225, 138),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Partname: ${allCenter[index]["partname"]} ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.price_change,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Price: ${allCenter[index]["price"]} ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.event_available,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Status: ${allCenter[index]["status"]} ",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: () async {
                                                  SessionManager
                                                      sessionManager =
                                                      SessionManager();
                                                  String? userid =
                                                      await sessionManager
                                                          .getUserID();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return BookingFomr(
                                                          centerid:
                                                              widget.centerID,
                                                          centername:
                                                              widget.centerName,
                                                          userid: userid ?? "",
                                                          partname:
                                                              allCenter[index]
                                                                  ["partname"],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Chip(
                                                  backgroundColor: Colors.white,
                                                  label: Text(
                                                    "Book Now",
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headline4,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                  deleteIcon: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.pink,
                                                    child: Icon(
                                                      Icons.chevron_right,
                                                    ),
                                                  ),
                                                  onDeleted: () async {
                                                    SessionManager
                                                        sessionManager =
                                                        SessionManager();
                                                    String? userid =
                                                        await sessionManager
                                                            .getUserID();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return BookingFomr(
                                                            centerid:
                                                                widget.centerID,
                                                            centername: widget
                                                                .centerName,
                                                            userid:
                                                                userid ?? "",
                                                            partname: allCenter[
                                                                    index]
                                                                ["partname"],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*
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
                                        /*
                                      Expanded(
                                        child: Text(
                                          "Repairing Parts: ${details["message"].trim()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                     */
                                      ],
                                    ),
                                    */
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
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

  Future<List> getData() async {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('servicecenter')
        .doc(widget.centerID)
        .collection("sparepart");
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
}
