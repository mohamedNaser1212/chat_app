import 'package:chat_app/Cubits/auth_cubit.dart';
import 'package:chat_app/Cubits/chat_cubit.dart';
import 'package:chat_app/blocs/auth_bloc.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/widgets/login_page.dart';
import 'package:chat_app/widgets/regester_page.dart';
import 'package:chat_app/widgets/costum_text_field.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = SimpleBlockObserver();
  runApp(const MyApp());
//   BlocOverrides.runZoned((){
//     runApp(const MyApp());
//
//   },
//       blocObserver:SimpleBlockObserver(),
//   );
//
//
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        routes: {
          loginpageState.id: (context) => loginpageState(),
          regesterpageState.id: (context) => regesterpageState(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: loginpageState.id,
      ),
    );
  }
}
