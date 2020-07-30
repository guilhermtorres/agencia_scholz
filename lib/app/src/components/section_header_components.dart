import 'package:agencia_scholz/app/src/components/custom_icon_button_components.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    if (homeManager.editing) {
      return Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: const InputDecoration(
                hintText: 'Título',
                isDense: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              onChanged: (text) => section.name = text,
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Theme.of(context).accentColor,
            onTap: () {
              homeManager.removeSection(section);
            },
          )
        ],
      );
    } else {
      return Text(
        section.name ?? '',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }
  }
}
