import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/categoria_screen.dart';

class CategoriaTile extends StatelessWidget {

  /*
    Essa classe vai receber o documento que obtive do Banco de dados
   * Ele vai pegar os dados que são o nome da categoria e o icone da categoria
   */

  final DocumentSnapshot snapshot;

  CategoriaTile(this.snapshot);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      //Leading é o icone que fica do lado esquerdo
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["titulo"]),
      //Setinha do lado esquerdo é o trailing
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        /**
         * Aqui dentro eu passo o documento para a próxima tela de amostra
         * que é o CategoriaScreen
         */
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoriaScreen(snapshot))
          );
      },
    );
  }
}
