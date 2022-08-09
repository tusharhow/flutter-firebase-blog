import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/app/models/product_model.dart';
import 'package:get/get.dart';

import '../controllers/blog_controller.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Osomoy News',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<BlogController>(
          init: BlogController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  FutureBuilder<PostModel>(
                      future: controller.getPostById(id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              data!.createdAt!.millisecondsSinceEpoch);
                          return Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      data.imageUrl.toString(),
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Text(
                                  date.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  data.author.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Center(
                                child: Text(
                                  data.title.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: Text(
                                    data.description.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white54,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            );
          }),
    );
  }
}
