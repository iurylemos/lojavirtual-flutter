import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Colocando o degradê
    Widget _buidDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            //Gradiente vai ter duas cores, uma forte em cima e mais fraco em baixo
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              //Como ele começa no centro e termina inteiro em baixo
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buidDrawerBack(),
          //Criando o corpo. Como é uma lista vou usar o ListView
          ListView(
            padding: EdgeInsets.only(left: 30.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      //Colocando primeiramente o titulo
                      top: 8.0,
                      left: 0.0,
                      child: Text("Loja Virtual \nde Roupas",
                      style: TextStyle(fontSize:  34.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
