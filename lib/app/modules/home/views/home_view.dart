import 'package:berita_mobile/app/modules/home/views/category_view.dart';
import 'package:berita_mobile/app/modules/home/views/main_view.dart';
import 'package:berita_mobile/app/modules/home/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  var controller = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const MainView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: CategoryView(),
            item: ItemConfig(
              icon: Icon(Icons.category),
              title: "Kategori",
            ),
          ),
          PersistentTabConfig(
            screen: ProfileView(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.person),
              title: "Profil",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style2BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
