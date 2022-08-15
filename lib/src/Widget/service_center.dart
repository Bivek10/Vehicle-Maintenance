import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/src/booking_form.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';

class ServiceCenter extends StatelessWidget {
  final Map centerdata;

  const ServiceCenter({
    Key? key,
    required this.centerdata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(centerdata["id"]);
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
          bottom: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/image/gridimage.jpg",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Text(
                centerdata["name"],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Open At",
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Text(
                            centerdata["open"],
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Close At",
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.orangeAccent,
                            size: 14,
                          ),
                          Text(
                            centerdata["close"],
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.orangeAccent,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      centerdata["address"],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            /*
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehicle Type",
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                /*
                Container(
                  height: 80,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      spacing: 0,
                      children: List.generate(
                        4,
                        (index) => Chip(
                          // avatar: CircleAvatar(
                          //   radius: 20,
                          //   backgroundColor: Colors.orangeAccent,
                          //   child: Icon(
                          //     Icons.settings,
                          //   ),
                          // ),
                          label: Text("car"),
                        ),
                      ),
                    ),
                  ),
                ),
                */
              ],
            ),
             */
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () async {
                    SessionManager sessionManager = SessionManager();
                    String? userid = await sessionManager.getUserID();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BookingFomr(
                            centerid: centerdata["id"],
                            centername: centerdata["name"],
                            userid: userid ?? "",
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
                        textStyle: Theme.of(context).textTheme.headline4,
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
                        Icons.chevron_right,
                      ),
                    ),
                    onDeleted: () async {
                      SessionManager sessionManager = SessionManager();
                      String? userid = await sessionManager.getUserID();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BookingFomr(
                              centerid: centerdata["id"],
                              centername: centerdata["name"],
                              userid: userid ?? "",
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
      ),
    );
  }
}
