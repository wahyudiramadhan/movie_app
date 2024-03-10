import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/detail_controller.dart';
import 'package:movie_app/data/const.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.favorite_outline),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    child: CachedNetworkImage(
                      imageUrl:
                          imagePath + controller.detailMovie['backdrop_path'],
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
                    width: 20,
                  ),
                  Text(
                    controller.detailMovie['original_title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.detailMovie['genres'].length,
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        width: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(controller.detailMovie['genres'][index]
                                ['name']),
                            const SizedBox(width: 10),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: const Divider(
                      height: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "overview",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.detailMovie['overview'],
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "production",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .detailMovie['production_companies'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                controller.detailMovie['production_companies']
                                    [index]['name'],
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Text(" | ");
                            },
                          ),
                        )
                      ],
                    ),
                  )

                  // Text(controller.detailMovie['genres'].toString()),
                ],
              ),
      ),
    );
  }
}
