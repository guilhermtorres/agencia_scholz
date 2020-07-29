import 'package:agencia_scholz/app/src/components/section_list_components.dart';
import 'package:agencia_scholz/app/src/components/section_staggered_components.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
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
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              expandedHeight: 100,
              backgroundColor: Colors.transparent,
              snap: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Image.asset(
                  'assets/images/Logotipo-4.png',
                  scale: 3,
                  color: Colors.white,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                ),
                Consumer2<UserManager, HomeManager>(builder: (_, userManager, homeManager, __) {
                  if (userManager.adminEnabled) {
                    if (homeManager.editing) {
                      return PopupMenuButton(onSelected: (e) {
                        if (e == 'Salvar') {
                          homeManager.saveEditing();
                        } else {
                          homeManager.discardEditing();
                        }
                      }, itemBuilder: (_) {
                        return ['Salvar', 'Descartar'].map((e) {
                          return PopupMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList();
                      });
                    } else {
                      return IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: homeManager.enterEditing,
                      );
                    }
                  } else {
                    return Container();
                  }
                })
              ],
            ),
            Consumer<HomeManager>(
              builder: (_, homeManager, __) {
                final List<Widget> children = homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section);
                    case 'Staggered':
                      return SectionStaggered(section);
                    default:
                      return Container();
                  }
                }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              },
            ),
            SliverToBoxAdapter(
                child: Container(
              height: 200,
              width: 200,
            )),
          ],
        ),
      ],
    );
  }
}
