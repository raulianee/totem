import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:status_alert/status_alert.dart';
import 'package:totem/controller/votar_controller.dart';

class VotarView extends StatefulWidget {
  final String idTerminal;
  const VotarView({super.key, required this.idTerminal});

  @override
  State<VotarView> createState() => _VotarViewState();
}

class _VotarViewState extends State<VotarView> {
  @override
  VotarController controller = VotarController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gostou do papazinho?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              EmojiFeedback(
                animDuration: const Duration(milliseconds: 300),
                curve: Curves.bounceIn,
                spaceBetweenItems: 5,
                labelTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                customLabels: [
                  'Ruinzão',
                  'Ruim',
                  'Bão',
                  'Muito bão',
                  'Espetacushow'
                ],
                inactiveElementScale: .5,
                onChanged: (value) async {
                  // Obter o valor do voto e o id do terminal:
                  controller.opc = value.toString();
                  controller.idTerminal = widget.idTerminal;
                  // Realizar a consulta no API:
                  controller.resultado = await controller.votar();

                   StatusAlert.show(
                    context,
                    duration: Duration(seconds: 2),
                    titleOptions: StatusAlertTextConfiguration(style: TextStyle(fontSize: 15)),
                    title: controller.resultado!.msg,
                    subtitle: '',
                    configuration: IconConfiguration(
                      icon: controller.resultado!.codMsg == 1 ? Icons.done : Icons.error),
                    maxWidth: 260,
                  );
                },
              )
          ],),
      ),
    );
  }
}