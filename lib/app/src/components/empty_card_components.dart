import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({this.title, this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 80,
                color: Theme.of(context).accentColor,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
