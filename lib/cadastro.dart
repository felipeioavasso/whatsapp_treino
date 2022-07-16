import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_projeto/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({ Key? key }) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  // Conroladores
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = '';


  _validarCampos() async {
    
    // Recuperando dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( nome.isNotEmpty && nome.length > 3) {

      if( email.isNotEmpty && email.contains('@')) {
        if( senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _mensagemErro = '';
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario( usuario );

        }else{
          setState(() {
            _mensagemErro = 'Preencha a senha';
          });
        }
      }else{
        setState(() {
          _mensagemErro = 'Preencha o E-mail usando o @';
        });
      }

    }else{
      setState(() {
        _mensagemErro = 'Preencha o nome';
      });
    }


  }

  _cadastrarUsuario(Usuario usuario) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: usuario.email, 
      password: usuario.senha
    ).then((firebaseUser) {
      
      // Salvando os dados do usuario
     FirebaseFirestore db = FirebaseFirestore.instance;

     db.collection('usuarios')
     .doc( firebaseUser.user?.uid )
     .set( usuario.toMap() );


      // Enviando para a tela home
        
      Navigator.pushNamedAndRemoveUntil(
        context, '/home', (_) => false
      );
        
    }).catchError((error){
      setState(() {
        _mensagemErro = 'Erro ao cadastrar usuário. Verifique os campos e tente novamente'; 
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: const Text('Cadastro'),
      ),



      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                

                // LOGO
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'imagens/usuario.png', 
                    width: 200, 
                    height: 150,
                  ),
                ),
                

                // Nome
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      )
                    ),
                  ),
                ),

                // E-Mail
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      )
                    ),
                  ),
                ),

                // Senha
                TextField(
                  controller: _controllerSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    )
                  ),
                ),

                // Botão
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    }, 
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white, fontSize: 20
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    _mensagemErro,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20
                    ),
                  ),
                ),
                



              ],
            ),
          ),
        ),
      ),
    );
  }
}