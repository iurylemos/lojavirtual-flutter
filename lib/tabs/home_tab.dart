import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**Função que retorna um degrade, que é uma imagem antes da pag antes
     * de ser carregada, ou seja ela é um back antes do que vai ter em cima
     * que é o stack
     * Retorna um container
     */
    Widget _buidBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  //Gradiente vai ter duas cores, uma forte em cima e mais fraco em baixo
                  colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168)
              ],
                  //Dizendo o fim do gradiente
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight)),
        );

    //Stack pois quero colocar um conteudo acima do meu fundo(DEGRADE)
    return Stack(
      children: <Widget>[
        _buidBodyBack(),
        //Colocando em cima do fundo abaixo..
        CustomScrollView(
          /**Vou colocar um Appbar que fica em cima do meu conteudo
           * Ou seja ela não é fixa
           */
          slivers: <Widget>[
            SliverAppBar(
              //Ela vai ser flutuante
              floating: true,
              //snap, é quando ele abaixa a lista a barra soma
              //mas quando sobe um pouco ela aparece novamente
              snap: true,
              backgroundColor: Colors.transparent,
              //Não quero que a barra fique elevada, quero no mesmo plano do conteudo
              elevation: 0.0,
              //Espaço fléxivel
              flexibleSpace: FlexibleSpaceBar(
                //Coloquei constante para que ele saiba que sempre vai ter o mesmo valor
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            /**Botendo os dados do firebase, como ele não é instantaniamente
             * Utilizo o FutureBuilder, pois vou mostrar na tela que está carregando.
             */
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("home")
                  .orderBy("pos")
                  .getDocuments(),
              /** builder é a função que vai criar o que vai ter na tela
               * dependendo do que o meu future trazer.
               */
              builder: (context, snapshot) {
                //Se o snapshot não possui dado
                if(!snapshot.hasData) {
                  //Como estou dentro do Sliver não posso colocar simplesmente o CircleProssessIndicator
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        //Vou botar a cor branca nele
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                  //Caso eu tenha algum DADO
                } else {
                  print(snapshot.data.documents.length);
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Container()
                    ),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
