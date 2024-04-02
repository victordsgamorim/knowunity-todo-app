import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:knowunity_todo_app/core/route/route_path.dart';
import 'package:knowunity_todo_app/feature/controller/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplashBloc>(),
      child: const _SplashPage(),
    );
  }
}

class _SplashPage extends StatefulWidget {
  const _SplashPage();

  @override
  State<_SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<_SplashPage> {
  late final SplashBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<SplashBloc>(context)..add(LoadTasksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: Text("Knowunity Todo App")),
          BlocConsumer<SplashBloc, SplashState>(
            listener: (BuildContext context, SplashState state) {
              if (state is SplashServerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is SplashLogged) {
                context.go(R.task, extra: state.user);
              } else if (state is SplashNotLogged) {
                context.go(R.login);
              }
            },
            builder: (context, state) {
              if (state is SplashLoading) {
                return const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
