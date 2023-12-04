import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'ChatModel.dart';

class CallTab extends StatelessWidget {
  const CallTab({super.key});

  @override
  Widget build(BuildContext context) {
    return chatmodel.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: chatmodel[index].image == ''
                    ? Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.person,
                          size: 25,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade200),
                      )
                    : Container(
                        height: 50,
                        width: 50,
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
                    Icons.call,
                    size: 40,
                    color: Colors.green,
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
