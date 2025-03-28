import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../datatype/data.dart';class Forms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyForms();
  }
}

class _MyForms extends State<Forms>{
  final _controladorCiudad = TextEditingController();
  final _controladorTemperatura = TextEditingController();
  final _controladorCondicion = TextEditingController();
  final _controladorIcon = TextEditingController();
  final _controladorImagen = TextEditingController();
  Data data=Data('','','','','','');

  Future<void> guardarDatos(String ciudad, String temperatura, String condicion, String icon, String imagen) async {
    try{
      await FirebaseFirestore.instance.collection('climaa').add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'ciudad': ciudad,
        'temperatura': temperatura,
        'condicion': condicion,
        'icon': icon,
        'imagen': imagen,
      });
    }catch(e){
      print('Error al guardar datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de clima',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorCiudad,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Ciudad'),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorTemperatura,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Temperatura'),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorCondicion,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Condición'),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorIcon,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Icon (Ejemplo 🥶🥵'),
            ),
            ElevatedButton(
              onPressed: (){
                if(validarCiudad(_controladorCiudad.text)){
                  data.id=DateTime.now().millisecondsSinceEpoch.toString();
                  data.Ciudad=_controladorCiudad.text;
                  data.Temperatura=_controladorTemperatura.text;
                  data.Condicion=_controladorCondicion.text;
                  data.icon=_controladorIcon.text;
                  data.imagen=Data.downloadURL;
                  guardarDatos( data.Ciudad, data.Temperatura, data.Condicion, data.icon, data.imagen)
                      .then((_){
                    Navigator.pop(context);
                  })
                      .catchError((error){
                    alerta(context, 'Error al guardar datos: $error');
                  });

                } else {
                  alerta(context, 'Verifique la informarción ingresada');
                }
              },
              child: Text('Enviar'),
            )
          ],
        ),
      ),
    );
  }
}

//////////
bool validarCiudad(String cadena){
  RegExp exp=RegExp(r'^[a-zA-Z\s]+$');
  if(cadena.isEmpty){
    return false;
  } else if (!exp.hasMatch(cadena)){
    return false;
  } else{
    return true;
  }
}

void alerta(BuildContext context, String mensaje){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta!'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )
          ],
        );
      }
  );
}