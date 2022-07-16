import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_projeto/telas/abas_contatos.dart';
import 'package:whatsapp_projeto/telas/abas_conversas.dart';
import 'package:whatsapp_projeto/telas/contatos.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  
  //Lista popup
  List <String> itensMenu = [
    'Configurações',
    'Deslogar',
  ];

  String _emailUsuario = '';

  _recuperarDadosUsuarios() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    User? usuarioLogado = await auth.currentUser;
    
    setState(() {
      _emailUsuario = usuarioLogado!.email!;
    });
  }

  @override
  void initState() {
    super.initState();

    _recuperarDadosUsuarios();

    _tabController = TabController(
      length: 2, 
      vsync: this
    );

  }

  _escolhaMenuItem (String itemEscolhido) {

    switch( itemEscolhido ){
      case 'Configurações':
        return Navigator.pushNamed(context, '/configuracoes');
        
      case 'Deslogar':
        _deslogarUsuario();
        break; 
    }

    //print('Item escolhido: ' + itemEscolhido);

  }

  _deslogarUsuario() async {
    
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, '/login');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('WhatsApp'),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(text: "Conversas",),
            Tab(text: "Contatos",),
          ],
        ),

        actions: [
          PopupMenuButton <String> (
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map( (String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          AbasConversas(),
          //AbaContatos()
          AbaContatos()
        ],
      ),
    );
  }
}