import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  // Dados fictícios do usuário
  final String userName = 'Nome do Usuário';
  final String userEmail = 'usuario@email.com';
  final String profileImageUrl = 'https://www.example.com/imagem_perfil.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: ListView(
        children: [
          // Cabeçalho do perfil
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // Opções do perfil
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Meus Pedidos'),
            onTap: () {
              // Navegar para a tela de pedidos
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('Carteirinhas'),
            onTap: () {
              // Navegar para a tela de carteirinhas
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              // Navegar para a tela de configurações
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Central de Ajuda'),
            onTap: () {
              // Navegar para a central de ajuda
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              // Implementar lógica de logout
            },
          ),
        ],
      ),
    );
  }
}
