import 'dart:developer';
import 'dart:io';

import 'package:blogpost/module/post/data/model/create_post_model.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_service.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/user/domain/entity/user.dart' as domain;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebasePostService implements IPostService {

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  final uuid = const Uuid();

  final String namePostCollection = 'posts';
  final String nameUsersCollection = 'users';
  final String nameCommentsCollection = 'comments';

  Future<String> _uploadImage(File file) async {
    final destination = 'files/${uuid.v1() + file.path}';
    try {
      final ref = _firebaseStorage.ref().child(destination);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> _deleteImage(String url) async {
    try {
      await _firebaseStorage.refFromURL(url).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<domain.User?> _getUser() async {
    try {
      var user = domain.User(email: _firebaseAuth.currentUser!.email!);
      final snapshot = await _firebaseFirestore.collection(nameUsersCollection).doc(_firebaseAuth.currentUser!.uid).get();
      if(snapshot.exists){
        user = domain.User.fromMap(snapshot.data()!);
      }
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<domain.User> _getOtherUser(String userId) async {
    var user = domain.User(email: "");
    final snapshot = await _firebaseFirestore.collection(nameUsersCollection).doc(userId).get();
    if(snapshot.exists){
      user = domain.User.fromMap(snapshot.data()!);
    }
    return user;
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).doc(postId).get();
      final imageUrl = querySnapshot.data()!['imageUrl'];
      await _deleteImage(imageUrl);
      await _firebaseFirestore.collection(namePostCollection).doc(postId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Post>> getAll() async {
    try {
      final user = await _getUser();
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).where('isPublished', isEqualTo: true).get();
      final posts = querySnapshot.docs.map((doc) async {
        final data = doc.data();
        String id = doc.reference.id;
        List<String> likes = List<String>.from(data['likes']);
        final querySnapshotComments = await _firebaseFirestore.collection(nameCommentsCollection).where('postId', isEqualTo: id).get();
        return Post(
          id: id, 
          title: data['title'], 
          imageUrl: data['imageUrl'], 
          authorId: data['authorId'], 
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          isLiked: user != null ? likes.contains(user.id!) : null, 
          likesCount: likes.length, 
          commentsCount: querySnapshotComments.docs.length
        );
      }).toList();
      List<Post> resultPosts = [];
      for (var i = 0; i < posts.length; i++) {
        final post = await posts[i];
        final otherUser = await _getOtherUser(post.authorId!);
        resultPosts.add(post.copyWith(
          authorName: otherUser.name, 
          authorAvatar: otherUser.avatarImage,
        ));
      }
      return resultPosts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<Post>> getMyPosts() async {
    try {
      final user = await _getUser();
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).where('authorId', isEqualTo: user!.id).get();
      final posts = querySnapshot.docs.map((doc) async {
        final data = doc.data();
        String id = doc.reference.id;
        List<String> likes = List<String>.from(data['likes']);
        final querySnapshotComments = await _firebaseFirestore.collection(nameCommentsCollection).where('postId', isEqualTo: id).get();
        return Post(
          id: id, 
          title: data['title'], 
          imageUrl: data['imageUrl'], 
          authorId: data['authorId'], 
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          isLiked: user != null ? likes.contains(user.id!) : null, 
          likesCount: likes.length, 
          commentsCount: querySnapshotComments.docs.length
        );
      }).toList();
      List<Post> resultPosts = [];
      for (var i = 0; i < posts.length; i++) {
        final post = await posts[i];
        final otherUser = await _getOtherUser(post.authorId!);
        resultPosts.add(post.copyWith(
          authorName: otherUser.name, 
          authorAvatar: otherUser.avatarImage,
        ));
      }
      return resultPosts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Post> getPostDetails(String id) async {
    try {
      final user = await _getUser();
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).doc(id).get();
      final data = querySnapshot.data()!;
      List<String> likes = List<String>.from(data['likes']);
      final querySnapshotComments = await _firebaseFirestore.collection(nameCommentsCollection).where('postId', isEqualTo: id).get();
      return Post(
        id: id, 
        title: data['title'], 
        imageUrl: data['imageUrl'], 
        authorId: data['authorId'], 
        createdAt: (data['createdAt'] as Timestamp).toDate(), 
        likesCount: likes.length, 
        isLiked: user != null ? likes.contains(user.id!) : null,
        commentsCount: querySnapshotComments.docs.length,
        content: data['content'],
        isPublished: data['isPublished']
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> likePost(String id) async {
    try {
      final user = await _getUser();
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).doc(id).get();
      final data = querySnapshot.data()!;
      List<String> likes = List<String>.from(data['likes']);
      if(!likes.contains(user!.id!)){
        await _firebaseFirestore.collection(namePostCollection).doc(id).update(
          {
            'likes': likes..add(user.id!)
          }
        );
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> unlikePost(String id) async {
    try {
      final user = await _getUser();
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).doc(id).get();
      final data = querySnapshot.data()!;
      List<String> likes = List<String>.from(data['likes']);
      if(likes.contains(user!.id!)){
        await _firebaseFirestore.collection(namePostCollection).doc(id).update(
          {
            'likes': likes..removeWhere((element) => element == user.id!)
          }
        );
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> addPost(String title, String content, bool isPublished, File image) async {
    try {
      final user = await _getUser();
      final imageUrl = await _uploadImage(image);
      await _firebaseFirestore.collection(namePostCollection).add(
        CreatePostModel(
          title: title, 
          content: content, 
          isPublished: isPublished,
          imageUrl: imageUrl
        ).toMap()..addAll({
          'authorId': user!.id,
          'createdAt': DateTime.now(),
          'likes': List<String>.empty(),
          'comments': List<String>.empty()
        })
      );
    } catch (e) {
      log(e.toString());
    }
  }
  
  @override
  Future<void> updatePost(String postId, String? title, String? content, bool? isPublished, File? image) async {
    try {
      final querySnapshot = await _firebaseFirestore.collection(namePostCollection).doc(postId).get();
      final data = querySnapshot.data()!;
      String? imageUrl = image != null ? await _uploadImage(image) : null;
      final map = {
        'title': title ?? data['title'], 
        'imageUrl': imageUrl ?? data['imageUrl'], 
        'isPublished': isPublished ?? data['isPublished'], 
        'content': content ?? data['content'],  
      };
      await _firebaseFirestore.collection(namePostCollection).doc(postId).update(map);
    } catch (e) {
      log(e.toString());
    }
  }
}