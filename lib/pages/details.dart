import 'package:bdatos/datatype/data.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget{
  final Data data;


  Details({
    required this.data
  });

  @override
  State<StatefulWidget> createState(){
    return _MyDetails();
  }
}

class _MyDetails  extends State<Details>{
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    Data data = widget.data;

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          data.Ciudad,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.38),
                    height: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(data.imagen),
                            fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text(
                          'Tempertura:${data.Temperatura}',
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Condicion:${data.Condicion} ${data.icon}',
                        )
                      ],
                    ),

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}