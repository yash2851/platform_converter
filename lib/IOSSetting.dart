import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'Sharepefrence.dart';

class IosSettingTab extends StatefulWidget {
  const IosSettingTab({super.key});

  @override
  State<IosSettingTab> createState() => _IosSettingTabState();
}

class _IosSettingTabState extends State<IosSettingTab> {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  File? imageFile1;

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
      imageFile1 = File(providerVar.ImageFile!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    return Consumer<ModelTheme>(
      builder: (context, value, child) {
        getFromGallery() async {
          var pickedFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          if (pickedFile != null) {
            imageFile1 = File(pickedFile.path);
            //value.isImagePath='';
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
            imageFile1 = File(pickedFile.path);
          }
        }

        return Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CupertinoListTile(
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(CupertinoIcons.person),
              subtitle: Text("Update Profile Data"),
              trailing: CupertinoSwitch(
                  value: value.isShowProfile,
                  onChanged: (valuei) {
                    setState(() {
                      value.isShowProfile = !value.isShowProfile;
                      valuei = value.isShowProfile;
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            value.isShowProfile
                ? Container(
                    width: 200,
                    child: Column(
                      children: [
                        value.ImageFile == ''
                            ? (imageFile1 != null)
                                ? Align(
                                    child: GestureDetector(
                                      onTap: () {
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CupertinoAlertDialog(
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Get Photo From below?'),
                                            actions: <CupertinoDialogAction>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                onPressed: () async {
                                                  await getFromGallery();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Gallery'),
                                              ),
                                              CupertinoDialogAction(
                                                isDestructiveAction: true,
                                                onPressed: () async {
                                                  await _getFromCamera();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Camera'),
                                              ),
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
                                              File(imageFile1!.path),
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
                                        color: CupertinoColors.activeBlue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                              onTap: () {
                                                showCupertinoModalPopup<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CupertinoAlertDialog(
                                                    title: const Text('Alert'),
                                                    content: const Text(
                                                        'Get Photo From below?'),
                                                    actions: <
                                                        CupertinoDialogAction>[
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        onPressed: () async {
                                                          await getFromGallery();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Gallery'),
                                                      ),
                                                      CupertinoDialogAction(
                                                        isDestructiveAction:
                                                            true,
                                                        onPressed: () async {
                                                          await _getFromCamera();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Camera'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    CupertinoIcons.camera,
                                                    size: 40,
                                                    color: CupertinoColors
                                                        .secondarySystemBackground,
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
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                        title: const Text('Alert'),
                                        content:
                                            const Text('Get Photo From below?'),
                                        actions: <CupertinoDialogAction>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            onPressed: () async {
                                              await getFromGallery();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Gallery'),
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            onPressed: () async {
                                              await _getFromCamera();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Camera'),
                                          ),
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
                          width: 170,
                          child: CupertinoTextFormFieldRow(
                            controller: name,
                            // initialValue: value.profileName ?? "",
                            decoration: BoxDecoration(),
                            placeholder: "Enter your name...",
                          ),
                        ),
                        Container(
                          width: 170,
                          child: CupertinoTextFormFieldRow(
                            controller: bio,
                            // initialValue: value.profileName ?? "",
                            decoration: BoxDecoration(),
                            placeholder: "Enter your bio",
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                  onPressed: () {
                                    if (imageFile1 != null) {
                                      value.isImagePath = imageFile1?.path;
                                    } else {
                                      value.isImagePath = '';
                                    }
                                    value.isBio = bio.text;
                                    value.isProfile = name.text;
                                  },
                                  child: Text("SAVE")),
                              CupertinoButton(
                                  onPressed: () {
                                    value.isImagePath = '';
                                    value.isBio = '';
                                    value.isProfile = '';
                                    name.text = '';
                                    bio.text = '';
                                    imageFile1 = null;
                                  },
                                  child: Text("CLEAR"))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            CupertinoListTile(
              leading: Icon(
                CupertinoIcons.sun_max,
              ),
              title: Text(
                "Theme",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Change Theme"),
              trailing: CupertinoSwitch(
                  value: value.isDark,
                  onChanged: (valuex) {
                    setState(() {
                      value.isDark ? value.isDark = false : value.isDark = true;
                      valuex = value.isDark;
                    });
                  }),
            )
          ],
        );
      },
    );
  }
}
