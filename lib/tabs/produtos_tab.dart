import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/categoria_tile.dart';

class ProdutosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Como vai ser as informações do banco de dados, coloco o Future.
    return FutureBuilder<QuerySnapshot>(
      //Colocando o futuro e pego os documentos
      future: Firestore.instance.collection("produtos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          //Se ele não carregou os dados ainda
          //Vai ficar um circulo no centro da tela carregando.
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          /** Vou criar essa variavel para divisão de cada campo (Linha)
           * já que é um lista de tiles
           * Quando eu não sei o tipo da variavel, basta eu chama-la de var.
           * E depois puxaar
           */
          var dividerTiles = ListTile.divideTiles(
                  //Pegando cada documento
                  tiles: snapshot.data.documents.map((doc) {
                    //Ele troca um documento por um categoriatile
                    return CategoriaTile(doc);
                  }
                      //E transforma isso em uma lista de volta
                      ).toList(),
                  color: Colors.grey[500])
              .toList();

          //Retorno a lista de categorias.
          return ListView(
            children: dividerTiles,
          );
        }
      },
    );
  }
}
