import 'dart:convert';

import 'package:http/http.dart' as http;
class VotoModel {
  int? codMsg;
  String? msg;

  VotoModel({this.codMsg, this.msg});

  VotoModel.fromJson(Map<String, dynamic> json) {
    codMsg = json['cod_msg'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod_msg'] = this.codMsg;
    data['msg'] = this.msg;
    return data;
  }

  static Future<VotoModel> votar(idTerminal, opc) async {
    final response =
        await http.post(Uri.parse('https://estevaorada.com/aulas/api/voto/votar.php'), body: {
          "id_terminal" : idTerminal,
          "opc" : opc
        }, headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode == 200) {
      return VotoModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao obter o CEP.');
    }
  }

}