import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_cart.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //Classe que cuida sómente do carrinho.
  //E como ela atinge todo o app, vou botar ela como model.

  //Obtendo o usuário atual
  UserModel usuario;

  //Declarar uma lista de CartProduto, que contém os produtos do meu carrinho.
  //Vázio.
  List<ProdutoCart> produtos = [];

  /* E ai, quando eu criar o ProdutoCart, eu vou passar o usuário
  e assim o CartModel vai ter acesso ao usuário atual, e isso é importante
  pois vou amarzenar os produtos do carrinho no usuário atual.
   */
  CartModel(this.usuario);

  //E assim eu posso acessar o CartModel de qualquer parte do aplicativo
  static CartModel of(BuildContext context) {
    return ScopedModel.of<CartModel>(context);
  }

  void addCartItem(ProdutoCart produtoCart) {
    //Adiciono produto ao carrinho
    produtos.add(produtoCart);
    //Adicionando ao banco lá no FireBase.
    //Depois de entrar na coleção dos usuários
    //Vou acessar o documento do usuário
    /* E assim eu estou acessando o userModel (usuário)
    Pegando o fireBaseUSer e o id
    Vou na coleção cart que é o carrinho e adiciono um novo produto
    Que é o documento
    Boto o produtoCart e transformo ele em um mapa com a função toMap
    Ele gera um Id único e vou salvar esse id no cartId
    Para mais para frente eu poder remover também esse produto.
    
    Dentro do then, estou pegando a referência desse documento e crio
    uma função anônima
    
    Pego o cartId e digo que ele é o id do documento
    e salvo ele dentro do produtoCart */

    Firestore.instance.collection("usuarios").document(usuario.firebaseUser.uid).collection("cart").add(produtoCart.toMap()).then((doc){
        produtoCart.cartId = doc.documentID;
    });

    notifyListeners();
  }

  void removerCartItem(ProdutoCart produtoCart) {
      //Deleto o documento do ID do carrinho do usuário
      Firestore.instance.collection("usuarios").document(usuario.firebaseUser.uid)
      .collection("cart").document(produtoCart.cartId).delete();

      produtos.remove(produtoCart);

      notifyListeners();
  }


}