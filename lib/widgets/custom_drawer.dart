import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  //Botando um construtor para receber o PageController para navegar as outras Páginas
  final PageController pageController;

  CustomDrawer(this.pageController);


  @override
  Widget build(BuildContext context) {

    //Colocando o degradê
    Widget _buidDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            //Gradiente vai ter duas cores, uma forte em cima e mais fraco em baixo
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              //Como ele começa no centro e termina inteiro em baixo
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buidDrawerBack(),
          //Criando o corpo. Como é uma lista vou usar o ListView
          ListView(
            padding: EdgeInsets.only(left: 30.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      //Colocando primeiramente o titulo
                      top: 8.0,
                      left: 0.0,
                      child: Text("Loja Virtual \nde Roupas",
                      style: TextStyle(fontSize:  34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Textos que vão ficar abaixo do header
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                        /**
                         * Coloquei a coluna dentro do ScopedModelDescendant
                         * Por que a unica parte que mudar aqui no Drawer
                         * São esses dois trechos
                         */
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          //Coluna pois um texto vai está em cima do outro
                          return Column(
                            //Para que fique alinhado a esquerda
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Se o usuário não estiver logado eu retorno um texto vázio
                              //Caso contrário retorno o nome dele.
                              Text("Olá, ${!model.verificarUsuarioLogado() ? "" : model.dadosUsuario["nome"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              //Criando o botão
                              GestureDetector(
                                child: Text(
                                  /**
                                   * Aqui vou fazer mais uma expressão lambda
                                   * Se eu não estou logado ele apresenta o cadastre
                                   * Caso contrário
                                   */
                                  !model.verificarUsuarioLogado() ?
                                  "Entre ou cadastre-se >" : "Sair",
                                  style: TextStyle(
                                    //cor primária do main que é o azul do tema
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: () {
                                  if(!model.verificarUsuarioLogado()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen())
                                    );
                                  }else {
                                    model.deslogar();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              /**Vou começar a implantação dos icones das paginas
              E dependendo da pagina que eu estiver, ela vai estar selecionada */
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
