import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/cadastro_screen.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  /**
   * Como estou utilizando o ScopedModel que vale para toda a aplicação
   * Vou utiliza-lo aqui no Main, pois ele pega o MaterialApp inteiro
   * Tudo que estiver abaixo do ScopedModel vai ter acesso ao UserModel
   * e vai ser modificado caso alguma coisa aconteça no UserModel
   * O MODEL vai conter o estado do login,
   * ou seja vai ter o usuário atual, e a ações que vão modificar esse estado.
   */

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
          title: "Loja Virtual",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            //Cor primaria é a cor da barra e do botão
            primaryColor: Color.fromARGB(255, 4, 125, 141),
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
      ),
    );
  }
}
