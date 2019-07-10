import 'package:scoped_model/scoped_model.dart';
/**
 * Importo do scopedModel para valer para toda a aplicação
 * E na minha classe herdo do Model
 * MODEL = É o objeto que vai guardar os estados de alguma coisa.
 * Nesse caso é o estado de LOGIN do APP
 * Ele vai amazernar o usuário atual, e vai ter todas as funções que vão modificar
 * esse usuário atual.
 */


class UserModel extends Model {

  //Usuário atual
  bool estaCarregando = false;

  //Função de Login do usuario
  void deslogar() {

  }

  /**
      Quando eu realizar o login, eu quero que apareça no drawer,
      quero carregar os meus pedidos, e modificar o meu carrinho
      Quero que essa ação faça esse efeito em todos o app.
   */
  void login() async {
    estaCarregando = true;
    /**
     * Quando utilizo o notifyListeners, tudo que estiver dentro
     * do scopedModelDescendent lá no LoginScreen será recriado
     * na tela
     */
    //Falar para o flutter que modifiquei algo, e que ele atualize a view.
    //Ou seja indico para todos o que estou fazendo.
    notifyListeners();

    //Simular processo de login
    //Esperando 3 segundos
    await Future.delayed(Duration(seconds: 3));

    //Vou falar que não estou mais carregando e mostrar na view.
    estaCarregando = false;
    notifyListeners();

  }

  //Resetar Senha
  void resetarSenha() {

  }

  bool verificarUsuarioLogado() {

  }


}