import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/data/const.dart';
import 'package:movie_app/screens/detail_view.dart';
import 'package:movie_app/utils/limit_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading.value
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: CircleAvatar(),
                      ),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      title: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Wahyudi.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      actions: const [
                        Card(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.notifications_none_rounded)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      items: List.generate(
                        controller.nowPlayingData['results'].length,
                        (index) {
                          var item =
                              controller.nowPlayingData['results'][index];
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const DetailView(),
                                arguments: item['id'],
                              );
                            },
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: imagePath + item['backdrop_path'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        filterQuality: FilterQuality.medium,
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                    child: Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width /
                                          1.25,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black45,
                                            Colors.black87,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_border_rounded,
                                                  color: Colors.yellow,
                                                  size: 14,
                                                ),
                                                Text(
                                                  limitText(
                                                      item['vote_average']
                                                          .toString(),
                                                      3),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                ),
                                                const SizedBox(
                                                  height: 14,
                                                  child: VerticalDivider(
                                                    width: 10,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    listCardMovie(
                      title: "Popular",
                      controller: controller.popularData,
                    ),
                    listCardMovie(
                      title: "Top Rate",
                      controller: controller.topRateData,
                    ),
                    listCardMovie(
                      title: "Upcomming",
                      controller: controller.upcommingData,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget listCardMovie({required String title, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            "view more",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Text(controller.toString()),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller!['results'].length,
              (index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => const DetailView(),
                      arguments: controller['results'][index]['id'],
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 170,
                          width: 130,
                          child: CachedNetworkImage(
                            imageUrl: imagePath +
                                controller['results'][index]['poster_path'],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  filterQuality: FilterQuality.medium,
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          limitTextDots(
                              controller['results'][index]['title'], 18),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_border_rounded,
                              color: Colors.yellow,
                              size: 14,
                            ),
                            Text(
                              limitText(
                                  controller['results'][index]['vote_average']
                                      .toString(),
                                  3),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11),
                            ),
                            const SizedBox(
                              height: 14,
                              child: VerticalDivider(
                                width: 10,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
