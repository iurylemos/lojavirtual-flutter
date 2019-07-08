import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';
import 'package:loja_virtual/tiles/produto_tile.dart';

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
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("produtos").document(snapshot.documentID)
            .collection("items").getDocuments(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    //Builder pois quero que ele me retorne uma grande quantidade de prod
                    GridView.builder(
                      padding: EdgeInsets.all(4.0),
                        //Quantos itens eu vou ter na horizontal e espaçamento
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //Quantidade de itens na horizontal
                          crossAxisCount: 2,
                          //Espaçamento
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          /**
                           * Dentro do construtor do ProdutoTile, eu quero especificar que vai ser do tipo grid
                           * E ele vai ter os dados do produto, eu não vou passar os produtos no
                           * formato de snapshot, eu vou passar no formato de ProdutoDado
                           *
                           * Pegando cada um dos documentos com o index, que é o indice
                           *  e transformando esse documento em um objeto ProdutoDado
                           *  E dessa forma vamos conseguir gerenciar os dados de forma mais simples,
                           *  e estou passando esse produtoDado para o produtoTile
                           *
                           *  Estou fazendo essa conversão, por que se futuramente eu quiser
                           *  trocar no firebase para outro banco de dados online, eu não precise
                           *  alterar otodo esse código aqui, unico que eu vou ter que alterar
                           *  é o produtoData.
                           *
                           *  Fica melhor a manutenção.
                           *
                           *
                           */
                            return ProdutoTile("grid", ProdutoDado.fromDocument(snapshot.data.documents[index]));
                        }
                    ),
                    //Criando a lista, se não é do tipo grid, é do tipo lista.
                    ListView.builder(
                        padding: EdgeInsets.all(4.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ProdutoTile("list", ProdutoDado.fromDocument(snapshot.data.documents[index]));
                        }

                    ),
                  ],
                );
              }
            }
        )
      ),
    );
  }
}
