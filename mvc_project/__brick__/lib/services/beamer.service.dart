import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lifecycle/lifecycle.dart' show defaultLifecycleObserver;

class BeamerService {
  static void pop(BuildContext context) {
    if (Beamer.of(context).canBeamBack) {
      Beamer.of(context).beamBack();
    } else {
      Navigator.pop(context);
    }
  }

  static void push(
      {required BuildContext context,
      required String route,
      Object? data,
      bool replaceRoute = false}) {
    if (replaceRoute) {
      Beamer.of(context)
          .beamToReplacementNamed(route, data: data, stacked: false);
    } else {
      Beamer.of(context).beamToNamed(
        route,
        data: data,
      );
    }
  }

  static BeamPageType _getPageTransation() {
    if (kIsWeb) {
      return BeamPageType.noTransition;
    }
    return BeamPageType.material;
  }

  static final routerDelegate = BeamerDelegate(
    navigatorObservers: [HeroController(), defaultLifecycleObserver],
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // '/': (context, state, data) {
        //   return BeamPage(
        //     type: _getPageTransation(),
        //     key: ValueKey('home'),
        //     title: 'Kafarat Plus',
        //     child: HomePage(),
        //   );
        // },
        // '/category/:categoryId': (context, state, data) {
        //   final mainCategory = (data != null)
        //       ? ((data as Map<String, dynamic>)['category'] != null)
        //           ? (data['category'] as cat.Category)
        //           : null
        //       : null;
        //   final categoryId = state.pathParameters['categoryId'];
        //   return BeamPage(
        //     type: _getPageTransation(),
        //     key: const ValueKey('product'),
        //     title: 'Kafarat Plus',
        //     child: ProductsPage(
        //       categoryId: categoryId,
        //       category: mainCategory,
        //     ),
        //   );
        // },

        // '/category/:categoryId/product/:productId': (context, state, data) {
        //   final controller = (data != null)
        //       ? ((data as Map<String, dynamic>)['controller'] != null)
        //           ? (data['controller'] as ProductsController?)
        //           : null
        //       : null;

        //   final categoryId = state.pathParameters['categoryId'];
        //   final productId = state.pathParameters['productId'];
        //   return BeamPage(
        //     type: _getPageTransation(),
        //     key: const ValueKey('productDetails'),
        //     title: 'Kafarat Plus',
        //     child: SingleProductPage(
        //       controller: controller,
        //       categoryId: categoryId,
        //       productId: productId,
        //     ),
        //   );
        // },
        // 'product/:productId': (context, state, data) {
        //   final productId = state.pathParameters['productId'];
        //   return BeamPage(
        //     type: _getPageTransation(),
        //     key: const ValueKey('productDetails'),
        //     title: 'Kafarat Plus',
        //     child: SingleProductPage(
        //       productId: productId,
        //     ),
        //   );
        // },
      },
    ),
  );
}
