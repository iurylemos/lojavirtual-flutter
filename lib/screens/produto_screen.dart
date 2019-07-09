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

  //Variavel para tamanho que o usuário tiver selecionado da roupa
  String size;

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
              boxFit: BoxFit.cover,
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
                ),
                //Espaçamento entre o preço e o tamanho que vou botar
                SizedBox(height: 16.0,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  //Exibição dos quadados [M] [G] mas não quero colado
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    //Orientação do GridView
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //Separar em uma linha
                          crossAxisCount: 1,
                        //Espaçamento aqui é na horizontal então vou colocar o main
                        mainAxisSpacing: 8.0,
                        //Divisão da altura pela largura
                        childAspectRatio: 0.5
                      ),
                      //Como filho vou pegar o produto, a lista de tamanhos
                      //Que me retorna String vou mapea-la e transformar-la em
                      //outro tipo de lista
                      children: produto.sizes.map(
                          (s) {
                              return GestureDetector(
                                //Quando ele clicar na caixinha o tamanho vai ser o Size
                                onTap: () {
                                  setState(() {
                                    size = s;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    //Os campos são um pouco arredondado.
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                      //Se a cor selecionada for igual a size
                                      //Eu mostro a cor primaria, se não mostro o cinza básico
                                      color: s == size ? primaryColor: Colors.grey[500],
                                      width: 3.0,
                                    )
                                  ),
                                  //Largura do container.
                                  width: 50.0,
                                  //Alinhamento do texto dentro do container
                                  alignment: Alignment.center,
                                  child: Text(s),
                                ),
                              );
                          }
                      ).toList(),
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
