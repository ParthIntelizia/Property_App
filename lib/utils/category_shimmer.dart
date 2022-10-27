import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        width: Get.width,
        height: 60,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Tab(
                  child: Container(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 22,
                      width: 17,
                      child: Container(
                        height: 20,
                        width: 17,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 22,
                      width: 17,
                      child: Container(
                        height: 20,
                        width: 17,
                      )),
                ]),
              )),
            );
          },
        ),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey,
      direction: ShimmerDirection.ltr,
    );
  }
}
