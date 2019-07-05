import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  //Controlador de paginas, posso utilizar o animateToPage, ou jumpoToPage
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    //Pagina para outra, utiliza PageView
    return PageView(
      controller: _pageController,
      /**Fisica para não permitir arrastar de tela em tela.
       * Vou controlar somente pelo código
       */
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(color: Colors.yellow,),
        Container(color: Colors.red,),
        Container(color: Colors.green,),
      ],
    );
  }
}
