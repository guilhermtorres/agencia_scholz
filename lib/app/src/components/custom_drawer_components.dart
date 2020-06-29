import 'package:agencia_scholz/app/src/components/drawer_tile_components.dart';
import 'package:agencia_scholz/app/src/views/login_views.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer(this.pageController);
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
      elevation: 5,
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 30,
                      child: Image.asset(
                        'assets/images/Logotipo-4.png',
                        scale: 2,
                        color: Colors.white,
                        fit: BoxFit.cover,
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
                          const SizedBox(
                            height: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginViews(),
                                ),
                              );
                            },
                            child: Text(
                              'Entre ou cadastre-se >',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              DrawerTile(Icons.home, 'Início', pageController, 0),
              DrawerTile(Icons.list, 'Produtos e Serviços', pageController, 1),
              DrawerTile(Icons.location_on, 'Onde estamos', pageController, 2),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos', pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
