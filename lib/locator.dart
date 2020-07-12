import 'package:get_it/get_it.dart';
import 'package:updateperutangan/src/service/push_notification_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
}
