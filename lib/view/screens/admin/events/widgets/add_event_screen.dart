import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/CategoryModel.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/models/sub_categories_model.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController seatNumberController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  TextEditingController priceOfRegularController = TextEditingController();

  TextEditingController priceOfPremuimController = TextEditingController();

  TextEditingController fromController = TextEditingController();

  TextEditingController toController = TextEditingController();
  TextEditingController placesLeftController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String _selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String _selectedEndDate = DateFormat("yyyy-MM-dd").format(
      DateTime.now().add(Duration(days: 3)));
  final _formKey = GlobalKey<FormState>();

  var category ;

  var subCategory ;

  List<CategoryData> categoryList = [];

  List<SubCategoryData> subCategoryList = [];

  ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> _pickImage() async {
    final XFile? selectedImage = await picker.pickImage(
        source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  @override
  void initState() {
    HomeCubit.get(context).getCategories().then((value) {
      categoryList = value;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Add Photo",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    width: 162,
                    height: 152,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5)),
                    child: Center(
                      child: image != null ? Image.file(
                        File(image!.path,), fit: BoxFit.contain,) : Icon(
                        Icons.image_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: priceOfRegularController,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          hintText: "Price of Regular",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.4),
                          filled: true,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: seatNumberController,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          hintText: "Seat Number",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: priceOfPremuimController,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          hintText: "Price of premuim",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.4),
                          filled: true,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: TextField(
                          controller: fromController,
                          decoration: InputDecoration(
                            hintText: "from ",
                            hintStyle: const TextStyle(color: Colors.black54),
                            // focusColor: Colors.grey.withOpacity(0.5),
                            suffixIcon: Icon(Icons.date_range_outlined),
                            enabled: false,

                            fillColor: Colors.grey.withOpacity(0.5),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              const BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectEndDate(context);
                        },
                        child: TextField(
                            controller: toController,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "To",
                              hintStyle: const TextStyle(color: Colors.black54),
                              // focusColor: Colors.grey.withOpacity(0.5),
                              fillColor: Colors.grey.withOpacity(0.4),
                              filled: true,
                              suffixIcon: Icon(Icons.date_range_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                const BorderSide(color: Colors.transparent),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.4)),
                        child: Center(
                          child: DropdownButton<CategoryData>(
                            underline: const SizedBox(),
                            hint: Text(
                              "Category",
                              style: TextStyle(color: Colors.black54),
                            ),
                            isExpanded: true,
                            value: category,
                            items: categoryList.map((CategoryData e) {
                              return DropdownMenuItem<CategoryData>(
                                value: e,
                                child: Text(e
                                    .name!), // Assuming 'name' is a property of CategoryData that contains the text you want to display
                              );
                            }).toList(),
                            onChanged: (CategoryData? value) {
                              print(value);
                              HomeCubit.get(context)
                                  .getSubSpecificCategories(value!.sId.toString())
                                  .then((value) {
                                subCategoryList = value;
                                setState(() {});
                              });

                              setState(() {
                                category = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.4)),
                        child: Center(
                          child: DropdownButton<SubCategoryData>(
                              underline: const SizedBox(),
                              hint: const Text(
                                "Sub Category",
                                style: TextStyle(color: Colors.black54),
                              ),
                              isExpanded: true,
                              value: subCategory,
                              items: subCategoryList.map((SubCategoryData e) {
                                return DropdownMenuItem<SubCategoryData>(
                                  value: e,
                                  child: Text(e
                                      .name!), // Assuming 'name' is a property of CategoryData that contains the text you want to display
                                );
                              }).toList(),
                              onChanged: (SubCategoryData? value) {
                                setState(() {
                                  subCategory = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: placesLeftController,
                        
                        decoration: InputDecoration(
                          hintText: "Location",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.4),
                          filled: true,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          
                          hintText: "Places Left",
                          hintStyle: const TextStyle(color: Colors.black54),
                          // focusColor: Colors.grey.withOpacity(0.5),
                          fillColor: Colors.grey.withOpacity(0.4),
                          filled: true,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Description",

                    hintStyle: const TextStyle(color: Colors.black54),
                    // focusColor: Colors.grey.withOpacity(0.5),
                    fillColor: Colors.grey.withOpacity(0.4),
                    filled: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                            EventsData eventsData = EventsData(
                                title: titleController.text,
                                seatnumber: int.tryParse(seatNumberController.text),
                                description: descriptionController.text,
                                price: int.tryParse(priceOfRegularController.text),
                                pricePre
                                    : int.tryParse(priceOfPremuimController.text),
                                from: _selectedDate,
                                to: _selectedEndDate,
                                placesLeft: int.tryParse(placesLeftController.text),
                                category: category.sId??"",
                                subcategorie: subCategory.sId??"",
                                location: locationController.text,
                                imageCover: image!.path);
                            HomeCubit.get(context).addEvent(eventsData).then((value){
                              _formKey.currentState!.reset();
                              HomeCubit.get(context).upcomingEvents();
                            });
                    },
                    child: Text("Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),),
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            redLevelColor)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
    );
  }

  DateTime join(DateTime date, TimeOfDay time) {
    print(time.hour);
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    setState(() {
      if (selected != null) {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selected).toString();
        fromController.text = _selectedDate;
        print(_selectedDate);
      } else {
        _selectedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        fromController.text = _selectedDate;
      }
    });
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    setState(() {
      if (selected != null) {
        _selectedEndDate = DateFormat('yyyy-MM-dd').format(selected).toString();
        toController.text = _selectedEndDate;
        print(_selectedEndDate);
      } else {
        _selectedEndDate =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        toController.text = _selectedEndDate;
      }
    });
  }
}
