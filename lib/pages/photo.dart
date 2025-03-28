import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


import '../datatype/data.dart';
import 'form.dart';

class Photo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyPhoto();

  }

}

class _MyPhoto extends State<Photo> {
  File? imageFile;
  final picker=ImagePicker();
  String downloadURL='';

  Widget mostrarImagen(){
    return imageFile!=null
        ?Image.file(imageFile!, width: 500, height: 500,)
        :Text('Seleccione imagen');
  }

  Future<void>enviarImagen() async{
    if(imageFile==null) return;
    try{
      String nomfoto = DateFormat.yMd().add_Hms().format(DateTime.now());
      String reffoto = 'ciudad/'+nomfoto.replaceAll(RegExp(r'[\/ :]+'),'_');
      firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('$reffoto.png');
      await ref.putFile(imageFile!);
      String url=await ref.getDownloadURL();
      setState(() {
        Data.downloadURL=url;
      });
      print('---------->$Data.downloadURL');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Forms();
      }));
    } catch (e) {
      print("Error al subir la imagen: $e");
    }
  }

  Future<void> showSelectionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Seleccione opción para foto"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: const Text("Galería"),
                      onTap: () {
                        seleccionarImagen(ImageSource.gallery);
                      }),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                      child: const Text("Cámara"),
                      onTap: () {
                        seleccionarImagen(ImageSource.camera);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> seleccionarImagen(ImageSource source) async {
    try {
      final picture = await picker.pickImage(source: source);
      if (picture != null) {
        setState(() {
          imageFile = File(picture.path);
        });
      }
    } catch (e) {
      print("Error al seleccionar imagen: $e");
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: new EdgeInsets.all(30.00)),
            Expanded(
                child: mostrarImagen()
            ),
            const SizedBox(height: 30),
            IconButton(
              onPressed: enviarImagen,
              icon: const Icon(Icons.send, size: 50),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSelectionDialog(context);
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}