import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            //O filho é um texto, mas esse texto vai depender da qnt de produtos
            child: ScopedModelDescendant<CartModel>(

               builder: (context, child, model) {

                //Variavel inteiro p, pois é quantidade de produto do carrinho
                int p = model.produtos.length;

                 return Text(
                   //Se p for nulo, ele me retorna zero,
                   //Caso contrário ele me retorna o valor de p
                   //Ou seja se ele for 1, eu quero ITEM, se for maior
                   //Ele vai em retornar ITENS..
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                 );
               },
             ),
          )
        ],
      ),
    );
  }
}