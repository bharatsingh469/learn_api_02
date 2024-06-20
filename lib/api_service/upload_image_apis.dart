import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.escuelajs.co/api/v1/files/upload'));

    var multipartFile = http.MultipartFile(
      'file',
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: fileName,
    );

    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Api hit ho chiki h ji');
      print(response.statusCode);

      var data = await response.stream.bytesToString();

      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print('Api hit ni ho ri h ji');
      return null;
    }
  }
}
