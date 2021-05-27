import 'package:flutter/cupertino.dart';
import 'package:routersproject/core/models/post.dart';
import 'package:routersproject/core/services/repository.dart';

import '../../locator.dart';

enum DeletePostState { InitialState, LoadingState, LoadedState, ErrorState }

class DeletePostViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  Post _post;
  DeletePostState _state;

  DeletePostViewModel() {
    _post = Post();
    _state = DeletePostState.InitialState;
  }

  Post get post => _post;

  DeletePostState get state => _state;

  set state(DeletePostState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> deletePost(String postId) async {
    var currentPost;
    try {
      currentPost = _repository.deletePost(postId);
    } catch (e) {
      state = DeletePostState.ErrorState;
    }
    return currentPost;
  }

  Future<void> deleteAllPosts() async {
    var allPosts;
    try {
      allPosts = _repository.deleteAllPosts();
    } catch (e) {
      state = DeletePostState.ErrorState;
    }
    return allPosts;
  }
}
