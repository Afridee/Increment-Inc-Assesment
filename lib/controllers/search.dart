import 'dart:convert';

import 'package:assesmentbyafridee/Screens/sources/sources.dart';
import 'package:assesmentbyafridee/functions/lookuptowatchapi.dart';
import 'package:assesmentbyafridee/functions/searchapi.dart';
import 'package:assesmentbyafridee/models/imdbitem.dart';
import 'package:assesmentbyafridee/models/sourcemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {

  List<ImdbItem> movies = [];
  bool searching = false;
  bool loading = false;
  List<SourceModel> sources = [];

  searchFor(String query) async {
    try {
      if (!searching) {
        searching = true;
        update();

        List<ImdbItem> tempMovies = [];

        Map<String, dynamic> m = await searchAPI(query: query);

        m["d"].forEach((element) {
          ImdbItem item = ImdbItem.fromJson(element);
          tempMovies.add(item);
        });

        movies = tempMovies;

        update();

        searching = false;
        update();
      }
    } catch (e) {
      searching = false;
      update();
    }
  }

}
