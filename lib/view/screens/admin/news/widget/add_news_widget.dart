import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/CategoryModel.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/models/news_model.dart';
import 'package:graduation_project/models/sub_categories_model.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNewsScreen extends StatefulWidget {
  AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {

  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  final _formKey = GlobalKey<FormState>();



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
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                            hintText: "Date ",
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

                  ],
                ),
                const SizedBox(
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
                      NewsData eventsData = NewsData(
                        name: titleController.text,
                        description: descriptionController.text,
                        createdAt: _selectedDate,
                        image: image!.path
                         );
                      NewsCubit.get(context).addNews(eventsData).then((value){
                        _formKey.currentState!.reset();
                        NewsCubit.get(context).getNews();
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
        dateController.text = _selectedDate;
        print(_selectedDate);
      } else {
        _selectedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        dateController.text = _selectedDate;
      }
    });
  }


}
