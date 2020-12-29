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
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Text('Está gostando do App? Ajude-nos a mantermos o App Ativo!', style: TextStyle(fontSize: 20),),
      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
      SelectableText('Chaves PIX Email: andrejonasdantas@gmail.com',),
            SelectableText('Chaves PIX CPF: 05557284478',),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
     Text('Conta: '),
     SelectableText('BANCO INTER - 077'),
     SelectableText('ANDRE JONAS DANTAS DA SILVA'),
    SelectableText('CPF: 05557284478'),
      SelectableText('Agência: 0001'),
      SelectableText('Conta: 50986775'),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            Text('O seu apoio nos impulsiona a melhorar o app.', style: TextStyle(fontSize: 16),),
      ],
    ),
        )

      ),
    );
  }
}
