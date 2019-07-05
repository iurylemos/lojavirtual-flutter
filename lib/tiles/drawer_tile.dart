import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  //Vou criar um construtor, vai receber um icone e um texto.

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    //Vou retornar o Material para dar um efeito visual ao clicar no Item.
    return Material(
      //Definindo a cor do material
      color: Colors.transparent,
      child: InkWell(
        //Quanoo clicar vai cair aqui no onTap e dar efeito
        onTap: () {

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
                color: Colors.black,
              ),
              //Espaço entre o texto e o icone
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
