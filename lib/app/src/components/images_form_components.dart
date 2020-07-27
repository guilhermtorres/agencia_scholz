import 'dart:io';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'image_source_sheet_components.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
        initialValue: List.from(product.images),
        validator: (images) {
          if (images.isEmpty) return 'Insira ao menos uma imagem';
          return null;
        },
        onSaved: (images) => product.newImages = images,
        builder: (state) {
          void onImageSelected(File file) {
            state.value.add(file);
            state.didChange(state.value);
            Navigator.of(context).pop();
          }

          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.9,
                child: Carousel(
                  images: state.value.map<Widget>((image) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (image is String)
                          Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.file(
                            image as File,
                            fit: BoxFit.cover,
                          ),
                        // IMAGE
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            color: Colors.red,
                            onPressed: () {
                              state.value.remove(image);
                              state.didChange(state.value);
                            },
                          ),
                        )
                      ],
                    );
                  }).toList()
                    ..add(
                      Material(
                        color: Colors.grey[100],
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).accentColor,
                          ),
                          iconSize: 80,
                          onPressed: () {
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
                        ),
                      ),
                    ),
                  dotSize: 5,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotIncreasedColor: Theme.of(context).primaryColor,
                  dotColor: Theme.of(context).accentColor,
                  autoplay: false,
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                )
            ],
          );
        });
  }
}
