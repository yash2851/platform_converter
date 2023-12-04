import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'ChatModel.dart';
import 'Sharepefrence.dart';

class AddTab extends StatefulWidget {
  const AddTab({super.key});

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  File? imageFile;

  TimeOfDay? _time;
  var uuid = Uuid();
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

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

  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController chat = TextEditingController();
  late String pickedDate =
      "${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}";
  late String pickedTime =
      "${_time?.hourOfPeriod}:${_time?.minute} ${_time?.period.name.toUpperCase()}";
  @override
  Widget build(BuildContext context) {
    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return Consumer<ModelTheme>(
      builder: (context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    imageFile == null
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: value.isDark
                                    ? Color(0xff4F378B)
                                    : Color(0xffEADEFF),
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
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
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 25,
                                  )),
                            ),
                          )
                        : InkWell(
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
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Full Name";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.call),
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: chat,
                      validator: (chat) {
                        if (chat!.isEmpty) {
                          return "Enter Chat Conversation";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message),
                          hintText: "Chat Conversation",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(0.0)),
                        label: Text(
                          _time != null
                              ? "${_time?.hourOfPeriod}:${_time?.minute} ${_time?.period.name.toUpperCase()}"
                              : 'Pick Time',
                        ),
                        onPressed: _selectTime,
                        icon: Icon(
                          // <-- Icon
                          Icons.access_time_outlined,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(0.0)),
                        label: Text(
                          _selectedDate != null
                              ? "${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}"
                              : 'Pick Date',
                        ),
                        onPressed: _presentDatePicker,
                        icon: Icon(
                          // <-- Icon
                          Icons.calendar_today,
                        ),
                      ),
                    ),

                    // display the selected date

                    TextButton(
                        style: TextButton.styleFrom(
                          //<-- SEE HERE
                          side: BorderSide(
                            width: 1.0,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedDate == null) {
                              pickedDate =
                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                            }
                            if (_time == null) {
                              pickedTime =
                                  "${TimeOfDay.now()?.hourOfPeriod}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name.toUpperCase()}";
                            }

                            setState(() {
                              chatmodel.add(ChatModel(
                                  id: uuid.v1(),
                                  name: name.text,
                                  phone: phone.text,
                                  msg: chat.text,
                                  date: pickedDate,
                                  time: pickedTime,
                                  image: imageFile?.path ?? ''));
                              name.clear();
                              phone.clear();
                              chat.clear();
                              pickedDate = '';
                              pickedTime = '';
                              _time = null;
                              _selectedDate = null;
                              imageFile = null;
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("SAVE"),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
