import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/hive_service.dart';
import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await HiveService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: BlocProvider(
        create: (_) => NoteBloc()..add(LoadNotes()),
        child: HomeScreen(),
      ),
    );
  }
}
