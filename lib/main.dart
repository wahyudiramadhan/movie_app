import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/bindings/initial_binding.dart';
import 'package:movie_app/screens/index_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      initialBinding: InitialBinding(),
      home: const IndexView(),
    );
  }
}
