import 'package:http/http.dart' as http;

class APIRequest {
  String endPoint;
  Map<String, Object> response = Map<String, Object>();

  APIRequest(this.endPoint);

  Map<String, Object> getParams() {
    return null;
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = Map<String, String>();
    headers["Accept"] = "application/json";
    headers["Content-Type"] = "application/json; charset=UTF-8";
    headers["x-api-key"] = "l7xx33adee913ccf436382d0a9433d923667";

    return headers;
  }

  String parseResponse(http.Response response, bool showLog) {
    String retVal = response.body;

    if (showLog) {
      print("API Response: $retVal");
    }

    return retVal;
  }

  String dummyResponse() {
    return "";
  }
}
