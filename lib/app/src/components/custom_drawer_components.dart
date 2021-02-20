import 'package:agencia_scholz/app/src/components/custom_drawer_header_components.dart';
import 'package:agencia_scholz/app/src/components/drawer_tile_components.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer();
  Widget _buildDrawerBack() => Container(
        decoration: const BoxDecoration(
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
              const DrawerTile(
                icon: Icons.home,
                text: 'Início',
                page: 0,
              ),
              const DrawerTile(
                icon: Icons.list,
                text: 'Produtos e Serviços',
                page: 1,
              ),
              const DrawerTile(
                icon: Icons.playlist_add_check,
                text: 'Meus Pedidos',
                page: 2,
              ),
              const DrawerTile(
                icon: Icons.location_on,
                text: 'Onde estamos',
                page: 3,
              ),
              Consumer<UserManager>(builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Divider(),
                      const DrawerTile(
                        icon: Icons.supervised_user_circle,
                        text: 'Usuários',
                        page: 4,
                      ),
                      const DrawerTile(
                        icon: Icons.monetization_on,
                        text: 'Pedidos',
                        page: 5,
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}
