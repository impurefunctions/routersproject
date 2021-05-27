import 'package:flutter/cupertino.dart';
import 'package:routersproject/core/models/post.dart';
import 'package:routersproject/core/services/repository.dart';

import '../../locator.dart';

enum UpdatePostState { InitialState, LoadedState,ErrorState }

class UpdatePostViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  UpdatePostState _state;
  Post _post;

  UpdatePostViewModel() {
    _post = Post();
    _state = UpdatePostState.InitialState;
  }

  Post get post => _post;

  UpdatePostState get state => _state;

  set state(UpdatePostState value) {
    _state = value;
    notifyListeners();
  }

  Future<Post> updatePost(String userId,String title,String content,String dateTime,String postId) async {
    try {
      _post = await _repository.updatePost(userId,title,content,dateTime,postId);
    } catch (e) {
      _state = UpdatePostState.ErrorState;
    }
    return _post;
  }
}
