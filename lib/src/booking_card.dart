import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCard extends StatefulWidget {
  final Map details;
  final bool isAdmin;
  const BookingCard({Key? key, required this.details, required this.isAdmin})
      : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.details);
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
                    "Username: ${widget.details["username"]} ",
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
                    "Booked DateTime: ${widget.details["date"]} ${widget.details["time"]}",
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
                    "Service center name: ${widget.details["centername"]}",
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
                    "Repairing Parts: ${widget.details["partname"].trim()}",
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
                    "Message: ${widget.details["message"].trim()}",
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
            widget.isAdmin
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: widget.details["bookstatus"] == true
                          ? Text(
                              "Remove Booking",
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
                        child: Icon(
                          Icons.check,
                        ),
                      ),
                      onDeleted: () async {
                        if (widget.details["bookstatus"] == false) {
                          print("on click");
                          await FirebaseFirestore.instance
                              .collection("bookingdetail")
                              .doc(widget.details["bookid"])
                              .update({"bookstatus": true});
                          setState(() {});
                        }
                      },
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: widget.details["bookstatus"] == true
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
                        if (widget.details["bookstatus"] == false) {
                          print("on click");
                          await FirebaseFirestore.instance
                              .collection("bookingdetail")
                              .doc(widget.details["bookid"])
                              .update({"bookstatus": true});
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
