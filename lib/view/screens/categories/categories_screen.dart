import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                  Image.asset("assets/icons/notify.png"),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3))),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.only(left: 8, right: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xffFFE4C1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.transparent)),
                      child: Row(
                        children: [
                          Image.asset("assets/images/sports.png"),
                          const Text(
                            " Volleyball",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.only(left: 8, right: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xffF0EE89),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.transparent)),
                      child: Row(
                        children: [
                          Image.asset("assets/images/foot.png"),
                          const Text(
                            " Football",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.only(left: 8, right: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xffFFE4C1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.transparent)),
                      child: Row(
                        children: [
                          Image.asset("assets/images/sports.png"),
                          const Text(
                            " Volleyball",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Expanded(
                child: GridView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: Image.asset('assets/images/sp.png'),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: Text(
                              "Join us in Mexico Canada Match",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "More details",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 5,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,mainAxisSpacing: 3,childAspectRatio:0.65,crossAxisSpacing: 15 ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
