import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_assign/res/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/response/status.dart';
import '../../view_model/home_view_model.dart';
import '../auth/login_screen.dart';
import 'image_pick_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchImagesListApi();
    super.initState();
  }

  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImagePickOptions(type)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
              color: Color(0xFFdbdee0),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 220, 166, 230).withOpacity(0.2),
                      BlendMode.dstATop),
                  image: AssetImage('assets/images/home.png'),
                  scale: 3,
                  fit: BoxFit.cover)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  right: 25,
                  top: 5,
                  child: Image.asset('assets/images/mina.png')),
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * .05,
                        horizontal: size.width * 0.05),
                    child: TextUtils(
                      text: 'Welcome\nMina',
                      fontSize: 30,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/logoutIcon.png'),
                              SizedBox(
                                width: 15,
                              ),
                              TextUtils(text: 'log out')
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  height: size.height * .3,
                                  width: size.width * .5,
                                  // color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _handleURLButtonPress(
                                                context, ImageSource.gallery);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF2BFE7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/gallery.png',
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                // SizedBox(
                                                //   width: 10,
                                                // ),
                                                TextUtils(
                                                  text: 'Gallery',
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'BalooThambi',
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _handleURLButtonPress(
                                                context, ImageSource.camera);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/camera.png',
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                // SizedBox(
                                                //   width: 10,
                                                // ),
                                                TextUtils(
                                                  text: 'Camera',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'BalooThambi',
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                ).frosted(
                                  blur: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  padding: EdgeInsets.all(8),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/uploadIcon.png'),
                              SizedBox(
                                width: 15,
                              ),
                              TextUtils(text: 'Upload')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * .05),
                    child: ChangeNotifierProvider<HomeViewModel>(
                        create: (BuildContext context) => homeViewModel,
                        child: Consumer<HomeViewModel>(
                            builder: (context, value, _) {
                          switch (value.imagesList.status) {
                            case Status.LOADING:
                              return SizedBox(
                                height: size.height,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            case Status.ERROR:
                              return Text(value.imagesList.toString());
                            case Status.COMPLETED:
                              return value.imagesList.data!.data.images.isEmpty
                                  ? TextUtils(text: 'empty list')
                                  : SizedBox(
                                      height: size.height * .5,
                                      child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: value.imagesList.data!.data
                                            .images.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 4.0,
                                                mainAxisSpacing: 4.0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Image.network(value.imagesList
                                              .data!.data.images[index]);
                                        },
                                      ),
                                    );
                            default:
                              return const Text("Hata");
                          }
                        })),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
