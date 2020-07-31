import 'package:agencia_scholz/app/src/components/add_tile_widget_components.dart';
import 'package:agencia_scholz/app/src/components/section_header_components.dart';
import 'package:agencia_scholz/app/src/components/section_item_tile_components.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                if (index < section.items.length) {
                  return ItemTile(section.items[index]);
                } else {
                  return AddTileWidget();
                }
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: homeManager.editing ? section.items.length + 1 : section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
