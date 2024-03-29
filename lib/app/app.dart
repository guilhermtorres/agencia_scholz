import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/models/admin_orders_manager.dart';
import 'package:agencia_scholz/app/src/models/admin_users_manager.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:agencia_scholz/app/src/models/orders_manager_model.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/views/adress_views.dart';
import 'package:agencia_scholz/app/src/views/cart_views.dart';
import 'package:agencia_scholz/app/src/views/checkout_views.dart';
import 'package:agencia_scholz/app/src/views/confirmation_views.dart';
import 'package:agencia_scholz/app/src/views/edit_product_detail_view.dart';
import 'package:agencia_scholz/app/src/views/home_views.dart';
import 'package:agencia_scholz/app/src/views/create_login_views.dart';
import 'package:agencia_scholz/app/src/views/login_views.dart';
import 'package:agencia_scholz/app/src/views/product_detail_view.dart';
import 'package:agencia_scholz/app/src/views/products_views.dart';
import 'package:agencia_scholz/app/src/views/select_product_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgenciaScholzApp extends StatelessWidget {
  final DocumentSnapshot snapshot;
  const AgenciaScholzApp({this.snapshot});

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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUserManager) => adminUserManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) => ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) => adminOrdersManager..updateAdmin(adminEnabled: userManager.adminEnabled),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home_views':
              return MaterialPageRoute(builder: (_) => HomeViews(snapshot), settings: settings);
            case '/select_product':
              return MaterialPageRoute(
                builder: (_) => SelectProductView(),
              );
            case '/products':
              return MaterialPageRoute(
                builder: (_) => ProductView(snapshot),
                settings: settings,
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginViews(),
              );
            case '/adress':
              return MaterialPageRoute(
                builder: (_) => AdressView(),
              );
            case '/checkout':
              return MaterialPageRoute(
                builder: (_) => CheckoutView(),
              );
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductView(settings.arguments as Product),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductDetailView(settings.arguments as Product),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartView(),
                settings: settings,
              );
            case '/confirmation':
              return MaterialPageRoute(
                builder: (_) => ConfirmationViews(settings.arguments as Order),
              );
            case '/create_login_views':
              return MaterialPageRoute(
                builder: (_) => CreateLoginViews(),
              );
            case '/':
            default:
              return MaterialPageRoute(
                builder: (_) => HomeViews(snapshot),
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
                bodyText2: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.black,
                  fontSize: 16,
                ),
                headline6: const TextStyle(
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
                  headline6: const TextStyle(
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
