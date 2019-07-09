import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';
import 'package:carousel_pro/carousel_pro.dart';

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

    /**
     * Como vou utilizar a cor do tema em diversos pontos
     * Que é a cor primária, vou logo obter ela aqui
     */
      final Color primaryColor = Theme.of(context).primaryColor;


    //Scaffold para ter a barra la´no topo
    /**
     * essa daqui é a tela que quando clica em um produto nos camisetas
     * Ela vem para cá, através do construtor que foi para o ESTADO
     * que é esse aqui.
     *
     */
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.titulo),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //Largura dividido pela altura
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              /**No images passamos uma array de imagens
              //Vou passar através do código e mapea-la
              //Essa array de imagens, é uma array de url
              //Vai ter os textos, vai ter os links de onde tem as imagens

                  Resumindo peguei o URL em cada um dos array das imagens
                  E transformei em uma imagem vinda do netWork, transformei em
                  lista no final.
               */

              images: produto.imagens.map((url) {
                return NetworkImage(url);
              }).toList(),
              //DotSize é o tamanho do ponto que tem em baixo da imagem
              //Ou seja para saber qual a imagem que estou
              dotSize: 4.0,
              //Espaçamento entre os pontos, ou seja do tamanho da imagem
              dotSpacing: 15.0,
              //BackGround do ponto
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              //Para as imagens não mudar automaticamente as imagens.
              autoplay: false,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              //Coloquei o stretch para ocupar o máximo de espaço.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  produto.titulo,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  //Definindo quantidade máxima de linhas
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${produto.preco.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ) ,
    );
  }
}
