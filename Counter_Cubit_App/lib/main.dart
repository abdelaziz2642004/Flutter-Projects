import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/counter_cubit.dart';
import 'package:prj/counter_state.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => CounterCubit(), child: pointsCounter()),
  );
}

class pointsCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Points Counter'),
        ),
        body: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {},
          builder: (context, state) {
            int teamAPoints =
                BlocProvider.of<CounterCubit>(context).teamAPoints;
            int teamBPoints =
                BlocProvider.of<CounterCubit>(context).teamBPoints;

            // when u want to completely rebuild the widget UI
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Team E',
                            style: const TextStyle(fontSize: 32),
                          ),
                          Text(
                            '$teamAPoints',
                            style: const TextStyle(fontSize: 150),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(1, 1);
                            },
                            child: const Text(
                              'Add 1 Point ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(1, 2);
                            },
                            child: const Text(
                              'Add 2 Point',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(1, 3);
                            },
                            child: const Text(
                              'Add 3 Point ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      child: const VerticalDivider(
                        indent: 50,
                        endIndent: 50,
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Team B',
                            style: const TextStyle(fontSize: 32),
                          ),
                          Text(
                            '$teamBPoints',
                            style: const TextStyle(fontSize: 150),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(2, 1);
                            },
                            child: const Text(
                              'Add 1 Point ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(2, 2);
                            },
                            child: const Text(
                              'Add 2 Point ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.orange,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(
                                context,
                              ).addPoints(2, 3);
                            },
                            child: const Text(
                              'Add 3 Point ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    // primary: Colors.orange,
                    minimumSize: const Size(150, 50),
                  ),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(
                      context,
                    ).addPoints(1, -1 * teamAPoints);
                    BlocProvider.of<CounterCubit>(
                      context,
                    ).addPoints(2, -1 * teamBPoints);
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
