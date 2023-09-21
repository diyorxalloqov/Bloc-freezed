import 'package:bloc_freezed/application/bloc/user_bloc.dart';
import 'package:bloc_freezed/presentation/ui/secondPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: ((context, state) => Scaffold(
            appBar: AppBar(
              title: const Text("Bloc/freezed"),
            ),
            body: state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                error: (errorMessage) => Center(
                      child: Text(errorMessage),
                    ),
                complete: (userModel) => ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(userModel[index].name.toString()),
                          subtitle: Text(userModel[index].email.toString()),
                        );
                      },
                      itemCount: userModel.length,
                    )),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
                label: const Text("Next page")),
          )),
    );
  }
}
