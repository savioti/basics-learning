import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_mvvm/src/core/state/state.dart';
import 'package:study_flutter_mvvm/src/modules/home/view_model/users_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UsersViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Builder(
          builder: (_) {
            if (viewModel.state == EState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.state == EState.error) {
              return Text(viewModel.error!.errorMessage);
            }

            if (viewModel.state == EState.finished) {
              final users = viewModel.users;

              return ListView.separated(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                  );
                },
                separatorBuilder: (_, __) {
                  return const Divider();
                },
                itemCount: viewModel.users.length,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
