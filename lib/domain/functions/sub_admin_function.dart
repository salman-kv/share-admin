import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/sub_admin_model.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';


class SubAdminFunction {
  // add user in to firestore

  addSubAdminDeatails(SubAdminModel subAdminModel, String compire) async {
    final instant = FirebaseFirestore.instance.collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
    await instant.where(compire, isEqualTo: subAdminModel.email).get();
    final result = await instant.add(subAdminModel.fromMap());
    return result.id;
  }

  // checking and authenticate user deatailes and send user credential

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSubAdmin = await GoogleSignIn().signIn();
      final googleAuth = await googleSubAdmin?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('$e');
    }
  }

  // user pick image and send the path of image

  subAdminPickImage() async {
    try {
      var a = await ImagePicker().pickImage(source: ImageSource.gallery);
      return a;
    } catch (e) {
      log('$e');
    }
  }

  // checkig user deatailes already logind or not , if login sent the id otherwise send false

  checkSubAdminIsAlredyTheirOrNot(String email, String compare) async {
    final instant = FirebaseFirestore.instance.collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
    final val = await instant.where(compare, isEqualTo: email).get();
    if (val.docs.isNotEmpty) {
      return val.docs.first.id;
    } else {
      return false;
    }
  }

  // user login by email and password and send the id of user

  subAdminLoginPasswordAndEmailChecking(String email, String password) async {
    try {
      final instant = FirebaseFirestore.instance.collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      final val = await instant
          .where(FirebaseFirestoreConst.firebaseFireStoreEmail,
              isEqualTo: email)
          .get();
      if (val.docs.isNotEmpty) {
        if (val.docs
                .first[FirebaseFirestoreConst.firebaseFireStorePassword] ==
            password) {
          return val.docs.first.id;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      CommonWidget().toastWidget('$e');
    }
  }

  // fetch all data of a single user by id

  fecchSubAdminDataById(String userId) async {
    final val = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
        .doc(userId).get();
    var a= SubAdminModel(userId: userId, email: val['email'], name: val['name'], password: val['password'], phone: val['phone'], imagePath: val['image']);
    return a;
  }

  // store image in to image path in firebase and send back the download url as image url

  uploadImageToFirebase(XFile xfile)async{
    final ref=FirebaseStorage.instance.ref('image').child(xfile.name);
    await ref.putFile(File(xfile.path));
    final imageUrl=await ref.getDownloadURL();
  return imageUrl;
  }


}
