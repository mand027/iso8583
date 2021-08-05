import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_app/MensajeElement.dart';

class ParserISO{
  //util
  final dataCharLengths = {1:16, 3:6, 4:12, 7:10, 11:6, 12:6, 13:4, 15:4, 17:4, 18:4, 22:3, 32:11, 35:32, 37:12, 38:6, 39:2, 41:16, 43:40, 44:30, 48:30, 49:3, 60:19, 61:22, 62:13, 63:600};
  var dataMap = {1:"", 3:"", 4:"", 7:"", 11:"", 12:"", 13:"", 15:"", 17:"", 18:"", 22:"", 32:"", 35:"", 37:"", 38:"", 39:"", 41:"", 43:"", 44:"", 48:"", 49:"", 60:"", 61:"", 62:"", 63:""};

  //mensaje completo
  String unParsedMessage;
  bool notISO = false;

  //objetoLocal
  MensajeISO datosGuardados;

  //mensajes parciales
  String iso;
  String header;
  String tipo;
  String bitMap;
  String data;

  void initParse(mensaje){
    datosGuardados = MensajeISO();
    unParsedMessage = mensaje;

    CutMessages();
    if(notISO == false){
      parseHeader();
      parseMTI();
      parseBitMap();
    }
  }

  void CutMessages(){
    iso = unParsedMessage.substring(0, 3);
    if(iso == "ISO"){
      header = unParsedMessage.substring(3, 12);
      tipo = unParsedMessage.substring(12, 16);
      bitMap = unParsedMessage.substring(16,33);
      data = unParsedMessage.substring(34);
    }
    else{
      notISO = true;
    }
  }

  bool Validate(){
    return iso == "ISO";
  }

  void parseHeader(){
    datosGuardados.productIndicator = header.substring(0,2);
    datosGuardados.releaseNumber = header.substring(2,4);
    datosGuardados.status = header.substring(4,7);
    datosGuardados.originatorCode = header.substring(7,8);
    datosGuardados.responderCode = header.substring(8,9);
  }

  void parseMTI(){
    datosGuardados.tipoP1 = tipo.substring(0,2);
    datosGuardados.tipoP2 = tipo.substring(2,4);
  }

  void parseBitMap(){
    List individualHex = List();
    var binary = "";
    bitMap.split('').forEach((ch) => individualHex.add(ch));
    for(int i=0; i<individualHex.length; i++) {
      individualHex[i] = int.parse(individualHex[i],radix: 16).toRadixString(2).padLeft(4,"0");
      binary = binary + (individualHex[i].toString());
    }
    parseData(binary);
  }

  void parseData(binary){
    var offset = 0;
    var howManyToCut = 0;
    var auxString = "";

    List individualBinary = List();
    binary.split('').forEach((ch) => individualBinary.add(ch));

    for(int i=0; i<individualBinary.length; i++) {
      if(individualBinary[i] == "1"){
        print(i+1);
        howManyToCut = dataCharLengths[i+1];

        auxString = data.substring(offset, (offset + howManyToCut - 1));
        print(auxString);
        dataMap[i+1] = auxString;

        offset += howManyToCut -1;
      }
    }
    print(data);
  }

}