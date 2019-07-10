import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  //Definindo os controlladores.
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();




  //Para acionar os validadores e quero acessar o formulário
  //Vou utilizar uma variavel global
  //Para utilizar o validate, e acessar o Sistema.
  final _formKey = GlobalKey<FormState>();


  /**
   * Criando uma chave para que quando o usuário fizer o login
   * Ele apresente uma barra abaixo dizendo que o login ocorreu com sucesso.
   *
   * Para acessar a essa barra, preciso acessar o Scaffold
   *
   */
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        //Para obter acesso ao model, coloquei o ScopedModel aqui
        //Para acesso ao usuário
        body: ScopedModelDescendant<UserModel>(
          builder: (context,child, model) {
            if(model.estaCarregando) {
              return Center(child: CircularProgressIndicator(),);
            }
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nomeController,
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
                      controller: _enderecoController,
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
                      controller: _emailController,
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
                      controller: _senhaController,
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

                            //Crio um mapa com todas as informações
                            //Lembrando que a senha eu só salvo no banco
                            Map<String, dynamic> dadosUsuario = {
                              "nome" : _nomeController.text,
                              "endereco" : _enderecoController.text,
                              "email" : _emailController.text,
                            };

                            model.cadastrar(
                                dadosUsuario: dadosUsuario,
                                senha: _senhaController.text,
                                onSuccess: _onSucess,
                                onFailed: _onFailed
                            );
                          }
                        },
                      ),
                    )
                  ],
                )
            );
          },
        )
    );
  }

  //Função de login com sucesso
  void _onSucess() {
    //Barrinha abaixo informando que o usuário foi criado com sucesso
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 3),
      ),
    );
    //Fechar essa página e ir para a principal
    //Depois de 3 segundos, ele vai chamar a função
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pop();
    });
  }


  //Função de falha no login
  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

}



