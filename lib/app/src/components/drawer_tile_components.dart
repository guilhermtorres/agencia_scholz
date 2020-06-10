import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60,
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              Icon(
                icon,
                size: 32,
                color: controller.page.round() == page ? Theme.of(context).accentColor : Colors.white,
              ),
              SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: controller.page.round() == page ? Theme.of(context).accentColor : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
