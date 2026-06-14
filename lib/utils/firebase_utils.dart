import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/myuser.dart';
import '../models/event.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, _) =>
          MyUser.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }

  static CollectionReference<Event> getEventsCollection(String uId) {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, _) =>
          Event.fromJson(snapshot.data()!),
      toFirestore: (event, _) => event.toJson(),
    );
  }

  static Future<void> addUser(MyUser user) async {
    await getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String uId) async {
    var doc = await getUsersCollection().doc(uId).get();
    return doc.data();
  }

  static Future<void> addEvent(Event event, String uId) async {
    var docRef = getEventsCollection(uId).doc();
    event.id = docRef.id;
    await docRef.set(event);
  }

  static Future<void> deleteEvent(String id, String uId) async {
    await getEventsCollection(uId).doc(id).delete();
  }
}