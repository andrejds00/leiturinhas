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
          children: [
          Row(children: [Text('App Leiturinhas - Histórias Infantis', style: TextStyle(fontSize: 20),),],),
      Row(children: [Text('Versão : 1.0'),],),
      Row(children: [Text('Desenvolvimento : Suporte A Tecnologia'),],),
      Row(children: [Text('Desenvolvedor : André Jonas'),],),
      Row(children: [SelectableText('Contato : andrejonasdantas@gmail.com'),],),
            Row(children: [SelectableText('Linkedin : linkedin.com/in/andré-jonas-7398177a'),],),
      ],
    ),
        )

      ),
    );
  }
}
