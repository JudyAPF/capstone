import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  if(await permission.isGranted) return true;
  var status = await permission.request();
  if(status == PermissionStatus.granted) return true;
  return false;
}