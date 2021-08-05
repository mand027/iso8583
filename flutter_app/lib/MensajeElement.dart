class MensajeISO{
  //Header
  String productIndicator = "";
  String releaseNumber = "";
  String status = "";
  String originatorCode = "";
  String responderCode = "";

  //TipoMensaje
  String tipoP1 = "";
  String tipoP2 = "";

  //Data
  var data = {1:"", 3:"", 4:"", 7:"", 11:"", 12:"", 13:"", 15:"", 17:"", 18:"", 22:"", 32:"", 35:"", 37:"", 38:"", 39:"", 41:"", 43:"", 44:"", 48:"", 49:"", 60:"", 61:"", 62:"", 63:""};

  MensajeISO({this.productIndicator, this.releaseNumber, this.status, this.originatorCode, this.responderCode, this.tipoP1, this.tipoP2, this.data});
}