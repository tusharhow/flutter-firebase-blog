import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_blog/app/models/product_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  File? image;
  final _firestore = FirebaseFirestore.instance;

  // pick image
  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    update();
  }

// add post
  Future<void> addPost(String title, String description, String author) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("posts" + DateTime.now().toString());
    await ref.putFile(File(image!.path));
    String imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    final post = {
      "id": DateTime.now().toString(),
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'author': author,
      'createdAt': FieldValue.serverTimestamp(),
    };
    _firestore.collection('posts').add(post);
  }

  // fetch posts stream firebase
  Stream<QuerySnapshot> get posts {
    return _firestore.collection('posts').snapshots();
  }

  // get post by id
  Future<PostModel> getPostById(String id) async {
    final data =
        _firestore.collection('posts').where('id', isEqualTo: id).get();
    final snapshot = await data;
    final post =
        snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return post[0];
  }
}
