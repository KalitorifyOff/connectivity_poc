import 'package:connectivitypoc/bloc/internet/internet_bloc.dart';
import 'package:connectivitypoc/bloc/internet/internet_event.dart';
import 'package:connectivitypoc/bloc/internet/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetBloc()..add(InternetObserveRequested()),
      child: MaterialApp(
        title: 'Connectivity BLoC Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF4376F8),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

/// Main UI
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internet Status'), elevation: 4),
      body: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is InternetOnline) {
            return Column(
              children: [
                const Spacer(flex: 2),
                const Text(
                  '✅ You are Online',
                  style: TextStyle(fontSize: 22, color: Colors.green),
                ),
                const SizedBox(height: 16),
                Text(
                  'Active connections:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListView(
                  shrinkWrap: true,
                  children:
                      state.connectionResults
                          .map(
                            (r) => Center(
                              child: Text(
                                r.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          )
                          .toList(),
                ),
                const Spacer(flex: 2),
              ],
            );
          } else if (state is InternetOffline) {
            return const Center(
              child: Text(
                '❌ You are Offline',
                style: TextStyle(fontSize: 22, color: Colors.red),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
