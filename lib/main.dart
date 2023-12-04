import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'Add.dart';
import 'Call.dart';
import 'Chat.dart';
import 'IOSAdd.dart';
import 'IOSCall.dart';
import 'IOSChat.dart';
import 'IOSSetting.dart';
import 'Setting.dart';
import 'Sharepefrence.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAndroid = true;

  bool isShowProfile = true;

  showDialog1(context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select Image"),
        content: const Text("Add Your Profile Image from Mention Below"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await getFromGallery();
              Navigator.of(context).pop();
            },
            child: Text("PICK FROM GALLERY"),
          ),
          Container(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await _getFromCamera();
              Navigator.of(context).pop();
            },
            child: Text("PICK FROM CAMERA"),
          )
        ],
      ),
    );
  }

  File? imageFile;

  getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context1, ModelTheme themeNotifier, child) {
        File? imageFile;

        getFromGallery() async {
          var pickedFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          if (pickedFile != null) {
            setState(() {
              imageFile = File(pickedFile.path);
            });
          }
        }

        _getFromCamera() async {
          var pickedFile = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          if (pickedFile != null) {
            setState(() {
              imageFile = File(pickedFile.path);
            });
          }
        }

        return themeNotifier.isAndroid != true
            ? MaterialApp(
                theme: themeNotifier.isDark
                    ? ThemeData(useMaterial3: true, brightness: Brightness.dark)
                    : ThemeData(
                        useMaterial3: true, brightness: Brightness.light),
                debugShowCheckedModeBanner: false,
                home: SafeArea(
                    child: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: AppBar(
                        elevation: 0.0,
                        title: Text(
                          "Platform Converter",
                        ),
                        bottom: TabBar(
                            labelPadding: EdgeInsets.zero,
                            isScrollable: false,
                            physics: BouncingScrollPhysics(
                                decelerationRate: ScrollDecelerationRate.fast),
                            tabs: [
                              Tab(icon: Icon(Icons.person_add_alt)),
                              Tab(text: "CHATS"),
                              Tab(text: "CALLS"),
                              Tab(text: "SETTINGS"),
                            ]),
                        actions: [
                          Switch(
                              value: themeNotifier.isAndroid,
                              onChanged: (value) {
                                setState(() {
                                  themeNotifier.isAndroid == true
                                      ? themeNotifier.isPlatform = false
                                      : themeNotifier.isPlatform = true;

                                  value = themeNotifier.isAndroid;
                                });
                              })
                        ]),
                    body: TabBarView(
                      children: [
                        AddTab(),
                        ChatTab(),
                        CallTab(),
                        SettingTab(),
                      ],
                    ),
                  ),
                )),
              )
            : CupertinoApp(
                theme: CupertinoThemeData(
                    brightness: themeNotifier.isDark
                        ? Brightness.dark
                        : Brightness.light),
                debugShowCheckedModeBanner: false,
                home: SafeArea(
                  child: CupertinoPageScaffold(
                    backgroundColor: Colors.white,
                    navigationBar: CupertinoNavigationBar(
                      trailing: CupertinoSwitch(
                          value: themeNotifier.isAndroid,
                          onChanged: (value) {
                            setState(() {
                              themeNotifier.isAndroid == true
                                  ? themeNotifier.isPlatform = false
                                  : themeNotifier.isPlatform = true;

                              value = themeNotifier.isAndroid;
                            });
                          }),
                      border: Border(
                          bottom: BorderSide(color: CupertinoColors.white)),
                      middle: Text(
                        "Platform Conveter",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    child: CupertinoTabScaffold(
                      tabBar: CupertinoTabBar(
                        border: Border(
                            top: BorderSide(color: CupertinoColors.white)),
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.person_add),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.chat_bubble_2),
                            label: 'CHATS',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.phone),
                            label: 'CALLS',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.settings),
                            label: 'SETTINGS',
                          ),
                        ],
                      ),
                      tabBuilder: (context, index) {
                        if (index == 0) {
                          return CupertinoTabView(
                            builder: (BuildContext context) {
                              return IosAddTab();
                            },
                          );
                        } else if (index == 1) {
                          return CupertinoTabView(
                            builder: (BuildContext context) {
                              return IosChatTab();
                            },
                          );
                        } else if (index == 2) {
                          return CupertinoTabView(
                            builder: (BuildContext context) {
                              return iosCallTab();
                            },
                          );
                        } else {
                          return CupertinoTabView(
                            builder: (BuildContext context) {
                              return IosSettingTab();
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
