import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/view/screens/book_screen/checkout.dart';
import 'package:graduation_project/view_model/database/local.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../Notification/notification_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.eventsData});

  final EventsData eventsData;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  var _focusDate=DateTime.now();

  final EasyInfiniteDateTimelineController _dateController =
      EasyInfiniteDateTimelineController();

  TextEditingController _controller = TextEditingController();
  String _selectedContent = '';

  TextEditingController seatNumberController = TextEditingController();

  // Function to handle selection
  void _selectContainer(String content) {
    setState(() {
      _selectedContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            EasyInfiniteDateTimeLine(
              activeColor: Color(0xffFC9597),
              controller: _dateController,
              showTimelineHeader: false,
              firstDate: DateTime.now(),
              dayProps: const EasyDayProps(
                // You must specify the width in this case.
                width: 70.0,
                height: 70,
              ),
              focusDate: _focusDate,
              lastDate: DateTime(2025, 12, 31),
              onDateChange: (selectedDate) {
                setState(() {
                  _focusDate = selectedDate;
                });
                print(_focusDate);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Place Information",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))),
                  child: _selectedContent == ""
                      ? const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please Enter the seat level',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 104,
                          decoration: BoxDecoration(
                              color: const Color(0xffFC9597),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Center(
                              child: _selectedContent == "Premium"
                                  ? const Text(
                                      'Premium',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 15),
                                    )
                                  : const Text(
                                      'Regular',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 15),
                                    )),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _selectContainer(
                        'Premium',
                      ),
                      child: Container(
                        height: 40,
                        width: 104,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5))),
                        child: const Center(
                            child: Text(
                          'Premium',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => _selectContainer('Regular'),
                      child: Container(
                        height: 40,
                        width: 104,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5))),
                        child: const Center(
                            child: Text(
                          'Regular',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15),
                        )),
                      ),
                    ),
                  ],
                ),
                // TextField to display the selected content
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            _selectedContent != ""
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: seatNumberController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Please enter the seat number",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "From 1 to 25",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Contact Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "First Name",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Last Name",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Phone Number",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.3))),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.eventsData.price}\$",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          InkWell(
                            onTap: () {
                              print(DateFormat("yyyy-MM-dd").format(_focusDate));
                              print(_selectedContent);
                              if(seatNumberController.text.isEmpty){
                                SmartDialog.showToast("Seat number is required");
                              }else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CheckoutScreen(
                                          eventsData: widget.eventsData,
                                          type: _selectedContent,
                                          seatNumber: int.parse(seatNumberController.text),
                                          date: DateFormat("yyyy-MM-dd").format(_focusDate),
                                        )));
                              }

                            },
                            child: Container(
                              height: 47,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: redLevelColor),
                              child: const Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    ));
  }
}
