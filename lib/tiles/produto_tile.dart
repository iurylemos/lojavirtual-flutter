import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';
import 'package:loja_virtual/screens/produto_screen.dart';

class ProdutoTile extends StatelessWidget {
  /*
   * Classe  responsável por exbiri a janela que vai ser os dados do produto.
   * E mostrar na tela, a GRID ou LISTA dos produtos.
   */

  //Ele vai receber se é do tipo grid ou do tipo Lista
  final String tipo;
  final ProdutoDado produto;

  ProdutoTile(this.tipo, this.produto);

  @override
  Widget build(BuildContext context) {
    //Quero ser capaz de tocar esse card, então coloco o InkWell
    return InkWell(
      //Quando clicar vai redirecionar para a outra página que é sobre o produto clicado
      onTap: () {
        //Nessa função anonima vou chamar a tela onde vou ver o produto e passo o produto
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProdutoScreen(produto))
        );
      },
      child: Card(
        child: tipo == "grid"
            ? Column(
                //Streatch pois os objetos estão esticados
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //Start para os objetos começar logo no topo.
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Colocando a imagem, eu quero que ela fique dentro do AspectRadio definido
                  //Não quero que mude de acordo com cada dispositivo..
                  //AspectRatio é a LARGURA, dividido pela ALTURA
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      produto.imagens[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  //Especificando os meus textos
                  Expanded(
                    //Vou colocar o container para dar um espaço entre o texto e a imagem
                    //E nas bordar laterais e em baixo.
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            produto.titulo,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${produto.preco.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
          //Linha por que é uma lista.
          children: <Widget>[
            //Imagem fica do tamanho que tem do lado
            /**
             * Para não importar o tamanho do dispositivo
             * eu coloco o Flexible, pois quero que ele fique igual dos dois tamanhos
             * não importa o dispositivo, quando eu digo dois tamanho é do tamanho da
             * imagem e do lado do lado dela que preenche a linha
             * e para isso eu coloco dentro do Flexible cada flex com o mesmo tamanho
             */
            Flexible(
              flex: 1,
              child: Image.network(
                produto.imagens[0],
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  //Para alinhar a esquerda, e não centralizado que fica estranho
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      produto.titulo,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${produto.preco.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
