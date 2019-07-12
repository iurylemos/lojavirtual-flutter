import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/dados/produto_dado.dart';

class ProdutoCart {
  /*
    Classe produto do carrinho.


      Aqui vamos apresentar o ID do produto.

      Pois quero tipo assim, se o cliente amarzenar o produto
      no carrinho, e depois de uns meses ele for querer comprar
      o produto vai estar com o preço atualizado. Pode ser
      mais barato ou mais caro.

  */
  //Esse cartId vai ser gerado pelo banco de dados.
  String cartId;
  //Amarzeno a categoria pois quando for no banco, eu tenho que saber
  //Qual a categoria ele pertence.
  String categoria;
  String produtoId;
  //Quantidade não vai mudar.
  int quantidade;
  //String tamanho.
  String sizes;

  ProdutoCart();

  //Dados do produto.
  ProdutoDado produtoDado;

  ProdutoCart.fromDocument(DocumentSnapshot document) {
    /* Esse documento será um dos produtos que estará armazenado,
      lá no carrinho, lá no banco de dados.
      Ele recebe todos os produtos de um carrinho e transformar cada 
      um em um ProdutoCart.
       */
      cartId = document.documentID;
      categoria = document.data["categoria"];
      produtoId = document.data["produtoId"];
      quantidade = document.data["quantidade"];
      sizes = document.data["sizes"];
  }

  /* Depois que adicionar um produto no carrinho
    Vou ter que adicionar ele lá no banco de dados também
    E para isso tenho que transformar os dados em um mapa.
    . */

  Map<String, dynamic> toMap() {
    return {
      "categoria" : categoria,
      "produtoId" : produtoId,
      "quantidade" : quantidade,
      "sizes" : sizes,
      /* Vou amazenar um resumo também
        Por que no momento que eu for acompanhar o pedido aqui
        Eu quero ficar vendo na tela, o resumo de cada pedido. */
      //"produto": produtoDado.toResumeMap()
    };
  }

}