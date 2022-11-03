import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:promina_assign/res/text_widget.dart';
import 'package:promina_assign/view/home/home_screen.dart';
import 'package:promina_assign/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login.png'),
                fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: size.height * .3),
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextUtils(
              text: 'My\nGallery',
              fontFamily: 'SegoeUI',
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.37,
                  width: size.width * 0.68,
                  child: Column(
                    children: [
                      TextUtils(
                        text: 'LOG IN',
                        fontFamily: 'SegoeUI',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailcontroller,
                        validator: (value) =>
                            value!.isEmpty ? 'enter a valid username' : null,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          labelText: 'User Name',

                          // hintText: 'Enter your email or phone',
                          // Here is key idea
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelStyle: const TextStyle(
                            decorationColor: Colors.black,
                            // fontSize: 16,
                            fontFamily: 'SegoeUI',

                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordcontroller,
                        validator: (value) =>
                            value!.isEmpty ? 'enter a valid password' : null,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: true,
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          labelText: 'Password',

                          // hintText: 'Enter your email or phone',
                          // Here is key idea
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelStyle: const TextStyle(
                            decorationColor: Colors.black,
                            // fontSize: 16,
                            fontFamily: 'SegoeUI',

                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .04,
                      ),
                      SizedBox(
                          width: size.width * .6,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7BB3FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                loginViewModel
                                    .loginApi(_emailcontroller.text,
                                        _passwordcontroller.text)
                                    .then((value) {
                                  value == true
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()))
                                      : null;
                                });
                              },
                              child: TextUtils(
                                text: 'SUBMIT',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )))
                    ],
                  ),
                ).frosted(
                  blur: 10,
                  borderRadius: BorderRadius.circular(20),
                  padding: EdgeInsets.all(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
