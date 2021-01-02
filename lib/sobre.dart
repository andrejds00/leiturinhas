import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Padding(padding: EdgeInsets.all(10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('App Leiturinhas - Histórias Infantis', style: TextStyle(fontSize: 20),),

      Text('Versão : 1.0'),
      Text('Desenvolvedor : André Jonas'),
      Text('Patrocínio / Investimento : Gerfeson Alves Dantas'),
      SelectableText('Contato : dev.tallentos@gmail.com'),
      SelectableText('Linkedin : linkedin.com/in/andré-jonas-7398177a'),
      ],
    ),
        )

      ),
    );
  }
}
