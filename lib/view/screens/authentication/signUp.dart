import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';

import '../../../constants.dart';
import 'forget_password_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

 final TextEditingController passController = TextEditingController();
   final TextEditingController emailController = TextEditingController();
   final TextEditingController userNameController = TextEditingController();


   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Text(
                    "Create An Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        hintText: "User name",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: Image.asset(
                          "assets/icons/Group.png",height: 23,width: 23,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            "assets/icons/eye.png",
                            color: Color(0xff666666),
                          ),
                          onPressed: () {},
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.transparent)),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                 Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ForgetPasswordScreen()));
                    },
                    child:const Text(
                      "Forget password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>  RegisterScreen()));
                  },
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: redLevelColor),
                    margin: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      top: 20,
                      bottom: 15,
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Spacer(),
                    Expanded(child: Divider()),
                    Text("     Or     "),
                    Expanded(child: Divider()),
                    Spacer(),

                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    margin: const EdgeInsets.only(
                      left: 14,                    top: 20,

                      right: 14,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/logos_google-icon.svg",
                          height: 20,
                          width: 20,
                        ),
                        const Text(
                          "Continue With Google",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    margin: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      bottom: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/devicon_facebook.svg",
                          height: 20,
                          width: 20,
                        ),
                        const Text(
                          "Continue With Facebook",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const   Text("Already have an account?  ",style: TextStyle(
                        color: Color(0xff656565),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()));
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            color: redLevelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
