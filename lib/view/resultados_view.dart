// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:totem/controller/resultados_controller.dart';
import 'package:totem/model/resultado_model.dart';


class ResultadosView extends StatefulWidget {
  const ResultadosView({super.key});

  @override
  State<ResultadosView> createState() => _ResultadosViewState();
}

class _ResultadosViewState extends State<ResultadosView> {


  
  ResultadosController controller = ResultadosController();
  Future<ResultadoModel>? resultados;

  Future<ResultadoModel> carregarDados() async{
    return await controller.obterResultado();
  }

  @override
  void initState() {
    super.initState();
    resultados = carregarDados();
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Resultados')),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                FutureBuilder<ResultadoModel>(
                  future: resultados, 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{
                      return Column(
                        children: [
                          Text('Votos:'),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: DChartBarO(
                                groupList: [
                                  OrdinalGroup(
                                      id: '1',
                                      data: [
                                      OrdinalData(domain: '1 Estrela', measure: snapshot.data!.resultados!.i1 as int),
                                      OrdinalData(domain: '2 Estrelas', measure: snapshot.data!.resultados!.i2 as int),
                                      OrdinalData(domain: '3 Estrelas', measure: snapshot.data!.resultados!.i2 as int),
                                      OrdinalData(domain: '4 Estrelas', measure: snapshot.data!.resultados!.i3 as int),
                                      OrdinalData(domain: '5 Estrelas', measure: snapshot.data!.resultados!.i4 as int),
                                  ],
                                  ),
                              ],
                            ),
                          ),
                          Text('Votos por Terminal:'),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            // https://pub.dev/packages/d_chart
                            child: DChartBarO(
                                groupList: [
                                  OrdinalGroup(
                                      id: '1',
                                      data: [
                                      OrdinalData(domain: 'T5002', measure: snapshot.data!.votosPorTerminal!.t5002 as int),
                                      OrdinalData(domain: 'T5003', measure: snapshot.data!.votosPorTerminal!.t5003 as int),
                                      OrdinalData(domain: 'T5004', measure: snapshot.data!.votosPorTerminal!.t5004 as int),
                                      OrdinalData(domain: 'T5005', measure: snapshot.data!.votosPorTerminal!.t5005 as int),
                                      OrdinalData(domain: 'T5006', measure: snapshot.data!.votosPorTerminal!.t5006 as int),
                                      
                                  ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  ),
                SizedBox(height: 15,),
                Text('Iniciar nova votação:'),
                TextField(
                  controller: controller.inputIdTerminal,
                  decoration: InputDecoration(labelText: "Número do Terminal"),
                ),
                SizedBox(height: 20,),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.iniciarVotacao(context);
                  }, 
                  label: Text("Iniciar Votação") 
                )
              ],
            ),
          ),
          ),
      ),
    );
  }
}
