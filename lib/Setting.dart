import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'Sharepefrence.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  File? imageFile;

  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    final providerVar = Provider.of<ModelTheme>(context, listen: false);
    providerVar.getPreferences();
    if (providerVar.profileName != null) {
      name.text = providerVar.profileName!;
    }
    if (providerVar.profileBio != null) {
      bio.text = providerVar.profileBio!;
    }
    if (providerVar.ImageFile != '') {
      imageFile = File(providerVar.ImageFile!);
    }
    super.initState();
  }

  getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      setState(() {});
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer<ModelTheme>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Update Profile Data"),
                    trailing: Switch(
                        value: value.isShowProfile,
                        onChanged: (value1) {
                          setState(() {
                            value.isShowProfile == true
                                ? value.isShowProfile = false
                                : value.isShowProfile = true;
                            value1 = value.isShowProfile;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  value.isShowProfile == true
                      ? Container(
                          width: 150,
                          child: Column(
                            children: [
                              value.ImageFile == ''
                                  ? (imageFile != null)
                                      ? Align(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: const Text(
                                                      "Select Image"),
                                                  content: const Text(
                                                      "Add Your Profile Image from Mention Below"),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await getFromGallery();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                          "PICK FROM GALLERY"),
                                                    ),
                                                    Container(
                                                      height: 20.0,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await _getFromCamera();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                          "PICK FROM CAMERA"),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(30),
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.file(
                                                    File(imageFile!.path),
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                ),
                                                //  color: Colors.grey.withOpacity(0.7),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Align(
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: value.isDark
                                                  ? Color(0xff4F378B)
                                                  : Color(0xffEADEFF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              "Select Image"),
                                                          content: const Text(
                                                              "Add Your Profile Image from Mention Below"),
                                                          actions: <Widget>[
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                await getFromGallery();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "PICK FROM GALLERY"),
                                                            ),
                                                            Container(
                                                              height: 20.0,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                await _getFromCamera();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "PICK FROM CAMERA"),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 40,
                                                          color: value.isDark !=
                                                                  true
                                                              ? Color(
                                                                  0xff4F378B)
                                                              : Color(
                                                                  0xffEADEFF),
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                  : Align(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text("Select Image"),
                                              content: const Text(
                                                  "Add Your Profile Image from Mention Below"),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await getFromGallery();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child:
                                                      Text("PICK FROM GALLERY"),
                                                ),
                                                Container(
                                                  height: 20.0,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await _getFromCamera();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child:
                                                      Text("PICK FROM CAMERA"),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(30),
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: Image.file(
                                                File(value.ImageFile!),
                                                fit: BoxFit.cover,
                                              ).image,
                                            ),
                                            //  color: Colors.grey.withOpacity(0.7),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                              Container(
                                width: 130,
                                child: TextField(
                                  controller: name,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your name",
                                      hintStyle: TextStyle(fontSize: 14)),
                                ),
                              ),
                              Container(
                                width: 130,
                                child: TextField(
                                  controller: bio,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: "Enter your bio"),
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        if (imageFile != null) {
                                          value.isImagePath = imageFile?.path;
                                        } else {
                                          value.isImagePath = '';
                                        }

                                        value.isBio = bio.text;
                                        value.isProfile = name.text;
                                      },
                                      child: Text("SAVE")),
                                  TextButton(
                                      onPressed: () {
                                        value.isImagePath = '';
                                        value.isBio = '';
                                        imageFile = null;
                                        name.text = '';
                                        bio.text = '';
                                        value.isProfile = '';
                                      },
                                      child: Text("CLEAR"))
                                ],
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.light_mode_outlined,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Theme",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Change Theme"),
                    trailing: Switch(
                        value: value.isDark,
                        onChanged: (valuex) {
                          setState(() {
                            value.isDark
                                ? value.isDark = false
                                : value.isDark = true;
                            valuex = value.isDark;
                          });
                        }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
