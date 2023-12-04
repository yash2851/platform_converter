import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ChatModel.dart';

class IosChatTab extends StatefulWidget {
  const IosChatTab({super.key});

  @override
  State<IosChatTab> createState() => _IosChatTabState();
}

class _IosChatTabState extends State<IosChatTab> {
  @override
  Widget build(BuildContext context) {
    return chatmodel.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return CupertinoListTile(
                leadingSize: 80,
                onTap: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      message: WillPopScope(
                        onWillPop: () async {
                          return false;
                        },
                        child: SizedBox(
                          height: 300,
                          child: Column(
                            children: [
                              Spacer(),
                              chatmodel[index].image == ''
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      child: Icon(
                                        CupertinoIcons.person,
                                        size: 35,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CupertinoColors.activeGreen),
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
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${chatmodel[index].msg}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.pencil,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    CupertinoIcons.delete_simple,
                                    size: 30,
                                  )
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      cancelButton: CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                  );
                },
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
                trailing:
                    Text("${chatmodel[index].date} ${chatmodel[index].time} "),
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
