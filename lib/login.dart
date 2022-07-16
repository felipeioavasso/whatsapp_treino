import 'package:flutter/material.dart';
import 'package:whatsapp_projeto/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_projeto/model/usuario.dart';


class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = '';

  _validarCampos() async {
    
    // Recuperando dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( email.isNotEmpty && email.contains('@')) {

      if( senha.isNotEmpty ) {
        
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );

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
  }

  _logarUsuario( Usuario usuario ) {

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: usuario.email, 
      password: usuario.senha
    ).then((firebaseUser){

      Navigator.pushReplacementNamed(context, '/home');

    }).catchError((error){
      setState(() {
        _mensagemErro = 'Erro ao autenticar usuário. Verifquei e-mail e senha';
      });
    });

  }

  Future _verificarUsuarioLogado() async {
    
    FirebaseAuth auth = await FirebaseAuth.instance;
    
    //para deslogar
    //auth.signOut();

    User? usuarioLogado = await auth.currentUser;

    if( usuarioLogado != null ) {
       
      Navigator.pushReplacementNamed(context, '/home');
   
    }
  }

  

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff075E54),
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
                    'imagens/logo.png', 
                    width: 200, 
                    height: 150,
                  ),
                ),
                

                // E-Mail
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
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
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: _controllerSenha,
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
                    
                    onPressed: () => _validarCampos(),
                    
                    child: const Text(
                      'Entrar',
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

                // Cadastre-se
                Center(
                  child: GestureDetector(
                    child: const Text(
                      'Não tem conta? Cadastre-se',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const Cadastro()
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20
                      ),
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