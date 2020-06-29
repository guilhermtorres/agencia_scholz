import 'package:agencia_scholz/app/src/models/page_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  const DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<PageManager>().setPage(page);
        },
        child: Container(
          height: 60,
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 12,
              ),
              Icon(
                icon,
                size: 32,
                color: curPage == page ? Theme.of(context).accentColor : Colors.white,
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: curPage == page ? Theme.of(context).accentColor : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
