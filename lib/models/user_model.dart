import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/**
 * Importo do scopedModel para valer para toda a aplicação
 * E na minha classe herdo do Model
 * MODEL = É o objeto que vai guardar os estados de alguma coisa.
 * Nesse caso é o estado de LOGIN do APP
 * Ele vai amazernar o usuário atual, e vai ter todas as funções que vão modificar
 * esse usuário atual.
 */


class UserModel extends Model {

  //Declarando o firebaseAuth = Authenticação
  //Estou fazendo isso para não ter que ficar dando FirebaseAuth.instance direto..
  FirebaseAuth _auth = FirebaseAuth.instance;

  /**Usuário atual logado no momento
   * Se não tiver nenhum usuário, ele vai estar null
   * se tiver ele vai conter o ID do usuário e informações básicas
   */
  FirebaseUser firebaseUser;
  //Abrigar dados importantes do usuário
  //Isso vai abrir o nome, email, endereço.
  Map<String, dynamic> dadosUsuario = Map();

  bool estaCarregando = false;

  /**
   * A função carregar usuário vou botar quando iniciar o aplicativo.
   * Verificar se o usuário já logou alguma vez.
   * Aperto CRTL + O
   * E sobrescrevo o metodo addListener
   */


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _carregandoUsuarioAtual();
  }

  /**
   Função de Login do usuario
   Void calback é uma função que vamos passar, e ela vai ser chamada aqui dentro
   Da função.

   Vou colocar todos os parãmetros como opcionais.
   Mas tem um porém, quando eu coloco anotação @required.
   Ela vai dizer para mim que esse paramêtro ao lado é obrigatório
   E assim eu posso exigir quais os campos que são obrigatórios

   E quando eu chamo essa função, ela já autocompleta com os campos.

   */
  void cadastrar({@required Map<String, dynamic> dadosUsuario, @required String senha,
    @required VoidCallback onSuccess, @required VoidCallback onFailed}) {
      estaCarregando = true;
      notifyListeners();

      //Cadatrando o usuário.
      _auth.createUserWithEmailAndPassword(
          email: dadosUsuario["email"],
          password: senha,
        /**Depois que ele processar isso aqui
          ele chama a função que está dentro do THEN
          Como isso me retorna um futuro, vou colocar o then
          Essa função recebe o usuário do FIREBASE */
      ).then((usuario) async {
          /**Se tudo der certo, vou salvar o usuário */
        firebaseUser = usuario;

      //Salvando no firebase, para poder utilizar no futuro.
        await _salvarDadosUsuario(dadosUsuario);

        onSuccess();
        estaCarregando = false;
        notifyListeners();
        //Se tiver usuário com o mesmo email, vou dar um catchError.
      }).catchError((e){
        onFailed();
        estaCarregando = false;
        notifyListeners();
      });
  }

  /**
      Quando eu realizar o login, eu quero que apareça no drawer,
      quero carregar os meus pedidos, e modificar o meu carrinho
      Quero que essa ação faça esse efeito em todos o app.
   */
  void login({@required String email, @required String senha,
    @required VoidCallback onSucess, @required VoidCallback onFailed}) async
  {
    estaCarregando = true;
    /**
     * Quando utilizo o notifyListeners, tudo que estiver dentro
     * do scopedModelDescendent lá no LoginScreen será recriado
     * na tela
     */
    //Falar para o flutter que modifiquei algo, e que ele atualize a view.
    //Ou seja indico para todos o que estou fazendo.
    notifyListeners();

    //Then pois essa função me retorna um futuro.
    _auth.signInWithEmailAndPassword(email: email, password: senha).then(
        (usuario) async {
          //Se entrar aqui é por que deu sucesso com o login do usuário
          //E eu vou salvar ele no firebase.

          //Salvando o usuário
          firebaseUser = usuario;

          //Pegando o metodo que carrega os dados do usuário.
          await _carregandoUsuarioAtual();

          onSucess();
          //Não está mais carregando
          estaCarregando = false;
          notifyListeners();
        }
    ).catchError((e){
        onFailed();
        estaCarregando = false;
        notifyListeners();
    });

  }

  //Resetar Senha
  void resetarSenha(String email) {
      _auth.sendPasswordResetEmail(email: email);
  }

  bool verificarUsuarioLogado() {
    //Se o usuário atual for diferente de nulo, ele vai retonar true
    //indicando que tem um usuário logado
    return firebaseUser != null;
  }

  //Função para deslogar.
  void deslogar() async {
      await _auth.signOut();
      //Resetar os dados do usuário
      dadosUsuario = Map();
      //Usuário deslogado
      firebaseUser = null;
      notifyListeners();
  }



  /**Função para salvar os dados do usuário no Firestore
   * Como essa função vai ser acessada apenas dentro dessa classe
   * Coloquei o anderline_, para saber que ela é uma função da classe.
   */
  Future<Null> _salvarDadosUsuario(Map<String, dynamic> dadosUsuario) async {
    //Passando o dadosUsuario que veio como parâmetro para os dadosUsuario
    this.dadosUsuario = dadosUsuario;
    //Criando uma coleção tabela
    //Crio o documento e digo que vai ter um ID único. boto firebaseUser.uid
    //E seto os dados do usuário.
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(dadosUsuario);
  }

/**
 * Função para pegar os dados do usuário lá no Banco de Dados.
 */

Future<Null> _carregandoUsuarioAtual() async {
    //Verificar se o usuário é nulo
    //Se não temos usuário logado ainda
    if(firebaseUser == null) {
      //Vou pegar o usuário atual
      //Pegando o usuário no Firebase, caso não tenha nenhum logado.
      firebaseUser = await _auth.currentUser();
    }

    //Se tiver usuário logado
    if(firebaseUser != null) {
      //Vou pegar os dados do usuário
      //Se ele tem um nome
      if(dadosUsuario["nome"] == null) {
        //Pegando o documento
        DocumentSnapshot docUsuario =
        await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        //Pegando os dados do documento
        dadosUsuario = docUsuario.data;
      }
    }
    notifyListeners();
}


}