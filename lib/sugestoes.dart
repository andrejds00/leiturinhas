import 'package:flutter/material.dart';
import 'package:leiturinhas/data.dart';

class Sugestoes extends StatefulWidget {
  @override
  _SugestoesState createState() => _SugestoesState();
}

class _SugestoesState extends State<Sugestoes> {
  TextEditingController _tituloControlle = TextEditingController();
  TextEditingController _nomeControlle = TextEditingController();
  String enviado = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugestões'),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child:    Form(
                     key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.all(16.0),
                        children: [
                          Text(
                            'Qual livrinho você deseja ler aqui?',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 16,),
                          Text(
                            'Deixe abaixo sua sugestão que iremos trabalhar para incluir.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Titulo do Livro"
                            ),
                           validator: (text){
                              if(text.isEmpty || text == "") return "Titulo inválido!";
                           },
                            controller: _tituloControlle,
                          ),
                          SizedBox(height: 16,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Seu Nome"
                            ),
                            validator: (text){
                              if(text.isEmpty || text == "") return "Seu Nome é inválido!";
                            },
                            controller: _nomeControlle,
                          ),
                          SizedBox(height: 16,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              onPressed: () {
                                if(_formKey.currentState.validate()){
                                  salvarSugestoes(_tituloControlle.text, _nomeControlle.text);
                                  setState(() {
                                    _tituloControlle.clear();
                                    _nomeControlle.clear();
                                    enviado = "Sugestão Enviada com Sucesso! \n Obrigado pela contribuição.";
                                  });
                                }

                              },
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.send),
                                  Text('Enviar')
                                ],
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(enviado, style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),)
                        ],
                      )
                  )),
    );
  }
}
