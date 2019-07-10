import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

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
                      //Coluna pois um texto vai está em cima do outro
                      child: Column(
                        //Para que fique alinhado a esquerda
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Olá,",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          //Criando o botão
                          GestureDetector(
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: TextStyle(
                                //cor primária do main que é o azul do tema
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => LoginScreen())
                              );
                            },
                          )
                        ],
                      ),
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
