import 'dart:io';

import 'package:ahiaa_web/features/media/models/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel> uploadImageFileInStorage(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      final Reference ref = _storage.ref().child('$path/$imageName');

      // upload file
      await ref.putBlob(file);

      // get the download url
      final String downloadUrl = await ref.getDownloadURL();

      // fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          metadata, path, imageName, downloadUrl);
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // upload image data in firestore
  Future<String> uploadImageInFirestore(ImageModel imageModel) async {
    try {
      final updatedModel = await FirebaseFirestore.instance
          .collection('Images')
          .add(imageModel.toMap());
      return updatedModel.id;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
}
