import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/views/cart_views.dart';
import 'package:agencia_scholz/app/src/views/home_views.dart';
import 'package:agencia_scholz/app/src/views/create_login_views.dart';
import 'package:agencia_scholz/app/src/views/login_views.dart';
import 'package:agencia_scholz/app/src/views/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgenciaScholzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/home_views',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home_views':
              return MaterialPageRoute(
                builder: (_) => HomeViews(),
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginViews(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductDetailView(settings.arguments as ProductData),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartView(),
              );
            case '/create_login_views':
              return MaterialPageRoute(
                builder: (_) => CreateLoginViews(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => HomeViews(),
              );
          }
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cursorColor: const Color(0xFF00d856),
          buttonTheme: ButtonThemeData(
            disabledColor: Colors.grey[300],
            buttonColor: const Color(0xFF8C35F1),
          ),
          indicatorColor: Colors.blue,
          accentColor: const Color(0xFF9F56F3),
          hintColor: const Color(0xFF9F56F3),
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF00d856),
          fontFamily: 'Raleway',
          canvasColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText2: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.black,
                  fontSize: 16,
                ),
                headline6: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
          appBarTheme: AppBarTheme(
            elevation: 5,
            color: const Color(0xFF00d856),
            iconTheme: const IconThemeData(
              color: Color(0xFF8C35F1),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
