import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/log_in_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LogInView.id: (context) =>const LogInView(),
        RegisterView.id: (context) => const RegisterView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: LogInView.id,
    );
  }
}
