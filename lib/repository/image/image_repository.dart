import 'dart:async';
import 'dart:io';

import 'package:cj_flutter_riverpod_instagram_clone/common/utils/firebase_constant.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/icon_res.dart';
import 'package:cj_flutter_riverpod_instagram_clone/model/image/image_details.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/firebase_exception.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/random_name.dart';
import 'package:cj_flutter_riverpod_instagram_clone/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _userCollection = FirebaseFirestore.instance.collection('users');

String get _userId => fbAuth.currentUser!.uid;
CollectionReference<Map<String, dynamic>> _imageCollection() {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(_userId)
      .collection('images');
}

class ImageRepository {
  //! START - Add operation
  Future<ImageDetails?> addImages(ImageDetails d) async {
    String folderName = 'uploads/images_${randomName()}';
    List<String> imagesUrl = [];
    String imagesId = '';
    int dateCreated = DateTime.now().millisecondsSinceEpoch;

    final user = await _getUserDetails();

    try {
      for (var image in d.images!) {
        String? url = await _uploadImage(image, folderName);
        imagesUrl.add(url!);
      }
      await _imageCollection().add({
        'userId': fbUserId,
        'folderName': folderName,
        'likeCount': 0,
        'location': d.location,
        'description': d.description,
        'dateCreated': dateCreated,
      }).then((value) async {
        imagesId = value.id;
      });
      return d.copyWith(
        userId: fbUserId,
        userName: user!.userName,
        userImage: user.imageUrl,
        imagesId: imagesId,
        images: imagesUrl,
        likeCount: 0,
        dateCreated: dateCreated,
      );
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    } catch (e) {
      firebaseHandleException(e);
    }
    return null;
  }

  Future<String?> _uploadImage(String path, String folderName) async {
    File image = File(path);
    int dotIndex = path.lastIndexOf('.');
    String fileName = '${randomName()}${path.substring(dotIndex, path.length)}';

    try {
      Reference storageRef = storageReference.child('$folderName/$fileName');
      await storageRef.putFile(image);
      String url = await storageRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    }
    return null;
  }

  //! END - Add operation

  //! START - Read operation
  FutureOr<List<ImageDetails>?> getImages() async {
    List<ImageDetails> imageDetails = [];
    List<String> imageUrls = [];
    try {
      QuerySnapshot images = await _imageCollection().get();

      for (var imagesList in images.docs) {
        var data = imagesList.data() as Map<String, dynamic>;

        imageUrls = await _getImageUrls(data['folderName']);
        final user = await _getUserDetails();
        imageDetails.add(
          ImageDetails(
            userId: data['userId'],
            userName: user?.userName,
            userImage: user?.imageUrl,
            location: data['location'],
            imagesId: imagesList.id,
            images: imageUrls,
            likeCount: data['likeCount'],
            description: data['description'],
            dateCreated: data['dateCreated'],
          ),
        );
      }
      return imageDetails;
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    } catch (e) {
      firebaseHandleException(e);
    }
    return null;
  }

  FutureOr<UserDetails?> _getUserDetails() async {
    try {
      final DocumentSnapshot userDoc =
          await _userCollection.doc(fbUserId).get();
      final data = userDoc.data() as Map<String, dynamic>?;
      if (userDoc.exists) {
        return UserDetails(
          userName: data!['userName'],
          imageUrl: data['imageUrl'],
        );
      }
      throw 'User not found';
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    } catch (e) {
      firebaseHandleException(e);
    }
    return null;
  }

  FutureOr<List<String>> _getImageUrls(String folderName) async {
    List<String> imageUrl = [];
    try {
      final storageRef = storageReference.child(folderName);
      final listResult = await storageRef.listAll();
      await Future.forEach(listResult.items, (Reference ref) async {
        imageUrl.add(await ref.getDownloadURL());
      });
      return imageUrl;
    } catch (e) {
      firebaseHandleException(e);
      return [IconRes.testOnly];
    }
  }

  //! END - Read operation

  //! START - Delete operation

  Future<void> deleteImages(String id) async {
    try {
      await _imageCollection().doc(id).delete();
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    } catch (e) {
      firebaseHandleException(e);
    }
  }

  //! END - Delete operation

  //! START - Update operation

  Future<void> updateImages(
      ImageDetails details, List<String> deleteImages) async {
    try {
      await Future.forEach(deleteImages, (imageUrl) async {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      });
      await _imageCollection().doc(details.imagesId).update({
        'description': details.description,
      });
    } on FirebaseException catch (e) {
      firebaseHandleException(e);
    } catch (e) {
      firebaseHandleException(e);
    }
  }

  //! END - Update operation
}
