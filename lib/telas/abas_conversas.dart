import 'package:flutter/material.dart';
import 'package:whatsapp_projeto/model/conversa.dart';

class AbasConversas extends StatefulWidget {
  const AbasConversas({ Key? key }) : super(key: key);

  @override
  State<AbasConversas> createState() => _AbasConversasState();
}

class _AbasConversasState extends State<AbasConversas> {

  List<Conversa> listaConversas = [
    Conversa(
      "Ana Clara", 
      "Olá, tudo bem?", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-5b098.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=ae40f2cf-e006-4f1a-8e2e-eace3fea8f67",
    ),
    Conversa(
      "João", 
      "Salve!", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-5b098.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=e01f7680-10f2-4ee7-9ec3-0fe8ae7dc7ae",
    ),
    Conversa(
      "Isa", 
      "Oiii", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-5b098.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=66353e91-9618-4842-9b65-21287f9401ec",
    ),
    Conversa(
      "André", 
      "E ai", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-5b098.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=d54fae23-7e82-4d31-8649-512a9a2da865",
    ),
    Conversa(
      "Igor", 
      "Olá, como está o curso?", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-5b098.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=63631fdb-b662-422c-9a04-6cca2cc2f6b1",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, indice){

        Conversa conversa = listaConversas[indice];

        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage( conversa.caminhoFoto ),
          ),
          title: Text(
            conversa.nome, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            conversa.mensagem,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        );
      
      } 
    );
  }
}