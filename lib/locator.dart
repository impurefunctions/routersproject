import 'package:get_it/get_it.dart';

import 'core/services/firebase_service.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/repository.dart';
import 'core/viewmodels/add_post_wm.dart';
import 'core/viewmodels/create_user_wm.dart';
import 'core/viewmodels/delete_post_wm.dart';
import 'core/viewmodels/fetch_post_stream_wm.dart';
import 'core/viewmodels/login_with_email_wm.dart';
import 'core/viewmodels/save_image_url_wm.dart';
import 'core/viewmodels/update_post.wm.dart';

// -> registerLazySingleton : It waits till the instance created then return 
//the same instance

// -> registerFactory : it creates every instance each time

GetIt locator = GetIt.instance;
setupLocator() {
  
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => LocalStorageService());

  locator.registerFactory(() => SignupViewModel());
  locator.registerFactory(() => LoginControlViewModel());
  locator.registerFactory(() => SaveImageViewModel());
  locator.registerFactory(() => AddPostViewModel());
  locator.registerFactory(() => FetchPostViewModel());
  locator.registerFactory(() => DeletePostViewModel());
  locator.registerFactory(() => UpdatePostViewModel());
}
