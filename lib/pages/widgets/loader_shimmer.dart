import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderShimmer extends StatelessWidget {
  const LoaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildRoundedContainer(50, 50),
                      SizedBox(
                        width: 10,
                      ),
                      _buildContainer(150, 30),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildContainer(double.infinity, 450),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _buildContainer(100, 30),
                      SizedBox(
                        width: 10,
                      ),
                      _buildContainer(100, 30),
                      SizedBox(
                        width: 10,
                      ),
                      _buildContainer(100, 30),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _buildRoundedContainer(25, 25),
                      SizedBox(
                        width: 5,
                      ),
                      _buildContainer(100, 15),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildContainer(200, 15),
                  SizedBox(height: 10),
                  _buildContainer(100, 15),
                  SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoaderShimmerUser extends StatelessWidget {
  const LoaderShimmerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildRoundedContainer(50, 50),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildContainer(50, 20),
                          SizedBox(
                            height: 10,
                          ),
                          _buildContainer(150, 25),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: _buildContainer(80, 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildRoundedContainer(double width, double height) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white, // Set the color of the container
      shape: BoxShape.circle, // This makes the container circular
    ),
  );
}

Widget _buildContainer(double width, double height) {
  return Container(height: height, width: width, color: Colors.white);
}
