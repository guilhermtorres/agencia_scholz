import 'package:agencia_scholz/app/src/views/initial_tab_views.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[HomeTab()],
    );
  }
}
