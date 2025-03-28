import 'package:bdatos/pages/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../datatype/data.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos del Clima"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('climaa').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No hay datos disponibles"));
          }
          var climacard = snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return Data(
              doc.id,
              data['ciudad'] ?? '',
              data['temperatura'] ?? '',
              data['condicion'] ?? '',
              data['icon'] ?? '',
              data['imagen'] ?? '',
            );
          }).toList();
          return ListView.builder(
            itemCount: climacard.length,
            itemBuilder: (context, index) {
              var ciudad = climacard[index];
              return Card(
                margin: EdgeInsets.all(7),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Color.fromARGB(100, 209, 196, 233,),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(ciudad.imagen),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    ciudad.Ciudad,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperatura: ${ciudad.Temperatura}'),
                      Text('Condición: ${ciudad.icon} ${ciudad.Condicion}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editarDatos(context, ciudad);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _eliminarDatos(context, ciudad.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Details(data: ciudad);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _eliminarDatos(BuildContext context, String id) async {
    await FirebaseFirestore.instance.collection('climaa').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Datos eliminados correctamente'),
        backgroundColor: Colors.amber,
      ),
    );
  }

  void _editarDatos(BuildContext context, Data data) {
    TextEditingController ciudadController = TextEditingController(text: data.Ciudad);
    TextEditingController temperaturaController = TextEditingController(text: data.Temperatura);
    TextEditingController condicionController = TextEditingController(text: data.Condicion);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Datos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ciudadController,
                decoration: InputDecoration(labelText: 'Ciudad'),
              ),
              TextField(
                controller: temperaturaController,
                decoration: InputDecoration(labelText: 'Temperatura'),
              ),
              TextField(
                controller: condicionController,
                decoration: InputDecoration(labelText: 'Condición'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('climaa')
                    .doc(data.id)
                    .update({
                  'ciudad': ciudadController.text,
                  'temperatura': temperaturaController.text,
                  'condicion': condicionController.text,
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Datos actualizados correctamente'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
