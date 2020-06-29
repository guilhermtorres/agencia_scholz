import 'package:agencia_scholz/app/src/components/custom_drawer_header_components.dart';
import 'package:agencia_scholz/app/src/components/drawer_tile_components.dart';
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
              CustomDrawerHeader(),
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
