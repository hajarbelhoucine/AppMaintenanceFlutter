import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _url = 'https://digitalmobile.herokuapp.com/api';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  authData(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  Future<List> getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    http.Response response =  await http.get(
        fullUrl,
        headers: _setHeaders()
    );

    return json.decode(response.body);
  }
  getGraph(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    http.Response response =  await http.get(
        fullUrl,
        headers: _setHeaders()
    );

    return json.decode(response.body);

  }


  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}