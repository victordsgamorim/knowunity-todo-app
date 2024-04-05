import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:knowunity_todo_app/core/route/route_path.dart';
import 'package:knowunity_todo_app/feature/controller/task/task_bloc.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:knowunity_todo_app/feature/pages/components/shimmer_task_item_loading.dart';
import 'package:knowunity_todo_app/feature/pages/components/task_dialog.dart';
import 'package:knowunity_todo_app/feature/pages/components/task_list.dart';

class TaskPage extends StatelessWidget {
  final User user;

  const TaskPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<TaskBloc>(),
      child: _TaskPage(user: user),
    );
  }
}

class _TaskPage extends StatefulWidget {
  final User user;

  const _TaskPage({required this.user});

  @override
  State<_TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<_TaskPage>
    with SingleTickerProviderStateMixin {
  late final TaskBloc _taskBloc;
  late final TabController _tabController;
  List<Task> tasks = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _taskBloc = BlocProvider.of<TaskBloc>(context)
      ..add(GetTaskByUserId(widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              title: Text('Welcome ${widget.user.name},'),
              actions: [
                IconButton(
                    onPressed: () => _taskBloc.add(LogoutEvent()),
                    icon: const Icon(Icons.logout_rounded))
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Incomplete', icon: Icon(Icons.close_rounded)),
                  Tab(text: 'Complete', icon: Icon(Icons.done_rounded)),
                ],
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskLogout) context.go(R.login);
            },
            builder: (context, state) {
              if (state is TaskSuccess) tasks = state.tasks;
              if (state is TaskLoading) {
                return Column(
                  children: List.generate(
                    2,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: ShimmerTaskItem(),
                    ),
                  ),
                );
              }

              return TabBarView(
                controller: _tabController,
                children: [
                  TaskList(
                    tasks: tasks.where((task) => !task.completed).toList(),
                    onTaskTap: _update,
                    onDelete: _delete,
                  ),
                  TaskList(
                    tasks: tasks.where((task) => task.completed).toList(),
                    onTaskTap: _update,
                    onDelete: _delete,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => TaskDialog(
              onCreated: (task) {
                _taskBloc.add(
                  AddNewTaskEvent(
                    Task(id: tasks.length + 1, title: task, completed: false),
                    widget.user.id,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _delete(Task task) => _taskBloc.add(DeleteTaskEvent(task.id!));

  void _update(Task task) =>
      _taskBloc.add(UpdateTaskEvent(task, widget.user.id));

  @override
  void dispose() {
    _taskBloc.close();
    _tabController.dispose();
    super.dispose();
  }
}
