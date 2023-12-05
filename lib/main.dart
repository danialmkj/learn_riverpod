import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

//we write and extaion whcich convert int num to optional operating
extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Riverpod',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

//listen to provider and change values if anything changes
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // simple access to provider changes from provider
    // final time = ref.watch(currentDate);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Riverpod',
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.watch(counterProvider);
                final value = counter == null ? '0' : counter.toString();
                return Text(value);
              },
            ),
            TextButton(
              onPressed:
                  ref.read(counterProvider.notifier).increament, //add this line
              child: const Text('Increase value'),
            )
          ]),
        ));
  }
}

//we create a time which change the time
// simple provider
final currentDate = Provider<DateTime>((ref) => DateTime.now());

// using state notifier provider
final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  //increament method
  void increament() => state = state == null ? 1 : state + 1;

  //current valule
  int? get value => state;
}
