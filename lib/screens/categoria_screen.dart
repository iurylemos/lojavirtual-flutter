import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaScreen extends StatelessWidget {

  /**Construtor que recebe o documento da Categoria
   * Esse documento vai dizer qual o id da categoria e o titulo
   *
   * Vou chamar essa tela aqui lá do Categoria Tile
   */

  final DocumentSnapshot snapshot;

  CategoriaScreen(this.snapshot);


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["titulo"]),
          centerTitle: true,
          //Mostrando as tab disponíveis, se é em grade ou lista
          bottom: TabBar(
            indicatorColor: Colors.white,
              tabs: <Widget> [
                Tab(icon: Icon(Icons.grid_on),),
                Tab(icon: Icon(Icons.list),)
              ],
          ),
        ),
        body: TabBarView(
          //Como não quero que ele fique arrastando para o lado e modificando a tela
          //Utilizo o a fisica.
          physics: NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.red,),
              Container(color: Colors.green,)
            ]
        ),
      ),
    );
  }
}
