import 'package:flutter/cupertino.dart';
import 'package:pk_education/services/global_api_service.dart';
import 'package:pk_education/services/storage_services.dart';

import 'api_client.dart';

class Global {
  static late StorageServices storageServices;
  static late ApiClient apiClient;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    storageServices = await StorageServices().init();
    apiClient = ApiServices().init();
  }
}
