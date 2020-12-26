class Preferencia {
  int id;
  int tamanholetra;


  Preferencia(this.id, this.tamanholetra);

  Map toMap() {
    Map<String, dynamic> dadosPreferencia = {
      "tamanholetra" : this.tamanholetra,

    };

    if( this.id != null ){
      dadosPreferencia["id"] = this.id;
    }
    return dadosPreferencia;
  }
}
