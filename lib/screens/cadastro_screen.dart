import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {

  //Para acionar os validadores e quero acessar o formulário
  //Vou utilizar uma variavel global
  //Para utilizar o validate, e acessar o Sistema.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Nome Completo"
                ),
                //Validação do campo email
                validator: (text) {
                  //Se o texto estiver vázio
                  if(text.isEmpty) return "Nome inválido!";
                },
              ),
              SizedBox(height: 16.0,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Endereço Completo"
                ),
                //Validação do campo email
                validator: (text) {
                  //Se o texto estiver vázio
                  if(text.isEmpty) return "Endereço inválido!";
                },
              ),
              SizedBox(height: 16.0,),
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
              SizedBox(height: 16.0,),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text("Cadastrar",
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
