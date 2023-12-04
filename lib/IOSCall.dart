import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ChatModel.dart';

class iosCallTab extends StatefulWidget {
  const iosCallTab({super.key});

  @override
  State<iosCallTab> createState() => _iosCallTabState();
}

class _iosCallTabState extends State<iosCallTab> {
  @override
  Widget build(BuildContext context) {
    return chatmodel.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return CupertinoListTile(
                leadingSize: 80,
                leading: chatmodel[index].image == ''
                    ? Container(
                        height: 70,
                        width: 70,
                        child: Icon(
                          CupertinoIcons.person,
                          size: 35,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CupertinoColors.activeGreen),
                      )
                    : Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(
                                    File("${chatmodel[index].image}")),
                                fit: BoxFit.cover)),
                      ),
                trailing: GestureDetector(
                  onTap: () async {
                    String telephoneNumber = chatmodel[index].phone;
                    String telephoneUrl = "tel:$telephoneNumber";
                    if (await canLaunch(telephoneUrl)) {
                      await launch(telephoneUrl);
                    } else {
                      throw "Error occured trying to call that number.";
                    }
                  },
                  child: Icon(
                    CupertinoIcons.phone,
                    size: 45,
                  ),
                ),
                title: Text(
                  "${chatmodel[index].name}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "${chatmodel[index].msg}",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: chatmodel.length)
        : Center(
            child: Container(
              child: Text("No any call yet.."),
            ),
          );
  }
}
