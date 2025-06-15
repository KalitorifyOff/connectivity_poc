import 'package:connectivitypoc/bloc/internet/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetBloc()..add(InternetObserveRequested()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0x9f4376f8),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Plus with BLoC'),
        elevation: 4,
      ),
      body: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 2),
              Text(
                'Active connection types:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              ListView(
                shrinkWrap: true,
                children: List.generate(
                  state.connectionResults.length,
                  (index) => Center(
                    child: Text(
                      state.connectionResults[index].toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}
