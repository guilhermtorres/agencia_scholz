import 'package:agencia_scholz/app/src/components/add_tile_widget_components.dart';
import 'package:agencia_scholz/app/src/components/section_header_components.dart';
import 'package:agencia_scholz/app/src/components/section_item_tile_components.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            SectionHeader(section),
            const SizedBox(
              height: 10,
            ),
            Consumer<Section>(
              builder: (_, section, __) {
                return StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: homeManager.editing ? section.items.length + 1 : section.items.length,
                  itemBuilder: (_, index) {
                    if (index < section.items.length) {
                      return ItemTile(section.items[index]);
                    } else {
                      return AddTileWidget(section);
                    }
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
