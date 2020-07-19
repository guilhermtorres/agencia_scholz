import 'package:agencia_scholz/app/src/components/section_header_components.dart';
import 'package:agencia_scholz/app/src/components/section_item_tile_components.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:flutter/material.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
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
                return ItemTile(section.items[index]);
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
