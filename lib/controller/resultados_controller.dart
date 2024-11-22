import 'package:flutter/material.dart';
import 'package:totem/model/resultado_model.dart';
import 'package:totem/view/votar_view.dart';

class ResultadosController{
  TextEditingController inputIdTerminal = TextEditingController();
  ResultadoModel resultadoModel = ResultadoModel();

  Future<ResultadoModel> obterResultado() async{
    return await ResultadoModel.obterResultado();
  }

  void iniciarVotacao(context){
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context) => VotarView(idTerminal:  inputIdTerminal.text)));
  } 
}