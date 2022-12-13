import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uistates/cubit/add_history_cubit.dart';
import 'package:uistates/cubit/change_theme_cubit.dart';

import 'cubit/click_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ClickCubit()),
        BlocProvider(create: (BuildContext context) => ChangeThemeCubit()),
        BlocProvider(create: (BuildContext context) => AddHistoryCubit())
      ],
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          if (state is ThemeState) {
            return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(brightness: state.brightness),
                debugShowCheckedModeBanner: false,
                home: MyHomePage(title: 'Экран'));
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(brightness: Brightness.light),
            debugShowCheckedModeBanner: false,
            home: MyHomePage(title: 'Экран'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String textCounter = "0";

  static List<Text> history = [Text("--------")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<ClickCubit, ClickState>(
                  builder: (context, state) {
                    if (state is ClickError) {
                      textCounter = state.message;
                      return Text(
                        textCounter,
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }

                    if (state is Click) {
                      textCounter = state.count.toString();
                      return Text(
                        textCounter,
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }

                    return Text("0",
                        style: Theme.of(context).textTheme.headline4);
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            Brightness brightness =
                                Theme.of(context).brightness;
                            context
                                .read<ClickCubit>()
                                .onClick(brightness, true);
                            context.read<AddHistoryCubit>().onClick(
                                history, int.parse(textCounter), brightness);
                          },
                          child: const Icon(Icons.remove)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Brightness brightness = Theme.of(context).brightness;
                          context.read<ClickCubit>().onClick(brightness, false);
                          context.read<AddHistoryCubit>().onClick(
                              history, int.parse(textCounter), brightness);
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
                BlocBuilder<AddHistoryCubit, AddHistoryState>(
                  builder: (context, state) {
                    if (state is History) {
                      return Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: state.history,)
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context
            .read<ChangeThemeCubit>()
            .onClick(Theme.of(context).brightness),
        tooltip: 'Increment',
        child: const Text("Тема"),
      ),
    );
  }
}
