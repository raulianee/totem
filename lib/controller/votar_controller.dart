import 'package:totem/model/voto_model.dart';

class VotarController{
  String? opc;
  String? idTerminal;
  VotoModel? resultado;

  Future<VotoModel> votar() async {
    return await VotoModel.votar(idTerminal, opc);
  }


}