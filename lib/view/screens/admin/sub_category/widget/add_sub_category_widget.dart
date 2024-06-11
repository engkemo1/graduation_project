import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/CategoryModel.dart';
import 'package:graduation_project/models/news_model.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddSubCategoryScreen extends StatefulWidget {
  AddSubCategoryScreen({super.key});

  @override
  State<AddSubCategoryScreen> createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  List<CategoryData> categoryList = [];

  final _formKey = GlobalKey<FormState>();
  var category;

  @override
  void initState() {
    HomeCubit.get(context).getCategories().then((value) {
      categoryList = value;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
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
                      child: image != null
                          ? Image.file(
                              File(
                                image!.path,
                              ),
                              fit: BoxFit.contain,
                            )
                          : Icon(
                              Icons.image_outlined,
                              size: 50,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
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
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
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
                        setState(() {
                          category = value;
                        });
                      },
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
                      CategoryData categoryData = CategoryData(
                          name: titleController.text,
                          slug: category.sId,
                          image: image!.path);
                      HomeCubit.get(context)
                          .addSubCategories(categoryData)
                          .then((value) {
                        _formKey.currentState!.reset();
                        HomeCubit.get(context).getSubCategories();
                      });
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(redLevelColor)),
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
}
