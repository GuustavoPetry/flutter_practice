import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget{
  final String title;
  final String body;
  final String? data;

  const NotificationDetail({
    super.key,
    required this.title,
    required this.body,
    this.data
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Notificação"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titulo: $title"),
              Text("Mensagem: $body"),
              if(data != null)...[
                Text("Demais Informações: $data")
              ]
            ],
          ),
        )
    );
  }
}