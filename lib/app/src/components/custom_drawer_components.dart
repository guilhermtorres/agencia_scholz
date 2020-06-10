import 'package:agencia_scholz/app/src/components/drawer_tile_components.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF00d856),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 30,
                      child: Container(
                        child: Image.asset(
                          'assets/images/Logotipo-4.png',
                          scale: 2,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Olá,',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          GestureDetector(
                            child: Text(
                              'Entre ou Cadastre-se >',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              DrawerTile(Icons.home, 'Início'),
              DrawerTile(Icons.list, 'Produtos e Serviços'),
              DrawerTile(Icons.location_on, 'Onde estamos'),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos'),
            ],
          ),
        ],
      ),
      elevation: 5,
    );
  }
}
