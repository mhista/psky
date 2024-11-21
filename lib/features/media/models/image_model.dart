import 'dart:convert';
import 'dart:typed_data';

import 'package:ahiaa_web/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // NOT MAPPED
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;
  // Constructor
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    this.mediaCategory = '',
    required this.filename,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });

  // STATIC FUNCTION TO CREATE ON EMPTY USER MODEL
  static ImageModel empty() => ImageModel(
        url: '',
        folder: '',
        filename: '',
      );

  String get createdAtFormatted => PFormatter.formatDate(createdAt);

  String get updatedAtFormatted => PFormatter.formatDate(updatedAt);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'url': url});
    result.addAll({'folder': folder});
    if (sizeBytes != null) {
      result.addAll({'sizeBytes': sizeBytes});
    }
    result.addAll({'filename': filename});
    if (fullPath != null) {
      result.addAll({'fullPath': fullPath});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt!.toUtc()});
    }
    result.addAll({'contentType': contentType});
    result.addAll({'mediaCategory': mediaCategory});

    return result;
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      folder: map['folder'] ?? '',
      sizeBytes: map['sizeBytes']?.toInt(),
      mediaCategory: map['mediaCategory'] ?? '',
      filename: map['filename'] ?? '',
      fullPath: map['fullPath'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      contentType: map['contentType'] ?? '',
    );
  }

  factory ImageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> data) {
    if (data.data() != null) {
      final map = data.data()!;

      return ImageModel(
        id: map['id'] ?? '',
        url: map['url'] ?? '',
        folder: map['folder'] ?? '',
        sizeBytes: map['sizeBytes']?.toInt(),
        mediaCategory: map['mediaCategory'] ?? '',
        filename: map['filename'] ?? '',
        fullPath: map['fullPath'] ?? '',
        createdAt: map['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
            : null,
        updatedAt: map['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
            : null,
        contentType: map['contentType'] ?? '',
      );
    } else {
      return ImageModel.empty();
    }
  }

  // MAP FIREBASE STORAGE DATA
  factory ImageModel.fromFirebaseMetadata(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      updatedAt: metadata.updated,
      contentType: metadata.contentType,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  // UPLOAD TO FIREBASE STORAGE
}
