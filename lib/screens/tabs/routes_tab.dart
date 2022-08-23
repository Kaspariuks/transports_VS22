import 'package:flutter/material.dart';
import 'package:gtfs_db/gtfs_db.dart';

import '../../database/database_service.dart';
import '../../widgets/app_future_loader.dart';

class RoutesTab extends StatelessWidget {
  const RoutesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final database = DatabaseService.get(context);

    return AppFutureBuilder<List<TransitRoute>>(
      future: database.getAllRoutes(),
      builder: (BuildContext context, routes) {
        return ListView.builder(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            return RouteListTile(
              route: routes[index],
            );
          },
        );
      },
    );

    // TODO: Exercise 5
  }
}

class RouteListTile extends StatelessWidget {
  final TransitRoute route;

  const RouteListTile({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final routeNumber = route.route_short_name ?? '';
    final routeColor = route.parsedRouteColor;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: routeColor,
        child: Text(routeNumber),
      ),
      title: Text(route.route_long_name),
      /*onTap: () {
        Navigator.pushNamed(
          context,
          NavigatorRoutes.routeStop,
          arguments: stop,
        );
      },*/
    );
  }
}
