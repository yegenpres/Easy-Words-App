import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

abstract class NetworkClient {
  static String _userId = "";

  static final Dio dio = () {
    final Dio dio = Dio();
    dio.options.headers['authorization'] = _userId;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }();

  Dio get instance => dio;

  static void setUserId(String userId) {
    _userId = userId;
  }

  static final ownWords = () {
    return _OwnWords(dio);
  }();

  static final subscriptions = () {
    return _Subscriptions(dio);
  }();

  static final wordsForChoose = () {
    return _WordsForChoose(dio);
  }();
}

class _WordsForChoose {
  final Dio dio;
  _WordsForChoose(this.dio);

  Future<Uint8List?> fetchImage(ImagedWordable word) async {
    String? base64image;

    try {
      var request = await dio.get<String>(ApiHTTP.fetchImage(word.wordID));
      base64image = request.data?.replaceAll("\"", "");

      assert(base64image != null,
          'Image for for word ${word.wordID} is empty, something with HTTP');
    } catch (e) {
      log(e.toString());
    }

    if (base64image != null) {
      if (base64image.isNotEmpty) return base64Decode(base64image);
      return null;
    }
    return null;
  }

  Future<List> fetch(int count) async {
    List<dynamic> wordsMap = [];

    try {
      var request = await dio.get(ApiHTTP.apiGETforSelect(count));
      wordsMap = request.data;


    } catch (e) {
      lv6(e.toString());
    }

    return wordsMap;
  }

  Future<void> markWordLikeKnown(String wordId) async {
    try {
      await dio.get(ApiHTTP.getMarkKnownWord(wordId));
    } catch (e) {
      log(e.toString());
    }
  }
}

class _Subscriptions {
  final Dio dio;

  _Subscriptions(this.dio);

  Future<bool> sendSubscription() async {
    try {
      var response = await dio.post(ApiHTTP.postSubscribe);

      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int> countFreeDays() async {
    try {
      var response = await dio.get(ApiHTTP.getCountFreeDays);
      return response.data as int;
    } catch (e) {
      return -1;
    }
  }
}

class _OwnWords {
  final Dio dio;

  _OwnWords(this.dio);

  Future<bool> send(Word word) async {
    try {
      await dio.post<Wordable>(ApiHTTP.apiCreatorNewWord(), data: {
        "wordID": int.parse(word.wordID),
        "English": word.english,
        "RUtranslate": word.ruTranscription,
        "EngTranscription": word.engTranscription,
        "Assotiation": word.assotiation,
        "Image": "",
        "SentenceEng": "",
        "SentenceRu": "",
        "IsImaged": false,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Set<String>> fetchParts(String part) async {
    Set<dynamic> words = {};
    Set<String> response = {};

    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var request = await dio.get(ApiHTTP.apiGetWordsParts(part, 100));

      words = request.data.map((e) => e.toString()).toSet();

      response = words.map((e) => e.toString()).map((str) {
        try {
          return str.capitalizeFirst ?? str;
        } catch (e) {
          return str;
        }
      }).toSet();
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<Set<dynamic>> fetchEmptyWords() async {
    Set<dynamic> words = {};

    try {
      var request = await dio.get(ApiHTTP.apiGETEmptyWords);
      List<dynamic> wordsMap = request.data;

      words = wordsMap.toSet();

    } catch (e) {
      log(e.toString());
    }

    return words;
  }
}
