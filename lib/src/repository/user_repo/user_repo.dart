import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/models/bid_model.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/features/core/views/jobs/all_jobs_by_anything_screen.dart';
import 'package:tasking/src/features/core/views/jobs/job_details_screen.dart';

import '../../constants/colors.dart';
import '../../features/auth/models/users_model.dart';
import '../../features/core/models/job_model.dart';
import '../../features/core/views/bids/all_bids_by_anything_screen.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUserDoc(UserModel userData) async {
    await _db
        .collection("Users")
        .doc(userData.id)
        .set(userData.toJson())
        // await _db.collection("Users").add(userData.toJson())
        .whenComplete(
          () => Get.snackbar("Success:", "Your Account Has Been Created",
              icon: const Icon(Icons.check_circle, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: TTS_LogoColor,
              borderRadius: 10,
              margin: const EdgeInsets.all(15),
              colorText: Colors.white,
              duration: const Duration(seconds: 10),
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  // Fetch User Details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).single;
    return userData;
  }

  // Fetch User Name
  Future<UserModel> getUserName(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).single;
    return userData;
  }

  // Fetch All Users
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).toList();
    return userData;
  }

  //Update User Records

  // Create Job Post
  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

  //create job doc
  Future createJobDoc(JobModel jobData) async {
    await _db
        .collection("Jobs")
        .doc(jobData.id)
        .set(jobData.toJson())
        // await _db.collection("Users").add(userData.toJson())
        .whenComplete(() {
      Get.snackbar("Success:", "Your Job Has Been Posted. Now Redirecting...",
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Future.delayed(const Duration(milliseconds: 2000));
      Get.offAll(() => AllJobsByFilterScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  Future createBidDoc(BidModel bidData) async {
    await _db
        .collection("Bids")
        .doc(bidData.id)
        .set(bidData.toJson())
        // await _db.collection("Users").add(userData.toJson())
        .whenComplete(() {
      Get.snackbar("Success:", "Your Bid Is Done. Now Redirecting...",
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Future.delayed(const Duration(milliseconds: 2000));
      Get.offAll(() => AllBidsByFilterScreen(
            filterByEmail: bidData.bidderEmail,
          ));
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  Future acceptBid({required String bidID, required String jobID}) async {
    await _db.collection("Bids").doc(bidID).update({"Status": "Accepted"});
    await _db
        .collection("Bids")
        .where("JobID", isEqualTo: jobID)
        .where("Status", isEqualTo: "Pending")
        .get()
        .then((docs) => docs.docs.forEach((result) async => await _db.collection("Bids").doc(result.id).update({"Status": "Void"})));
    await _db.collection("Jobs").doc(jobID).update({"Status": "In-Progress"})
        // await _db.collection("Users").add(userData.toJson())
        .whenComplete(() {
      Get.snackbar("Success:", "You Accepted The Offer. Now Redirecting...",
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Future.delayed(const Duration(milliseconds: 2000));
      Get.offAll(() => JobDetailScreen(jobId: jobID));
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  Future deliverOrder({required String jobID}) async {
    await _db.collection("Jobs").doc(jobID).update({"Status": "Delivered"}).whenComplete(() {
      Get.snackbar("Success:", "Order Marked As Delivered. Client Will Be Notified Shortly.",
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Future.delayed(const Duration(milliseconds: 2000));
      Get.offAll(() => DashboardScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  Future acceptDelivery({required String jobID}) async {
    await _db.collection("Jobs").doc(jobID).update({"Status": "Finished"}).whenComplete(() {
      Get.snackbar("Success:", "You Have Accepted The Deliverable. Order Status Will Be Changed To Finished",
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Future.delayed(const Duration(milliseconds: 2000));
      Get.offAll(() => DashboardScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: const Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  // Fetch All Jobs
  Future<List<JobModel>> getAllJobs() async {
    final snapshot = await _db.collection("Jobs").orderBy("Date", descending: true).get();
    final jobData = snapshot.docs.map((jobs) => JobModel.fromDatabase(jobs)).toList();
    return jobData;
  }

  // Fetch Job Details
  Future<JobModel> getJobDetails(String jobId) async {
    // final snapshot = await _db.collection("Jobs").where("id", isEqualTo: jobId).get();
    // final snapshot = await _db.collection("Jobs").doc('id jobId').get();
    final snapshot = await _db.collection("Jobs").where(FieldPath.documentId, isEqualTo: jobId).get();
    final jobDetails = snapshot.docs.map((details) => JobModel.fromDatabase(details)).single;
    return jobDetails;
  }

  // Fetch All Job By Filter (Email or Category)
  Future<List<JobModel>> getAllJobsByFilter(String? filterByCat, String? filterByEmail, String? filterByStatus) async {
    if (filterByStatus != null && filterByStatus == "Hiring" && filterByCat == null && filterByEmail == null) {
      final snapshot = await _db.collection("Jobs").where("Status", isEqualTo: filterByStatus).get();
      final jobListByEmailByCat = snapshot.docs.map((list) => JobModel.fromDatabase(list)).toList();
      return jobListByEmailByCat;
    } else if (filterByCat == null && filterByEmail == null) {
      final snapshot = await _db.collection("Jobs").orderBy("Date", descending: true).get();
      final jobListAll = snapshot.docs.map((jobs) => JobModel.fromDatabase(jobs)).toList();
      return jobListAll;
    } else if (filterByCat != null && filterByEmail == null) {
      final snapshot = await _db.collection("Jobs").where("Category", isEqualTo: filterByCat).get();
      final jobListByCat = snapshot.docs.map((list) => JobModel.fromDatabase(list)).toList();
      return jobListByCat;
    } else if (filterByCat == null && filterByEmail != null) {
      final snapshot = await _db.collection("Jobs").where("Email", isEqualTo: filterByEmail).get();
      final jobListByEmail = snapshot.docs.map((list) => JobModel.fromDatabase(list)).toList();
      return jobListByEmail;
    } else if (filterByCat != null && filterByEmail != null) {
      final snapshot = await _db.collection("Jobs").where("Email", isEqualTo: filterByEmail).where("Category", isEqualTo: filterByCat).get();
      final jobListByEmailByCat = snapshot.docs.map((list) => JobModel.fromDatabase(list)).toList();
      return jobListByEmailByCat;
    } else {
      final snapshot = await _db.collection("Jobs").orderBy("Date", descending: true).get();
      final jobListAll = snapshot.docs.map((jobs) => JobModel.fromDatabase(jobs)).toList();
      return jobListAll;
    }
  }

  Future<BidModel> getBidDetails(String bidId) async {
    final snapshot = await _db.collection("Bids").where(FieldPath.documentId, isEqualTo: bidId).get();
    final bidDetails = snapshot.docs.map((details) => BidModel.fromDatabase(details)).single;
    return bidDetails;
  }

  Future<BidModel> getAcceptedBidDetailsByJobID(String jobID) async {
    final snapshot = await _db.collection("Bids").where("JobID", isEqualTo: jobID).where("Status", isEqualTo: "Accepted").get();
    final bidDetails = snapshot.docs.map((details) => BidModel.fromDatabase(details)).single;
    return bidDetails;
  }

  // Fetch All Bids
  Future<List<BidModel>> getAllBids() async {
    final snapshot = await _db.collection("Bids").get();
    final bidData = snapshot.docs.map((bids) => BidModel.fromDatabase(bids)).toList();
    return bidData;
  }

  // Fetch All Bids By Filter (Email or JobID)
  Future<List<BidModel>> getAllBidsByFilter({String? filterByJobID, String? filterByEmail}) async {
    if (filterByJobID == null && filterByEmail == null) {
      final snapshot = await _db.collection("Bids").get();
      final bidListAll = snapshot.docs.map((bids) => BidModel.fromDatabase(bids)).toList();
      return bidListAll;
    } else if (filterByJobID != null && filterByEmail == null) {
      final snapshot = await _db.collection("Bids").where("JobID", isEqualTo: filterByJobID).get();
      final bidListByJobID = snapshot.docs.map((list) => BidModel.fromDatabase(list)).toList();
      return bidListByJobID;
    } else if (filterByJobID == null && filterByEmail != null) {
      final snapshot = await _db.collection("Bids").where("BidderEmail", isEqualTo: filterByEmail).get();
      final bidListByEmail = snapshot.docs.map((list) => BidModel.fromDatabase(list)).toList();
      return bidListByEmail;
    } else if (filterByJobID != null && filterByEmail != null) {
      final snapshot = await _db.collection("Bids").where("BidderEmail", isEqualTo: filterByEmail).where("JobID", isEqualTo: filterByJobID).get();
      final bidListByEmailByJobID = snapshot.docs.map((list) => BidModel.fromDatabase(list)).toList();
      return bidListByEmailByJobID;
    } else {
      final snapshot = await _db.collection("Bids").get();
      final bidListAll = snapshot.docs.map((bids) => BidModel.fromDatabase(bids)).toList();
      return bidListAll;
    }
  }

  // Fetch All Bids By Filter (Email or JobID)
  Future<List<BidModel>> getBalanceByAcceptedBid({String? balanceByBidEmail}) async {
    final snapshot = await _db.collection("Bids").where("BidderEmail", isEqualTo: balanceByBidEmail).where("Status", isEqualTo: "Accepted").get();
    final acceptedBids = snapshot.docs.map((bids) => BidModel.fromDatabase(bids)).toList();
    return acceptedBids;
  }

  // Write Before This
}
