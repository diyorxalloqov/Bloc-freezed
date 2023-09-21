// ignore_for_file: file_names

import 'package:bloc_freezed/application/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: ((context, state) => Scaffold(
            appBar: AppBar(
              title: const Text("Bloc/freezed/secondPage"),
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
                          title:
                              Text(userModel[index].company!.name.toString()),
                          subtitle:
                              Text(userModel[index].address!.street.toString()),
                        );
                      },
                      itemCount: userModel.length,
                    )),
          )),
    );
  }
}
