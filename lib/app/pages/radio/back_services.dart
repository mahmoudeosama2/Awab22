import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';


Future<void> initializeService() async{
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground
      ),
      androidConfiguration: AndroidConfiguration(
          autoStart: true,
          onStart: onStart,
          isForegroundMode: true));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{
  DartPluginRegistrant.ensureInitialized();
  if(service is AndroidServiceInstance)
    {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if(service is AndroidServiceInstance)
      {
        if(await service.isForegroundService()){
          service.setForegroundNotificationInfo(title: "المرشد الإسلامى", content: "إذاعة القرآن الكريم من القاهرة");
        }
      }
    //perform some operation on background which is not noticeable to user to be used everytime
    print("background service running");
    service.invoke('update');
  });
}
@pragma('vm:entry-point')
FutureOr<bool> onIosBackground(ServiceInstance service) async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
  }

