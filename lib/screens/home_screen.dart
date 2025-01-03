import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/blocs/internet_bloc/internet_bloc.dart';
import 'package:tutorial/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Center(
        child: BlocBuilder<InternetBloc, InternetState>(
          builder: (context, state) {
            if (state is InternetGainedState) {
              return const Text("Internet Connected");
            } else if (state is InternetLostState) {
              return const Text("Internet  not Connected");
            } else {
              return const Text("Loading...");
            }
          },
        ),
      )),
    );
  }
}
