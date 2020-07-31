import 'dart:io';
import 'package:agencia_scholz/app/src/components/image_source_sheet_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onImageSelected(File file) {}
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
