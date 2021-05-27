import 'package:flutter/cupertino.dart';
import 'package:routersproject/core/models/post.dart';
import 'package:routersproject/core/services/repository.dart';

import '../../locator.dart';

enum FetchDataState { InitialState, ErrorState }

class FetchPostViewModel with ChangeNotifier {
  Repository _repository = locator<Repository>();
  FetchDataState _state;
  Stream<List<Post>> allPosts;

  FetchPostViewModel() {
    state = FetchDataState.InitialState;
  }

  FetchDataState get state => _state;

  set state(FetchDataState value) {
    _state = value;
    notifyListeners();
  }

  Stream fetchPostsAsStream() {
    try {
      allPosts = _repository.getPostsAsStream();
    } catch (e) {
      state = FetchDataState.ErrorState;
    }
    return allPosts;
  }
}
