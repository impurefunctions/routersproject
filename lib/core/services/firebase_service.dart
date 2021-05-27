import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routersproject/core/models/post.dart';
import 'package:routersproject/core/models/user.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference = FirebaseFirestore.instance.collection("users");
  final CollectionReference _postCollectionReference = FirebaseFirestore.instance.collection("posts");
  final StreamController<List<Post>> _postController = StreamController<List<Post>>.broadcast();

  //sign up user
  Future createUser(User user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  //it checks if the user exists or not
  Future<User> loginControl(String email, String password) async {
    User currentUser;
    try {
      await _userCollectionReference.get().then((users) {
        for (DocumentSnapshot user in users.docs) {
          if (user.data()["mail"] == email && user.data()["password"] == password) {
            currentUser = User.fromMap(user.data());
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return currentUser;
  }

  //save profile picture into user account
  Future<String> saveProfilePicture(String imageURL, String userID) async {
    var response;
    try {
      await _userCollectionReference
          .doc(userID)
          .update({'image': imageURL}).then((u) {
        response = "true";
      });
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  //add post with user id
  Future addPost(Post post) async {
    try {
      await _postCollectionReference.doc(post.postId).set(post.toJson()).then((currentResult) {
        print("Post added successfully");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //fetch all posts
  Stream fetchPostsAsStream() {
    try {
      _postCollectionReference.snapshots().listen((postSnapshot) {
        if (postSnapshot.docs.isNotEmpty) {
          List<Post> allPosts = postSnapshot.docs
              .map((currentMap) => Post.fromMap(currentMap.data()))
              .where((mappedPost) =>
                  mappedPost.userId.isNotEmpty && mappedPost.title.isNotEmpty).toList();
          _postController.add(allPosts);
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return _postController.stream;
  }

  //delete post with it
  Future<void> deletePost(String postId) async {
    try {
      await _postCollectionReference.doc(postId).delete().then((result){
        print("Post deleted successfully");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //Delete all posts
  Future<void> deleteAllPosts() async {
    try {
      await _postCollectionReference.get().then((allPosts) async {
        for (var onePost in allPosts.docs) {
          await _postCollectionReference.doc(onePost.id).delete();
          print("${onePost.id} deleted successfully");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //update post with id
  Future updatePost(Post post) async {
    try {
          await  _postCollectionReference.doc(post.postId).update(post.toJson()).then((result){
          print("${post.title} updated successfully");
        });
    } catch (e) {
      print(e.toString());
    }
  }
}
