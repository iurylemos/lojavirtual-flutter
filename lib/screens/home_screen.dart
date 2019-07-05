import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

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
        //Vou separar os componentes da pagina como se fossem TAB, ou seja GRID
       //Scafold para suportar o navigationDrawler
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )
      ],
    );
  }
}
