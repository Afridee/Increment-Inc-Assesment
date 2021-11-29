import 'package:assesmentbyafridee/Screens/sources/sources.dart';
import 'package:assesmentbyafridee/controllers/search.dart';
import 'package:assesmentbyafridee/functions/lookuptowatchapi.dart';
import 'package:assesmentbyafridee/models/imdbitem.dart';
import 'package:assesmentbyafridee/models/sourcemodel.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SearchTile extends StatelessWidget {

  final ImdbItem item;

  const SearchTile({
    Key? key, required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());
    return InkWell(
      onTap: () async{
        try{
          List<SourceModel> sourcesTemp = [];

          Map<String, dynamic> m = await lookupToWatchAPI(id: item.id);

          m["collection"]["locations"].forEach((element) {
            SourceModel item = SourceModel.fromJson(element);
            sourcesTemp.add(item);
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sources(sources: sourcesTemp),
            ),
          );
        }catch(e){
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Oopsie!',
            desc: "No sources found!!",
          ).show();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                image:  DecorationImage(
                  image: NetworkImage(item.i.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 100,
              width: 80.0,
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: AutoSizeText(
                      item.l,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    width: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item.q,
                    style: const TextStyle(
                        color: textColorGrey,
                        fontWeight: FontWeight.w700,
                        fontSize: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}