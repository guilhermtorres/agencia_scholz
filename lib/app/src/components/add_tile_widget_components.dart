import 'dart:io';
import 'package:agencia_scholz/app/src/components/image_source_sheet_components.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/data/section_item_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTileWidget extends StatelessWidget {
  const AddTileWidget(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
              context: context,
              builder: (_) => ImageSourceSheet(
                onImageSelected: onImageSelected,
              ),
            );
          } else {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => ImageSourceSheet(
                onImageSelected: onImageSelected,
              ),
            );
          }
        },
        child: Container(
          color: Colors.white.withAlpha(
            80,
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
