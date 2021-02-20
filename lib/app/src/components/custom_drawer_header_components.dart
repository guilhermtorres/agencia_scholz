import 'package:agencia_scholz/app/src/models/page_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Olá, ${userManager.user?.name ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (userManager.isLoggedIn) {
                          context.read<PageManager>().setPage(0);
                          userManager.signOut();
                        } else {
                          Navigator.of(context).pushNamed('/login');
                        }
                      },
                      child: Text(
                        userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
