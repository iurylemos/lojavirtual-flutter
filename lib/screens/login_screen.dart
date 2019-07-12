import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/cadastro_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Definindo os controlladores.
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  //Para acionar os validadores e quero acessar o formulário
  //Vou utilizar uma variavel global
  //Para utilizar o validate, e acessar o Sistema.
  final _formKey = GlobalKey<FormState>();

  /*
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
          title: Text("Entrar"),
          centerTitle: true,
          //Botão do lado esquerdo
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                /*
                  Vou botar esse tipo de push, pois quero que quando el
                 * Ele faça login, ele já fique autenticado no Sistema,
                 * E não tenha que fazer login novamente.
                 * E assim ele não vai ter o botão de voltar na app bar.
                 * Pois estou substituindo a tela, e não botando em cima
                 * que é o PUSH
                 */
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CadastroScreen()));
              },
            )
          ],
        ),
        /*
         * Botei o formulário dentro do ScopedModelDescedant
         * Que é uma forma de acessar o Modelo que é o UserModel
         * E quando eu realizar alguma coisa no UserModel
         * Ele vai afetar toda essa parte que está abaixo do ScopedModelDescendant
         * Ou seja ela vai ser reconstruida quando eu utilizar o notifyListeners
         * que está no UserModel, que tem as informações do usuário logado
         * e o que poder ser modificado.
         * E com isso eu tenho acesso ao MODEL = USUARIOLOGADO
         * posso verificar o estado do modelo, e verificar
         * as funções para modificar o estado dele.
         *
         * Sempre que eu quiser ter acesso ao usuário atual
         * basta eu colocar o ScopedModelDescendent, em qualquer
         * lugar do app, que eu vou ter acesso ao usuário Atual.
         */
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.estaCarregando) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      //Validação do campo email
                      validator: (text) {
                        //Se o texto estiver vázio ou se não contem o arroba
                        if (text.isEmpty || !text.contains("@"))
                          return "E-mail invalido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(hintText: "Senha"),
                      //Quero que a senha fique obscura, ou seja não veja a senha
                      obscureText: true,
                      validator: (text) {
                        //Se o texto estiver vázio ou se tem menor do que 6 caracteres
                        if (text.isEmpty || text.length < 6)
                          return "Senha invalida!";
                      },
                    ),
                    //Botão de esqueci a senha, quero alinhar do lado esquerdo
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        /*
                          Ao fazer o login, o firebase já envia um e-mail
                          Para o email a qual foi realizar o cadastro
                          Com o link para redefinição de senha
                        */
                        onPressed: () {
                          //Verificar se o e-mail controller está vázio.
                          if(_emailController.text.isEmpty) {
                            //Se estiver vázio vou exibir uma mensagem
                            //Para avisar que está vázio.
                            //Copiei do onFailed pois já estava criado
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Insira o seu e-mail para recuperação de senha"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else {
                            //Chamando o função que está lá no usermodel
                            model.resetarSenha(_emailController.text);
                            //Caso o e-mail esteja preenchido, vou exbir outra mensagem.
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Confira seu e-mail"),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Esqueci a minha senha",
                          textAlign: TextAlign.right,
                        ),
                        //Retirando o espaço do botão lá no final em branco.
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          //Se for válido ele entra aqui.
                          if (_formKey.currentState.validate()) {}

                          model.login(
                              email: _emailController.text,
                              senha: _senhaController.text,
                              onSucess: _onSucess,
                              onFailed: _onFailed);
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  //Função de login com sucesso
  void _onSucess() {
    //Simplesmente vai mostrar para a pagina anterior e mostrar que está logado.
    Navigator.of(context).pop();
  }

  //Função de falha no login
  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Falha ao entrar!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
