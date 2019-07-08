import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  //Vou criar um construtor, vai receber um icone e um texto.
  //O controllador das paginas que está no homeScreen
  //E a pagina referente.

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    //Vou retornar o Material para dar um efeito visual ao clicar no Item.
    return Material(
      //Definindo a cor do material
      color: Colors.transparent,
      child: InkWell(
        //Quanoo clicar vai cair aqui no onTap e dar efeito
        onTap: () {
          //Fechando o Drawer
          Navigator.of(context).pop();
          //Pulando para a pagina correspondente
          controller.jumpToPage(page);
        },
        child: Container(
          //Coloquei o Container apenas para especificar a altura dos icones
          height: 60.0,
          //Como vou ter um icone e o texto coloco uma linha
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                //Vou fazer a validação, pois quero que a cor que vai vir, dependa
                //da cor que ele vai está
                //Ou seja se for igual a cor odo meu tile
                //Se for igual eu vou colocar a cor do meu tema do aplicativo
                /**
                 * Se a pagina atual do meu item for igual a pagina do controlador
                 * Ele vai colocar a cor azul do tema, ou vai colocar o cinza
                 * Já que ele retorna um double, mas o page é um int
                 * Vou colocar um macete que é o round no final
                 * Que ele arredonda o valor, que fica int
                 */
                color: controller.page.round() == page ?
                 Theme.of(context).primaryColor : Colors.grey[700],
              ),
              //Espaço entre o texto e o icone
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
