import 'package:go_router/go_router.dart';
import 'package:home_furniture_ui/presentation/detail_screen.dart';
import 'package:home_furniture_ui/presentation/home_screen.dart';
import 'package:home_furniture_ui/presentation/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state) => const WelcomeScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
    GoRoute(
      path: '${NamedRoutes.detail.routeName}/:id',
      builder: (ctx, state) => DetailScreen(productId: state.pathParameters['id']!),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  detail('/detail');

  final String routeName;
  const NamedRoutes(this.routeName);
}
