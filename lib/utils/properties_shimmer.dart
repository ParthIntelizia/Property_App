import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PropertiesShimmer extends StatelessWidget {
  const PropertiesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 3,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Container(
                height: 350,
                width: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: SizedBox(
                          height: 200,
                          //   width: 200,
                          child: Container(
                            height: 200,
                            color: Colors.grey,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 10,
                            width: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 10,
                            width: 30,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: 10,
                            width: 50,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 10,
                            width: 40,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey,
      direction: ShimmerDirection.ltr,
    );
  }
}
