import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/index_controller.dart';
import 'package:movie_app/screens/home_view.dart';
import 'package:movie_app/screens/profile_view.dart';

class IndexView extends StatelessWidget {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());
    return Scaffold(
      body: Obx(
        () {
          switch (controller.currentIndex.value) {
            case 0:
              return const HomeScreen();
            case 1:
              return const ProfileView();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
