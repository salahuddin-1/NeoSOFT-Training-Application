import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_application/src/exceptions/custom_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://staging.php-dev.in:8844/trainingapp/api/";

  final List<int> _responseStatus = [200, 400, 404, 402, 401, 500];

  post(
    String url, {
    required Object body,
    Map<String, String>? headers,
  }) async {
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: body,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    final status = response.statusCode;

    print(status);

    if (_responseStatus.contains(status)) {
      var reponseJson = jsonDecode(response.body);
      print(reponseJson);

      return reponseJson;
    }

    switch (status) {
      case 403:
        throw UnAuthorisedException(
          response.body,
        );

      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : $status',
        );
    }
  }
}
