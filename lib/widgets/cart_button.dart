import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/cart_screen.dart';

/*
  Aqui vai ser o botão que vai acessar o carrinho.
*/

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      //Quando tocar no botão ele vai abrir a tela do carrinho.
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CartScreen();
            }
          )
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
      );
  }
}