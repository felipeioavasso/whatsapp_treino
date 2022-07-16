/* import 'package:flutter/material.dart';
import 'package:whatsapp_projeto/model/conversa.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  
  List<Conversa> listaConversa = [];
  
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: listaConversa.length,
      
      itemBuilder: (context, indice){

        Conversa conversa = listaConversa[indice];

        return ListTile(
          
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoFoto),
          ),

          title: Text(
            conversa.nome,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),

          subtitle: Text(
            conversa.mensagem,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold
            ),
          
          ),

        );

      },
      
    );
  }
} */