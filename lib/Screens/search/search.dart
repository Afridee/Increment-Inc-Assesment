import 'package:assesmentbyafridee/Screens/Authentication/login.dart';
import 'package:assesmentbyafridee/controllers/search.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:assesmentbyafridee/widgets/searchtile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late TextEditingController query;
  final SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    query = TextEditingController();
    query.addListener(() {
      searchController.searchFor(query.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (sc){
      return ModalProgressHUD(
        inAsyncCall: sc.loading,
        child: Container(
          color: primaryColor,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomizedTextField1(hint: "Enter search term..", controller: query, icon: Icons.search, hideText: false, inputType: TextInputType.text),
                ),
                Expanded(
                  child: GetBuilder<SearchController>(
                    builder: (sc){
                      return ListView.builder(
                        itemCount: sc.movies.length,
                        itemBuilder: (context, index) {
                          return SearchTile(item: sc.movies[index]);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
