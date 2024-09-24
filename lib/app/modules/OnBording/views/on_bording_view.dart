import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../custom/button.dart';
import '../controllers/on_bording_controller.dart';

class OnBordingView extends GetView<OnBordingController> {
  const OnBordingView({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // PageView
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentPage.value = index;
              },
              children: [
                ///////////// first page /////////////////
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned(
                        top: height * 0.12,
                        child: Container(
                          height: height * 0.52,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                          top: height * 0.12,
                          left: width * 0.33,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                        top: height * 0.16,
                        left: width * 0.05,
                        child: Container(
                          height: height * 0.44,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                          top: height * 0.588,
                          left: width * 0.45,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.38,
                          left: width * 0.03,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.43,
                          right: width * 0.04,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                        top: height * 0.15, // Position from the top edge
                        right: width * 0.28, // Position from the right edge
                        child: Transform(
                          alignment: Alignment
                              .bottomLeft, // Align rotation to the bottom left
                          transform: Matrix4.rotationZ(
                              0.33), // Adjust the rotation angle as needed (positive for clockwise rotation)
                          child: Card(
                            child: Container(
                              height: height * 0.39,
                              width: width *
                                  0.47, // Ensure width matches the first container
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: height *
                                        0.30, // Adjust height for the image
                                    width: double
                                        .infinity, // Take full width of the parent
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTMuQyoYxSKBOPs1x4GeZ039O2wj3L-_9trMfO6SGtO8ZfKmNXc',
                                            height: height * 0.30,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.high,
                                          ),
                                        ),
                                        Positioned(
                                            right: width * 0.03,
                                            top: height * 0.01,
                                            child: Container(
                                              // Adjust the padding to control the border thickness
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: const Color(
                                                      0xFFD3D3D3), // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                maxRadius: 15,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 20,
                                                  color: Colors.black,
                                                ), // You can add an icon or image inside the avatar if needed
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Container(
                                    height: height * 0.02,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 219, 218,
                                              218), // Lighter color on the left
                                          Color(
                                              0xFFF5F5F5), // Slightly darker color on the right
                                        ],
                                        begin: Alignment
                                            .centerLeft, // Start gradient at the left center
                                        end: Alignment
                                            .centerRight, // End gradient at the right center
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.028),
                                      _buildGradientContainer(width, height),
                                      SizedBox(width: width * 0.02),
                                      _buildGradientContainer(width, height),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.028),
                                      _buildGradientContainer(width, height),
                                      SizedBox(width: width * 0.02),
                                      _buildGradientContainer(width, height),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.15, // Keep this unchanged
                        left: width * 0.25, // Position from the left edge
                        child: Transform(
                          alignment: Alignment
                              .bottomRight, // Aligns the rotation to the bottom right
                          transform: Matrix4.rotationZ(
                              -0.27), // Adjust the rotation angle as needed
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              height: height * 0.39,
                              width:
                                  width * 0.45, // Ensure width is set correctly
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: height *
                                        0.30, // Adjust height for the image
                                    width: double
                                        .infinity, // Take full width of the parent
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTZGlaf_AnhOr4J_p97T2OUjbb-cyIIyuiSWiot9zaNPyNC-5Wl',
                                            height: height * 0.30,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.high,
                                          ),
                                        ),
                                        Positioned(
                                            right: width * 0.03,
                                            top: height * 0.01,
                                            child: Container(
                                              // Adjust the padding to control the border thickness
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255,
                                                      211,
                                                      211,
                                                      211), // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                maxRadius: 15,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.favorite,
                                                  size: 20,
                                                  color: Colors.black,
                                                ), // You can add an icon or image inside the avatar if needed
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Container(
                                    height: height * 0.02,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 219, 218,
                                              218), // Lighter color on the left
                                          Color(
                                              0xFFF5F5F5), // Slightly darker color on the right
                                        ],
                                        begin: Alignment
                                            .centerLeft, // Start gradient at the left center
                                        end: Alignment
                                            .centerRight, // End gradient at the right center
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.028),
                                      _buildGradientContainer(width, height),
                                      SizedBox(width: width * 0.02),
                                      _buildGradientContainer(width, height),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.028),
                                      _buildGradientContainer(width, height),
                                      SizedBox(width: width * 0.02),
                                      _buildGradientContainer(width, height),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.7,
                          left: width * 0.14,
                          child: const Text(
                            'Discover new and',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.745,
                          left: width * 0.21,
                          child: const Text(
                            'trendy product',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.8,
                          left: width * 0.03,
                          child: const Text(
                              'Discover lastest fashion trends and styles with trendfy',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 107, 107)))),
                      Positioned(
                          top: height * 0.825,
                          left: width * 0.36,
                          child: const Text('curated collections',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 107, 107)))),
                    ],
                  ),
                ),
                ////////////// second page ////////////////////
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      ///////// first circul and its dots ////////////////
                      Positioned(
                        top: height * 0.12,
                        child: Container(
                          height: height * 0.52,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                          top: height * 0.11,
                          left: width * 0.5,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.545,
                          left: width * 0.1,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
///////////// Second circul and its dots//////////////////////
                      Positioned(
                        top: height * 0.16,
                        left: width * 0.05,
                        child: Container(
                          height: height * 0.44,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),

                      Positioned(
                          top: height * 0.588,
                          left: width * 0.45,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.168,
                          left: width * 0.3,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.225,
                          left: width * 0.135,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
//////////////// third circul  ////////////////////
                      Positioned(
                        top: height * 0.205,
                        left: width * 0.12,
                        child: Container(
                          height: height * 0.35,
                          width: width * 0.75,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        left: width * 0.1,
                        child: Container(
                          height: height,
                          width: width,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              // First Rotated Container
                              Positioned(
                                top: height *
                                    0.12, // Position for the first container
                                left: width *
                                    0.02, // All containers start from the same left point
                                child: Transform.rotate(
                                  angle: -0.1, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.1,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: height * 0.012,
                                            left: width * 0.02,
                                            child: Container(
                                              width:
                                                  32, // Diameter of the CircleAvatar
                                              height:
                                                  32, // Diameter of the CircleAvatar
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                backgroundColor: Colors
                                                    .transparent, // Make the background transparent
                                                maxRadius:
                                                    16, // Radius of the CircleAvatar
                                                // Add any other content inside the CircleAvatar if needed
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.01,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.035,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.061,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   // Second Rotated Container
                              Positioned(
                                top: height * 0.22,
                                child: Transform.rotate(
                                  angle: 0.15, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.1,
                                      width: width * 0.84,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: height * 0.012,
                                            left: width * 0.02,
                                            child: Container(
                                              width:
                                                  32, // Diameter of the CircleAvatar
                                              height:
                                                  32, // Diameter of the CircleAvatar
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                backgroundColor: Colors
                                                    .transparent, // Make the background transparent
                                                maxRadius:
                                                    16, // Radius of the CircleAvatar
                                                // Add any other content inside the CircleAvatar if needed
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.01,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.035,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.061,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   // Third Rotated Container
                              Positioned(
                                top: height *
                                    0.32, // Position for the first container
                                // All containers start from the same left point
                                child: Transform.rotate(
                                  angle: 0.4, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.1,
                                      width: width * 0.79,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: height * 0.012,
                                            left: width * 0.02,
                                            child: Container(
                                              width:
                                                  32, // Diameter of the CircleAvatar
                                              height:
                                                  32, // Diameter of the CircleAvatar
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color(
                                                        0xFFF5F5F5), // End with an off-white color
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                backgroundColor: Colors
                                                    .transparent, // Make the background transparent
                                                maxRadius:
                                                    16, // Radius of the CircleAvatar
                                                // Add any other content inside the CircleAvatar if needed
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.01,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.035,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.061,
                                            left: width * 0.13,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ////////////// Heading typr text /////////////////////
                      Positioned(
                          top: height * 0.7,
                          left: width * 0.19,
                          child: const Text(
                            'Order with safe',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.745,
                          left: width * 0.13,
                          child: const Text(
                            'payments methods',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.8,
                          left: width * 0.05,
                          child: const Text(
                              'Discover lastest fashion trends and styles with trendfy',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 107, 107)))),
                      Positioned(
                          top: height * 0.825,
                          left: width * 0.36,
                          child: const Text('curated collections',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 107, 107)))),
                    ],
                  ),
                ),
                ////////// third page ///////////////////////////
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      ///////// first circul and its dots ////////////////
                      Positioned(
                        top: height * 0.12,
                        child: Container(
                          height: height * 0.52,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                          top: height * 0.195,
                          left: width * 0.096,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.59,
                          left: width * 0.75,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
///////////// Second circul and its dots//////////////////////
                      Positioned(
                        top: height * 0.16,
                        left: width * 0.05,
                        child: Container(
                          height: height * 0.44,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),

                      Positioned(
                          top: height * 0.58,
                          left: width * 0.35,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                          top: height * 0.166,
                          left: width * 0.65,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),

//////////////// third circul  and dots ////////////////////
                      Positioned(
                        top: height * 0.205,
                        left: width * 0.12,
                        child: Container(
                          height: height * 0.35,
                          width: width * 0.75,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                        ),
                      ),
                      Positioned(
                          top: height * 0.195,
                          left: width * 0.45,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.black26,
                            size: 17,
                          )),
                      Positioned(
                        top: height * 0.1,
                        left: width * 0.1,
                        child: Container(
                          height: height,
                          width: width,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              ///////////// First Rotated Container
                              Positioned(
                                top: height *
                                    0.14, // Position for the first container
                                left: width *
                                    0.02, // All containers start from the same left point
                                child: Transform.rotate(
                                  angle: -0.1, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.17,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: width * 0.03,
                                            top: height * 0.013,
                                            child: Container(
                                              height: height * 0.13,
                                              width: width * 0.22,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255,
                                                          219,
                                                          219,
                                                          219), // Start with a brown color
                                                      Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255), // End with an off-white color
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.015,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.04,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.065,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.09,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.47,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   // Second Rotated Container
                              Positioned(
                                top: height * 0.19,
                                left: width * 0.02,
                                child: Transform.rotate(
                                  angle: -0.03, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.17,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: width * 0.03,
                                            top: height * 0.013,
                                            child: Container(
                                              height: height * 0.13,
                                              width: width * 0.22,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255,
                                                          219,
                                                          219,
                                                          219), // Start with a brown color
                                                      Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255), // End with an off-white color
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.015,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.04,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.065,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.09,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.47,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   //   // Third Rotated Container
                              Positioned(
                                top: height * 0.245,
                                left: width *
                                    0.02, // Position for the first container
                                // All containers start from the same left point
                                child: Transform.rotate(
                                  angle: 0.1, // Rotate downward
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: height * 0.155,
                                      width: width * 0.79,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: width * 0.03,
                                            top: height * 0.013,
                                            child: Container(
                                              height: height * 0.13,
                                              width: width * 0.22,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255,
                                                          219,
                                                          219,
                                                          219), // Start with a brown color
                                                      Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255), // End with an off-white color
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.015,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.04,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.065,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.09,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.27,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color(
                                                        0xFFFFFFFF), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.115,
                                            left: width * 0.47,
                                            child: Container(
                                              height: height * 0.02,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255,
                                                        219,
                                                        219,
                                                        219), // Start with a brown color
                                                    Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // End with an off-white color
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: width * 0.01,
                                              child: const Icon(
                                                  Icons.fiber_manual_record))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ////////////// Heading typr text /////////////////////
                      Positioned(
                          top: height * 0.7,
                          left: width * 0.1,
                          child: const Text(
                            'Fast delivery right at',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.745,
                          left: width * 0.18,
                          child: const Text(
                            'yours doorsteps',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: height * 0.8,
                          left: width * 0.05,
                          child: const Text(
                            'Experience effortless fashion browsing and shopping ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 124, 107, 107)),
                          )),
                      Positioned(
                          top: height * 0.825,
                          left: width * 0.2,
                          child: const Text('with our seamless online platfrom',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 107, 107)))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Dots Indicator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return _buildDot(index == controller.currentPage.value);
                }),
              );
            }),
          ),
          Obx(
            () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: CustomButton(
                text: controller.currentPage.value < 2 ? 'Next' : 'Get Started',
                onPressed: () {
                  if (controller.currentPage.value < 2) {
                    controller.nextPage();
                  } else {
                    // Navigate to a new page when "Get Started" is clicked
                    Get.toNamed(Routes.LANGUSE);
                    //// Replace `NewPage` with the page you want to navigate to
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///////////// Method to build page content

  ////////////////// Method to build dot indicator with elongated active dot
  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 16 : 8, // Elongate the active dot
      height: 8, // Keep height consistent for all dots
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
            4), // Smooth the corners for the rectangular dot
        border: Border.all(color: Colors.black),
      ),
    );
  }
}

////////////////// Helper method to build gradient containers
Widget _buildGradientContainer(double width, double height) {
  return Container(
    height: height * 0.02,
    width: width * 0.19,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 219, 218, 218),
          Color(0xFFF5F5F5),
        ], // Gradient from gray to off-white
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
