import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/blocs/internet_bloc/internet_event.dart';
import 'package:tutorial/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
 StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  final Connectivity _connectivity = Connectivity();



  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>(
      (event, emit) => emit(InternetLostState()),
    );

    on<InternetGainedEvent>(
      (event, emit) => emit(InternetGainedState()),
    );



    // connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen((result) {
    //   if (result == ConnectivityResult.mobile ||
    //       result == ConnectivityResult.wifi) {
    //     add(InternetGainedEvent());
    //   } else {
    //     add(InternetLostEvent());
    //   }
    // });

    // Listen to connectivity changes and emit appropriate events
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      // Check if any of the connectivity results indicate internet access
      if (results.any((result) => result == ConnectivityResult.mobile || result == ConnectivityResult.wifi)) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });

  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
