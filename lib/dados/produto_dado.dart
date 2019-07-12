import 'package:cloud_firestore/cloud_firestore.dart';

/**
    Classe para amazernar os dados do meu produto
 */

class ProdutoDado {

  //Categoria pertencente
  String categoria;

  String id;

  String titulo;
  String descricao;

  double preco;

  List imagens;
  List sizes;

/**
 * É importante saber que eu vou pegar os dados do firebase e transformar nesses dados
 */

  ProdutoDado.fromDocument(DocumentSnapshot snapshot) {
    //Pegando o id
    id = snapshot.documentID;
    titulo = snapshot.data["titulo"];
    descricao = snapshot.data["descricao"];
    preco = snapshot.data["preco"] + 0.0;
    imagens = snapshot.data["imagens"];
    sizes = snapshot.data["sizes"];
  }

  //Função para mostrar o resumo de cada produto que vai ter no carrinho
  Map<String, dynamic> toResumeMap() {
    /*Aqui vou retornar apenas as coisas importantes que quero
    Apresentar na tela. */

    return {
      "titulo": titulo,
      "descricao" : descricao,
      "preco" : preco
    };
  }

}