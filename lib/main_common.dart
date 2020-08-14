import 'package:campsite/core/app_config.dart';
import 'package:campsite/core/bloc/simple_bloc_observer.dart';
import 'package:campsite/core/screen/start_screen.dart';
import 'package:campsite/injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> bootApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);

  Bloc.observer = SimpleBlocObserver();
  final dependencies = await initDependencies(flavor);
  runApp(_buildRoot(dependencies));
}

Widget _buildRoot(List<SingleChildWidget> providers) {
  return MultiProvider(
    providers: providers,
    child: MaterialApp(
      home: StartScreen(),
    ),
  );
}

