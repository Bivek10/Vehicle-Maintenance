import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_maintainance/src/Widget/circularprogess.dart';
import 'package:vehicle_maintainance/src/Widget/costume_text.dart';
import 'package:vehicle_maintainance/src/data/session_data.dart';

import 'home_page.dart';

class BookingFomr extends StatefulWidget {
  final String userid;
  final String centerid;
  final String centername;

  const BookingFomr(
      {Key? key,
      required this.userid,
      required this.centerid,
      required this.centername})
      : super(key: key);

  @override
  State<BookingFomr> createState() => _BookingFomrState();
}

class _BookingFomrState extends State<BookingFomr>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  TextEditingController usernamectrl = TextEditingController();
  TextEditingController datectrl = TextEditingController();
  TextEditingController timectrl = TextEditingController();
  TextEditingController serviceType = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isRequest = false;
  SessionManager sessionManager = SessionManager();
  final format = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    //print(widget.userid.toString());
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
          "Booking Form",
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
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernamectrl,
                      cursorColor: Colors.orangeAccent,
                      style: CostumTextBorder.textfieldstyle,
                      decoration: CostumTextBorder.textfieldDecoration(
                        context: context,
                        hintText: "Username",
                        lableText: "Username",
                        iconData: Icons.person,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required.";
                        }
                        // final RegExp emailExp = RegExp(
                        //     r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        // if (!emailExp.hasMatch(value.trim())) {
                        //   return "Invalid E-mail address";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumber,
                      cursorColor: Colors.orangeAccent,
                      style: CostumTextBorder.textfieldstyle,
                      decoration: CostumTextBorder.textfieldDecoration(
                          context: context,
                          hintText: "Contact No.",
                          lableText: "Contact No.",
                          iconData: Icons.phone),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Contact number is required.";
                        }
                        // final RegExp emailExp = RegExp(
                        //     r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        // if (!emailExp.hasMatch(value.trim())) {
                        //   return "Invalid E-mail address";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimeField(
                      controller: datectrl,
                      format: format,
                      decoration: CostumTextBorder.textfieldDecoration(
                        context: context,
                        hintText: "Date",
                        lableText: "Date",
                        iconData: Icons.date_range,
                      ),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Date is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimeField(
                      controller: timectrl,
                      format: format1,
                      decoration: CostumTextBorder.textfieldDecoration(
                        context: context,
                        hintText: "Time",
                        lableText: "Time",
                        iconData: Icons.date_range,
                      ),
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(time);
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Time is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: serviceType,
                      cursorColor: Colors.orangeAccent,
                      style: CostumTextBorder.textfieldstyle,
                      decoration: CostumTextBorder.textfieldDecoration(
                          context: context,
                          hintText: "Repairing Part",
                          lableText: "Repairing Part",
                          iconData: Icons.email),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Repairing Part is required.";
                        }
                        // final RegExp emailExp = RegExp(
                        //     r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        // if (!emailExp.hasMatch(value.trim())) {
                        //   return "Invalid E-mail address";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _submitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (formKey.currentState!.validate()) {
          try {
            setState(() {
              this.isRequest = true;
            });
            var response =
                FirebaseFirestore.instance.collection('bookingdetail').add({
              'centerid': widget.centerid,
              'userid': widget.userid,
              "centername": widget.centername,
              'message': serviceType.text,
              "username": usernamectrl.text,
              'phone': phoneNumber.text,
              "date": datectrl.text,
              "time": timectrl.text,
            });

            response.then((value) {
              if (value.id.isNotEmpty) {
                //sessionManager.setUserID(value.id.toString());
                setState(() {
                  this.isRequest = false;
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false,
                );
                Fluttertoast.showToast(
                    msg: "Thank You! Your service is booked",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                setState(() {
                  this.isRequest = false;
                });
                Fluttertoast.showToast(
                    msg: "Sorry! Booking failed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            });
          } catch (e, s) {
            setState(() {
              this.isRequest = false;
            });
            //print(e);
            //print(s);
          }
        }
        //start registration;
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)],
          ),
        ),
        child: this.isRequest
            ? CircularProgress()
            : Text(
                'Confirm Book',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
      ),
    );
  }
}
