import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'ChatModel.dart';
import 'Sharepefrence.dart';

class IosAddTab extends StatefulWidget {
  const IosAddTab({super.key});

  @override
  State<IosAddTab> createState() => _IosAddTabState();
}

class _IosAddTabState extends State<IosAddTab> {
  String? datetime;
  DateTime? date;
  File? imageFile;
  var uuid = Uuid();

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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.white,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController chat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String defaultTime = DateFormat('dd/mm/yy').format(DateTime.now());
    String dates = date.toString() == "null"
        ? defaultTime
        : "${date!.day}/${date!.month}/${date!.year}";
    String defaultTimer = DateFormat('hh:mm a').format(DateTime.now());
    datetime ?? defaultTimer;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();
    return Consumer<ModelTheme>(
      builder: (context, value, child) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: height - (height - 10),
                  vertical: width - (width - 10)),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  imageFile == null
                      ? Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: value.isDark
                                  ? Color(0xff1E76D3)
                                  : Color(0xff1C76D4),
                              shape: BoxShape.circle),
                          child: Center(
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
                              child: Icon(
                                CupertinoIcons.camera,
                                size: 25,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ))
                      : GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text('Alert'),
                                content: const Text('Get Photo From below?'),
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                    /// This parameter indicates this action is the default,
                                    /// and turns the action's text to bold text.
                                    isDefaultAction: true,
                                    onPressed: () async {
                                      await getFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Gallery'),
                                  ),
                                  CupertinoDialogAction(
                                    /// This parameter indicates the action would perform
                                    /// a destructive action such as deletion, and turns
                                    /// the action's text color to red.
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
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(imageFile!),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoTextFormFieldRow(
                    textInputAction: TextInputAction.next,
                    prefix: Icon(
                      CupertinoIcons.person,
                    ),
                    //controller: FullNameController,

                    controller: name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Your Full Name";
                      } else {
                        return null;
                      }
                    },
                    padding: EdgeInsets.only(left: 20, right: 20),
                    placeholder: "Full Name",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CupertinoTextFormFieldRow(
                    maxLength: 10,
                    prefix: Icon(
                      CupertinoIcons.phone,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: phone,
                    validator: (phonevalue) {
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      if (phonevalue?.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(phonevalue!)) {
                        return 'Please enter valid mobile number';
                      } else if (phonevalue?.length == 11) {
                        return 'Mobile Number must be 10 digits';
                      }
                    },
                    padding: EdgeInsets.only(left: 20, right: 20),
                    placeholder: "Phone Number",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Icon(
                      CupertinoIcons.chat_bubble,
                    ),
                    textInputAction: TextInputAction.done,
                    controller: chat,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Your Chat Conversation";
                      } else {
                        return null;
                      }
                    },
                    padding: EdgeInsets.only(left: 20, right: 20),
                    placeholder: "Chat Conversation",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.calendar_today),
                          SizedBox(width: 8),
                          date.toString() == "null"
                              ? Text(
                                  'Pick Date',
                                  style: const TextStyle(),
                                )
                              : Text("$dates")
                        ],
                      ),
                      onPressed: () {
                        _showDialog(
                          CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                date = newDate;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.time),
                          SizedBox(width: 8),
                          datetime == null
                              ? Text(
                                  'Pick Time',
                                )
                              : Text(datetime.toString()),
                        ],
                      ),
                      onPressed: () {
                        _showDialog(
                          CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            use24hFormat: false,
                            onDateTimeChanged: (DateTime value) {
                              setState(() {
                                datetime = DateFormat('hh:mm a').format(value);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      child: Text("SAVE"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            String defaultTime =
                                DateFormat('dd/MM/yy').format(DateTime.now());
                            String dates = date.toString() == "null"
                                ? defaultTime
                                : "${date!.day}/${date!.month}/${date!.year}";

                            if (datetime.toString() == "null") {
                              datetime =
                                  DateFormat('hh:mm a').format(DateTime.now());
                            }
                            chatmodel.add(ChatModel(
                                id: uuid.v1(),
                                image: imageFile?.path ?? '',
                                name: name.text,
                                phone: phone.text,
                                msg: chat.text,
                                date: dates,
                                time: datetime.toString()));
                            name.clear();
                            phone.clear();
                            chat.clear();
                            date = null;
                            datetime = null;

                            imageFile = null;
                          });
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
