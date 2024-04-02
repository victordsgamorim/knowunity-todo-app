import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:knowunity_todo_app/core/route/route_path.dart';
import 'package:knowunity_todo_app/feature/controller/login/login_bloc.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:knowunity_todo_app/feature/pages/components/dropdown.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<LoginBloc>(),
      child: const _LoginPage(),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage({super.key});

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  late final LoginBloc _bloc;
  User? selectedUser;

  @override
  void initState() {
    _bloc = BlocProvider.of<LoginBloc>(context)
      ..add(LoadUsersFromDatabaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                final user = state.users;
                return Dropdown(
                  users: state.users,
                  onChanged: (user) => selectedUser = user,
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (selectedUser != null) {
                _bloc.add(SaveUserToSharedPreferencesEvent(selectedUser!));
                context.go(R.task, extra: selectedUser);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please, select a user!'),
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: const Text("Select User"),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
