class Preferencia {
  int id;
  int tamanholetra;
  String corTelaLeitura;


  Preferencia(this.id, this.tamanholetra, this.corTelaLeitura);

  Map toMap() {
    Map<String, dynamic> dadosPreferencia = {
      "tamanholetra" : this.tamanholetra,
      "cortelaleitura": this.corTelaLeitura

    };

    if( this.id != null ){
      dadosPreferencia["id"] = this.id;
    }
    return dadosPreferencia;
  }
}
