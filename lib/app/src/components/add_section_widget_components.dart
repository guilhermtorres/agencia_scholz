import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:flutter/material.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget(this.homeManager);
  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                homeManager.addSection(
                  Section(
                    type: 'List',
                  ),
                );
              },
              textColor: Colors.white,
              child: const FittedBox(
                child: Text(
                  'Adicionar seção Lista',
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                homeManager.addSection(
                  Section(
                    type: 'Staggered',
                  ),
                );
              },
              textColor: Colors.white,
              child: const FittedBox(
                child: Text(
                  'Adicionar seção Grade',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
