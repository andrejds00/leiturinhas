
import 'package:leiturinhas/preferencias.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {

  static final String tabelaPreferencias = "preferencias";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database _db;

  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal(){

  }

  get db async {
    if( _db != null ){
      return _db;
    }else{
     _db = await inicializarDB();
     return _db;
    }
  }

  inicializarDB()async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "leiturinhasbd01.db");

    var bd = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersao){
          String sql = "CREATE TABLE $tabelaPreferencias (id INTEGER PRIMARY KEY AUTOINCREMENT, tamanholetra INTEGER, cortelaleitura VARCHAR) ";

          db.execute(sql);
        }
    );
    return bd;
  }

  Future<int> salvarPreferencias(Preferencia preferencia) async{

    var bancoDados = await db;
    int id = await bancoDados.insert(tabelaPreferencias, preferencia.toMap() );
    return id;

  }

  Future<int> atualizarPreferencias(Preferencia preferencia) async{

    var bancoDados = await db;
    int id = await bancoDados.update(tabelaPreferencias, preferencia.toMap() );
    return id;

  }

    listarPreferencias() async{
      var bancoDados = await db;

    //String sql = "SELECT * FROM preferencias ";
    String sql = "SELECT * FROM $tabelaPreferencias WHERE id = 1 ";
    List listPreferencias = await bancoDados.rawQuery(sql);
    return listPreferencias;
  }

}