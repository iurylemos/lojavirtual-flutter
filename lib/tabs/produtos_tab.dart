import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProdutosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Como vai ser as informações do banco de dados, coloco o Future.
    return FutureBuilder<QuerySnapshot> (
        //Colocando o futuro e pego os documentos
        future: Firestore.instance.collection("produtos").getDocuments(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            //Se ele não carregou os dados ainda
            //Vai ficar um circulo no centro da tela carregando.
            return Center(child: CircularProgressIndicator() ,);
          }else {
            //Retorno a lista de categorias.
            return ListView(
              children: <Widget>[

              ],
            )
          }
        } ,
    );
  }
}
