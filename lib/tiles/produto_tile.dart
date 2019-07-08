import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';

class ProdutoTile extends StatelessWidget {

  //Ele vai receber se é do tipo grid ou do tipo Lista
  final String tipo;
  final ProdutoDado dado;

  ProdutoTile(this.tipo, this.dado);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
