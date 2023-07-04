import 'dart:convert';
import 'dart:core';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final List<MapEntry> _breedsList = [];

  List<MapEntry> get breedsList => _breedsList;

  Future<List<MapEntry>> getBreeds() async {
    String url = 'https://dog.ceo/api/breeds/list/all';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body.toString());
        final Map breedsMap = data['message'];
        _breedsList.addAll(breedsMap.entries.toList());
      } else {
        Fluttertoast.showToast(msg: "Error Code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    return breedsList;
  }
}

extension CapitalizeExtension on String {
  String capitalizeWords() {
    List<String> words = split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      String capitalizedWord = '${word[0].toUpperCase()}${word.substring(1)}';
      capitalizedWords.add(capitalizedWord);
    }

    return capitalizedWords.join(' ');
  }
}
