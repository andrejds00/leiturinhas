import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:leiturinhas/data.dart';
import 'package:leiturinhas/doacao.dart';
import 'package:leiturinhas/sobre.dart';
import 'package:leiturinhas/sugestoes.dart';
import 'package:leiturinhas/target_info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum Opcoes { BUSCAR, CANCELAR }



class _HomeState extends State<Home> {
  List<Book> booksFirebase = new List();
  String pesquisa = null;
// ********************Banner
  @override
  void dispose() {
    myBanner?.dispose();
    //myInterstitial?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-8122823024752023~7798160430");

    startBanner();
    displayBanner();
  }
// ********************Banner
  @override
  Widget build(BuildContext context) {

    //Dialog
    Future buscarLivro() async {
      switch (await showDialog(
          context: context,
          child: new SimpleDialog(
            title: new Text('Qual o livro deseja buscar?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Digite o livro"
                      ),
                      onChanged: (String e){
                        pesquisa = e.toUpperCase();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimpleDialogOption(
                          child: Container(
                            color: Colors.deepOrange,
                            height: 40,
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Restaurar', style: TextStyle(color: Colors.white),)],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              pesquisa = null;
                            });
                            Navigator.pop(context, Opcoes.CANCELAR);
                          },
                        ),
                        SimpleDialogOption(
                          child: Container(
                            color: Colors.blue,
                            height: 40,
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Buscar', style: TextStyle(color: Colors.white),)],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context, Opcoes.BUSCAR);
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )

            ],
          ))) {
        case Opcoes.BUSCAR:
          break;
        case Opcoes.CANCELAR:
          break;
      }
    }

    //AppBar
    final appBar = AppBar(
      title: Image(
        image: AssetImage("images/logo.png"),
        fit: BoxFit.cover,
        width: 120,
        height: 50,
      ),
      elevation: 5,
      backgroundColor: Colors.indigoAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            buscarLivro();
          },
        )
      ],
    );

    //Drawer
    final drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.all(3),
        children: [
          DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                child: Image(
                  image: AssetImage("images/drawer.jpg"),
                  fit: BoxFit.cover,
                ),
              )
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Sobre'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Sobre()));
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_stories),
            title: Text('Sugestões de Livros'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Sugestoes()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Doações'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Doacao()));
            },
          )
        ],
      ),
    );

    ///Capas dos livros
    createTile(Book book) => Hero(
          tag: book.title,
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.yellow.shade900,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'detail/${book.title}');
              },
              child: Image(
                image: NetworkImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

    //Body
    grid() {
      return Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: CustomScrollView(
        primary: false,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid.count(
              childAspectRatio: 2 / 3,
              crossAxisCount: 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              children: booksFirebase.map((book) => createTile(book)).toList(),
            ),
          )
        ],
      ),
      );

    }

    //Estrutura Esqueleto
    return FutureBuilder(
      future: getFirebase(pesquisa),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                )
              ],
            ),
          );
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Erro: ${snapshot.error}'));
          else
            booksFirebase = snapshot.data;
          return Scaffold(
              appBar: appBar,
              drawer: drawer,
              body:
                  grid()); //Aqui você tem a certeza que o Futuro completou e pode acessar o retorno dele com snapshot.data
        }
      },
    );
  }
}

