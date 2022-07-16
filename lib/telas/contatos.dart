import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usuario.dart';
import 'dart:async';

class AbaContatos extends StatefulWidget {
  const AbaContatos({ Key? key }) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  
  //String? _idUsuarioLogado;
  String? _emailUsuarioLogado;
  

  Future<List<Usuario>> _recuperarContatos() async {
      
    FirebaseFirestore db = await FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('usuarios').get();

    List<Usuario> listaUsuarios = [];
    

    for ( DocumentSnapshot item in querySnapshot.docs ) {

      Map dadosmap = {};
      var dados = item.data();
      dadosmap = dados as Map;
      debugPrint(_emailUsuarioLogado);

      Usuario usuario = Usuario();

      if ( dados['email'] == _emailUsuarioLogado) continue;
      usuario.email = dados['email'];
      usuario.nome = dados['nome'];
      usuario.urlImagem = dados['urlImagem'];

      listaUsuarios.add(usuario);
    }
    return listaUsuarios;
  }

  _recuperardadosUsuario() async {
    
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;

    _emailUsuarioLogado = usuarioLogado?.email;
  }

  @override
  void initState() {
    _recuperardadosUsuario();
    _recuperarContatos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot){

        switch ( snapshot.connectionState ) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: const <Widget>[
                  Text('Carregando contatos'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData){
              return ListView.builder(

                itemCount: snapshot.data?.length,
                itemBuilder: (_, indice){

                  List<Usuario>? listaItens = snapshot.data;
                  Usuario usuario = listaItens![indice];

                  return ListTile(

                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: 
                      usuario.urlImagem != null
                        ? NetworkImage(usuario.urlImagem!)
                        : null
                    ),

                    title: Text(
                      usuario.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              );
            }else {
              return const Center(
                child: Text('Não há contatos'),
              );
            }
        }
      },
    );
  }
}