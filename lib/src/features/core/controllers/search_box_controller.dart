import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchBoxController extends GetxController {
  final searchResults = [].obs;
  final selectedUser = {}.obs;

  final _db = FirebaseFirestore.instance;

  void search(String query) async {
    final collection = _db.collection("Jobs");
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (query.isEmpty) {
      querySnapshot = await collection.get();
    } else {
      querySnapshot = await collection.where('JobTitle', isGreaterThanOrEqualTo: query).where('JobTitle', isLessThan: "$query\uf8ff").get();
    }
    searchResults.value = querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}

//Case insensitive

//   void search(String query) async {
//     var collection = FirebaseFirestore.instance.collection('Users');
//     var querySnapshot;
//     if (query.isEmpty) {
//       querySnapshot = await collection.get();
//     } else {
//       querySnapshot = await collection.where('FullName', isGreaterThanOrEqualTo: query.toLowerCase())
//           .where('FullName', isLessThan: query.toLowerCase() + 'z')
//           .get();
//     }
//     searchResults.value = querySnapshot.docs.map((doc) => doc.data()).toList();
//   }
// }

//Old

//   void search(String query) async {
//     var collection = FirebaseFirestore.instance.collection('Users');
//     var querySnapshot;
//     if (query.isEmpty) {
//       querySnapshot = await collection.get();
//     } else {
//       querySnapshot = await collection.where('FullName', isGreaterThanOrEqualTo: query).get();
//     }
//     searchResults.value = querySnapshot.docs.map((doc) => doc.data()).toList();
//   }
// }
