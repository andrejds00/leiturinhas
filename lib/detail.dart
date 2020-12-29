import 'package:flutter/services.dart';
import 'package:leiturinhas/preferencias.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'helper/AnotacaoHelper.dart';


class Detail extends StatefulWidget {

  final Book book;

  Detail(this.book);

  @override
  _DetailState createState() => _DetailState(book);
}



double tamanhoLetra = 18.0;

class _DetailState extends State<Detail> {


  final Book book;
   _DetailState(this.book);
   var _db = AnotacaoHelper();
   List<Preferencia> _listPreferencias = List<Preferencia>();
   double _tamanhoSlider = 18;
   int letra = 0xFFFFFFFF, fundo = 0xFF000000;


  void _configPreferencias() async {
    final selectedFontSize = await showDialog<double>(
      context: context,
      builder: (context) => ConfigDialog(initialFontSize: _tamanhoSlider),
    );
    if (selectedFontSize != null) {
      setState(() {
        _tamanhoSlider = selectedFontSize;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    _listarPreferencias();

    //app bar
    final appBar = AppBar(
      elevation: .5,
      title: Text('${book.title}'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.miscellaneous_services),
          onPressed: () {
            _configPreferencias();
          },
        )
      ],
    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.yellow.shade900,
              child: Image(
                image: NetworkImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(book.title,
            color: Colors.white,
            size: 16, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text(
          'Sugerido por: ${book.writer}',
          color: Colors.black54,
          size: 16,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        Row(
          children: <Widget>[
            text('${book.pages}° Livro', color: Colors.black38, size: 12)
            //RatingBar(rating: book.rating)
          ],
        ),
      ],
    );

    final topContent = Container(
      color: Colors.black.withOpacity(0.5),
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Container(
        color: Color(fundo),
        padding: EdgeInsets.all(10),
        child: Text(
          book.description.replaceAll('/n', '\n'),
          style: TextStyle(fontSize: tamanhoLetra, height: 1.5, color: Color(letra)),
        )
    );

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [SingleChildScrollView(
              child: Column(children:[topContent, bottomContent]),
            )
            ],
          ),
        )

    );
  }





  _listarPreferencias() async{


    List preferencias = await _db.listarPreferencias();

    if(preferencias == null || preferencias.isEmpty){
      _salvarPreferencias();
      _listarPreferencias();
    }

    List<Preferencia> listPref = List<Preferencia>();
    for( var item in preferencias ){
      Preferencia p = new Preferencia(item["id"], item["tamanholetra"], item["cortelaleitura"]);

      listPref.add(p);

    }

    setState(() {
      _listPreferencias = listPref;
      int i = _listPreferencias.first.tamanholetra;
      tamanhoLetra = i.toDouble();

      if(_listPreferencias.first.corTelaLeitura == "CorTela.branco"){

        letra = 0xFF000000;
        fundo = 0xFFFFFFFF;
      }else{
        letra = 0xFFFFFFFF;
        fundo = 0xFF000000;
      }

    });

    listPref = null;

  }

  _salvarPreferencias() async{
    Preferencia preferencia = new Preferencia(null, 18, "negro");

    var resultado = await _db.salvarPreferencias(preferencia);
  }

  _atualizarPreferencias(Preferencia preferencia) async{

    var resultado = await _db.atualizarPreferencias(preferencia);
  }

  ///create text widget
  text(String data,
      {Color color = Colors.black87,
        num size = 14,
        EdgeInsetsGeometry padding = EdgeInsets.zero,
        bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );


}



class ConfigDialog extends StatefulWidget {
  /// initial selection for the slider
  final double initialFontSize;

  const ConfigDialog({Key key, this.initialFontSize}) : super(key: key);

  @override
  _ConfigDialogState createState() => _ConfigDialogState();
}


enum CorTela { negro, branco }

class _ConfigDialogState extends State<ConfigDialog> {
  double _fontSize;

  var _db = AnotacaoHelper();

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
  }

  CorTela _character = CorTela.negro;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Configurações"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Definir Tamanho da Letra"),
          Slider(
            value: _fontSize,
            min: 10,
            max: 35,
            divisions: 5,
            onChanged: (value) {
              setState(() {
                _fontSize = value;
              });
            },
          ),
          Text("Cor tela de leitura"),
          RadioListTile<CorTela>(
            title: const Text('Preto'),
            value: CorTela.negro,
            groupValue: _character,
            onChanged: (CorTela value) { setState(() { _character = value; }); },
          ),
          RadioListTile<CorTela>(
            title: const Text('Branco'),
            value: CorTela.branco,
            groupValue: _character,
            onChanged: (CorTela value) { setState(() { _character = value; }); },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){

          tamanhoLetra = _fontSize;

          int i = _fontSize.round();

          Preferencia preferencia = new Preferencia(1, i, _character.toString());
          print("prefe:" + preferencia.corTelaLeitura);

          _atualizarPreferencias(preferencia);


          Navigator.pop(context, _fontSize);

        }, child: Text("Confirmar"))
      ],
    );
  }


  _atualizarPreferencias(Preferencia preferencia) async{

    var resultado = await _db.atualizarPreferencias(preferencia);
  }
}
