import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuariosProviders {
  final String _url = 'http://maines-rest.ddns.net:8080/mainesBack/recursos';

  Future<Map> login(String usuario, String password, String empresa) async {
    final url = '$_url/usuarios/login';

    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usuario:$password'));

    final auth = {'empresa': empresa};

    final resp = await http.post(
      url,
      headers: {'authorization': basicAuth},
      body: json.encode(auth),
    );
    final Map decodedData = json.decode(resp.body);
    return decodedData;
  }
}
