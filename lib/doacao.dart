import 'package:flutter/material.dart';

class Doacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doações'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Padding(padding: EdgeInsets.all(10),
         child: Column(
          children: [
         Text('Está gostando do App? Ajude-nos a mantermos o App Ativo!', style: TextStyle(fontSize: 20),),
      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
      Row(children: [SelectableText('Chaves PIX Email: andrejonasdantas@gmail.com',),],),
            Row(children: [SelectableText('Chaves PIX CPF: 05557284478',),],),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
      Row(children: [Text('Conta: '),],),
      Row(children: [SelectableText('BANCO INTER - 077'),],),
            Row(children: [SelectableText('ANDRE JONAS DANTAS DA SILVA'),],),
            Row(children: [SelectableText('CPF: 05557284478'),],),
            Row(children: [SelectableText('Agência: 0001'),],),
            Row(children: [SelectableText('Conta: 50986775'),],),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            Text('O seu apoio nos impulsiona a melhorar o app.', style: TextStyle(fontSize: 16),),
      ],
    ),
        )

      ),
    );
  }
}
