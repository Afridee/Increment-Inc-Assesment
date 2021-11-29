import 'dart:ui';

import 'package:assesmentbyafridee/models/sourcemodel.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class Sources extends StatefulWidget {

  final List<SourceModel> sources;

  const Sources({Key? key, required this.sources}) : super(key: key);

  @override
  _SourcesState createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          "Links to sources: ",
          textAlign: TextAlign.center,
          style: TextStyle(color: textColorYellow, fontSize: 30),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ListView.builder(
      itemCount: widget.sources.length,
      itemBuilder: (context, index) {
         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListTile(
             trailing: IconButton(
               color: Colors.white,
               onPressed: (){
                 FlutterClipboard.copy(widget.sources[index].url)
                     .then((value) => {
                   AwesomeDialog(
                       padding: EdgeInsets.all(15),
                       context: context,
                       dialogType: DialogType.SUCCES ,
                       animType: AnimType.BOTTOMSLIDE,
                       title: "Link copied!",
                       desc: widget.sources[index].url,
                       btnOkOnPress: () {},
                       btnOkColor: primaryColor)
                     ..show()
                 });
               }, icon: const Icon(Icons.copy),
             ),
             title: Text(widget.sources[index].displayName, style: const TextStyle(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.w700
             ),),
           ),
         );
       },
    )
    );
  }
}
