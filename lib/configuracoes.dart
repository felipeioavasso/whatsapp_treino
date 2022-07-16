import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  const Configuracoes({ Key? key }) : super(key: key);

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  
  // Controles
  final TextEditingController _controllerNome = TextEditingController();
  
  XFile? _imagem;
  String? _idUsuarioLogado;
  String? _urlImagemRecuperada;
  bool _subindoImagem = false;

  Future <dynamic> _recuperarImagem (String origemImagem) async {

    ImagePicker? imagePicker = ImagePicker();
    XFile? imagemSelecionada;

    switch( origemImagem ){
      case 'camera':
        imagemSelecionada = await imagePicker.pickImage(source: ImageSource.camera);
        break;
      case 'galeria':
        imagemSelecionada = await imagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {

      _imagem = imagemSelecionada;
      
      // teste
      if ( _imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });

  }

  Future <dynamic> _uploadImagem() async {

    FirebaseStorage storage = FirebaseStorage.instance;

    var file = File(_imagem!.path);
    
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
    .child('perfil')
    .child( _idUsuarioLogado! + '.jpg');

    // upload da imagem
    UploadTask task = arquivo.putFile(file);

    // Controlar progesso do upload
    task.snapshotEvents.listen((TaskSnapshot storageEvent) {
      if ( storageEvent.state == TaskState.running ) {
        setState(() {
          _subindoImagem = true;
        });
      }else if ( storageEvent.state == TaskState.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    Future<dynamic> _recuperarUrlImagem (TaskSnapshot snapshot) async {
      String url = await snapshot.ref.getDownloadURL();

      // Recupera imagem do banco FF da função _atualizarurlimagemFirestore
      _atualizarUrlImagemFirestore( url );

      setState(() {
        _urlImagemRecuperada = url;
      });
    }
    // recuperar a url da imagem
    task.then((TaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);  
    });
  }

  
  

  Future <dynamic> _atualizarUrlImagemFirestore(dynamic url) async {

    //------------Salvar a URL da Imagem no FirebaseFIRESTORE----------------------
    FirebaseFirestore db = await FirebaseFirestore.instance;

    Map <String, dynamic> dadosAtualizar = {
      'urlImagem': url
    };

    await db.collection('usuarios')
      .doc(_idUsuarioLogado)
      .update( dadosAtualizar );

  }

  Future <dynamic> _atualizarNomeFirestore(String nome) async {

    //------------Salvar a URL da Imagem no FirebaseFIRESTORE----------------------
    //String nome = _controllerNome.text;
    FirebaseFirestore db = await FirebaseFirestore.instance;

    Map <String, dynamic> dadosAtualizar = {
      'nome': nome
    };

    await db.collection('usuarios')
      .doc(_idUsuarioLogado)
      .update( dadosAtualizar );

  }

  Future <dynamic> _salvandoNomeFirestore() async {

    //------------Salvar a URL da Imagem no FirebaseFIRESTORE----------------------
    String nome = _controllerNome.text;
    FirebaseFirestore db = await FirebaseFirestore.instance;

    Map <String, dynamic> dadosAtualizar = {
      'nome': nome
    };

    await db.collection('usuarios')
      .doc(_idUsuarioLogado)
      .update( dadosAtualizar );

  }


  //-----------------------------------------------------------------------------

  Future <dynamic> _recuperarDadosUsuario( dynamic user ) async {
    
    FirebaseAuth auth = await FirebaseAuth.instance;
    user = await auth.currentUser?.uid;

    dynamic usuarioLogado = user;
    _idUsuarioLogado = usuarioLogado;

    FirebaseFirestore db = await FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection('usuarios')
      .doc( _idUsuarioLogado )
      .get();
    
    dynamic dados = await snapshot.data();
      _controllerNome.text = dados['nome'];

    // de Map para Objeto
    if (dados['urlImagem'] != null) {
      setState(() {
        _urlImagemRecuperada = dados['urlImagem'];
        _controllerNome.text = dados['nome'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario(User);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),

      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: _subindoImagem == true
                  ? const CircularProgressIndicator()
                  : Container(),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: 
                  _urlImagemRecuperada !=null
                    ? NetworkImage(_urlImagemRecuperada!)
                    : null,
                  backgroundColor: Colors.grey,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        _recuperarImagem('camera');
                      }, 
                      child: const Text('Câmera')
                    ),
                    ElevatedButton(
                      onPressed: (){
                        _recuperarImagem("galeria");
                      }, 
                      child: const Text('Galeria')
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    onChanged: (texto){
                      _atualizarNomeFirestore(texto);
                    },
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

                // Botão
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _salvandoNomeFirestore();
                    }, 
                    child: const Text(
                      'Salvar',
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
                
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}