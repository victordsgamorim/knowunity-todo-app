import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knowunity_todo_app/core/route/route_path.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:knowunity_todo_app/feature/pages/login_page.dart';
import 'package:knowunity_todo_app/feature/pages/splash_page.dart';

import '../../feature/pages/task_page.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    CupertinoTransitionGoRouter(
      path: RoutePath.login,
      builder: (state) => const LoginPage(),
    ),
    CupertinoTransitionGoRouter(
      path: RoutePath.task,
      builder: (state) => TaskPage(user: state.extra as User),
    ),
  ],
);

class CupertinoTransitionGoRouter extends GoRoute {
  CupertinoTransitionGoRouter({
    super.name,
    required super.path,
    required Widget Function(GoRouterState s) builder,
    List<GoRoute> super.routes = const [],
  }) : super(
          pageBuilder: (context, state) => CupertinoPage(child: builder(state)),
        );
}
