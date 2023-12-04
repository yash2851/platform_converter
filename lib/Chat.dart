import 'dart:io';

import 'package:flutter/material.dart';

import '../ChatModel.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    {
      return chatmodel.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          child: SizedBox(
                            height: 350,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(),
                                  chatmodel[index].image == ''
                                      ? Container(
                                          height: 100,
                                          width: 100,
                                          child: Icon(
                                            Icons.person,
                                            size: 35,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.purple.shade200),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: FileImage(File(
                                                      "${chatmodel[index].image}")),
                                                  fit: BoxFit.cover)),
                                        ),
                                  Text(
                                    "${chatmodel[index].name}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${chatmodel[index].msg}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.delete,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                    style: TextButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          onWillPop: () async {
                            return false;
                          },
                        );
                      },
                    );
                  },
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
                  trailing: Text(
                      "${chatmodel[index].date} ${chatmodel[index].time} "),
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
}
