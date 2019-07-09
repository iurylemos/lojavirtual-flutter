import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  //Para acionar os validadores e quero acessar o formulário
  //Vou utilizar uma variavel global
  //Para utilizar o validate, e acessar o Sistema.
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        //Botão do lado esquerdo
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: "E-mail"
                ),
                keyboardType: TextInputType.emailAddress,
                //Validação do campo email
                validator: (text) {
                  //Se o texto estiver vázio ou se não contem o arroba
                  if(text.isEmpty || !text.contains("@")) return "E-mail invalido!";
                },
              ),
              SizedBox(height: 16.0,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Senha"
                ),
                //Quero que a senha fique obscura, ou seja não veja a senha
                obscureText: true,
                validator: (text) {
                  //Se o texto estiver vázio ou se tem menor do que 6 caracteres
                  if(text.isEmpty || text.length < 6) return "Senha invalida!";
                },
              ),
              //Botão de esqueci a senha, quero alinhar do lado esquerdo
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: () {},
                    child: Text("Esqueci a minha senha",
                    textAlign: TextAlign.right,
                    ),
                  //Retirando o espaço do botão lá no final em branco.
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 7.0,),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text("Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //Se for válido ele entra aqui.
                      if(_formKey.currentState.validate()) {
                        
                      }
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}
