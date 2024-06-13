import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/screens/main_screen.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class TicketCard extends StatelessWidget {
  final String price;
  final String id;
  final dynamic eventsData;

  const TicketCard(
      {super.key, required this.price, required this.id, this.eventsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Builder(builder: (context) {
                var date1 = DateTime.parse(eventsData.from.toString());
                var date2 = DateTime.parse(eventsData.to.toString());
                String monthName = DateFormat('MMMM').format(date1);
                return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    elevation: 0.8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Image.network(
                              eventsData.imageCover.toString(),
                              height: double.infinity,
                              width: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (context, e, o) => Image.asset(
                                "assets/images/event.png",
                                height: double.infinity,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            )),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              " ${eventsData.location} ${eventsData.title}  ${date1.day}:${date2.day} $monthName ${date1.year}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Date: ${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                    style: const TextStyle(fontSize: 18),
                  ),
                   Text(
                    'Price: \$$price',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 90),
              Container(
                height: 200,
                child: SfBarcodeGenerator(
                  value: id,
                  symbology: QRCode(inputMode: QRInputMode.alphaNumeric),
                  showValue: true,
                ),
              ),
Spacer(),              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.redAccent)),
                    child: const Center(
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
