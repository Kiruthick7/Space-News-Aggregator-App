import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermissions(Permission permission) async {
    var status = await permission.request();
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        SnackBar(
          content: const Text(
            'Please allow the app to access your storage to download and save articles.',
          ),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      SnackBar(
        content: const Text(
            'Please allow the app to access your storage to download and save articles.'),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () {
            openAppSettings();
          },
        ),
      );
    }
    return false;
  }
}
