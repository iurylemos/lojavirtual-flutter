import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';

class ProdutoScreen extends StatefulWidget {

  /**
   * Classe responsável por exibir os dados do produto CLICADO no PRODUTOTILE
   */

  //Recebendo o produto aqui em cima
  final ProdutoDado produto;

  ProdutoScreen(this.produto);

  //Passando para o STATE que é o ESTADO
  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  /**
   * Se eu quiser acessar esse produto dentro do meu State
   * basta eu utilizar o widget.produto
   * ou criar um construtor para o State e ele seja igual ao construtor
   * da parte de cima que é o ProdutoScreen
   */
  final ProdutoDado produto;

  //O estado está recebendo o produto e salvando aqui dentro
  _ProdutoScreenState(this.produto);

  @override
  Widget build(BuildContext context) {
    
    return Container();
  }
}
