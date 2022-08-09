import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/app/controllers/blog_controller.dart';
import 'package:get/get.dart';

import '../components/primary_button.dart';
import 'home_screen.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _authorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Osomoy News',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: GetBuilder<BlogController>(
              init: BlogController(),
              builder: (controller) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      controller.image != null
                          ? const SizedBox()
                          : Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  controller.pickImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Select Image'),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.image,
                                      color: Colors.deepPurple,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      controller.image != null
                          ? Image.file(
                              File(controller.image!.path),
                              height: 150,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _authorController,
                        decoration: const InputDecoration(
                          labelText: 'Author Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ReusablePrimaryButton(
                        childText: 'Add Post',
                        textColor: Colors.white,
                        buttonColor: Colors.deepPurple,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller
                                .addPost(
                                  _titleController.text,
                                  _descriptionController.text,
                                  _authorController.text,
                                )
                                .then((value) => {
                                      Get.snackbar(
                                        "Success",
                                        "Post added successfully",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.green,
                                        borderRadius: 10,
                                        margin: EdgeInsets.all(10),
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 2),
                                      ),
                                    });
                            _authorController.clear();
                            _titleController.clear();
                            _descriptionController.clear();
                            controller.image = null;
                            controller.update();
                          } else {
                            print('Form is not valid');
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
