import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/produto_dado.dart';

class ProdutoTile extends StatelessWidget {

  /**
   * Classe  responsável por exbiri a janela que vai ser os dados do produto.
   */

  //Ele vai receber se é do tipo grid ou do tipo Lista
  final String tipo;
  final ProdutoDado produto;

  ProdutoTile(this.tipo, this.produto);

  @override
  Widget build(BuildContext context) {
    //Quero ser capaz de tocar esse card, então coloco o InkWell
    return InkWell(
      child: Card(
        child: tipo == "grid" ?
          Column(
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
                      Text(produto.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                      ),
                      Text(
                        "R\$ ${produto.preco.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ) : Row(

        ),
      ),

    );
  }
}
