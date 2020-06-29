import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00d856),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              expandedHeight: 100,
              backgroundColor: Colors.transparent,
              snap: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  child: Image.asset(
                    'assets/images/Logotipo-4.png',
                    scale: 3,
                    color: Colors.white,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection('ImagesHome').orderBy('pos').getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      staggeredTiles: snapshot.data.documents.map(
                        (doc) {
                          return StaggeredTile.count(
                            doc.data['x'] as int,
                            doc.data['y'] as num,
                          );
                        },
                      ).toList(),
                      children: snapshot.data.documents.map((doc) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: doc.data['image'] as String,
                          fit: BoxFit.cover,
                        );
                      }).toList());
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
