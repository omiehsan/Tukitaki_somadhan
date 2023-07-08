import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/models/bid_model.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../repository/user_repo/user_repo.dart';

class BidPostController extends GetxController {
  static BidPostController get instance => Get.find();

  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());

  // TextFormField Controllers To Get Form Data

  // final bidBy = TextEditingController();
  final location = TextEditingController();
  final askingPrice = TextEditingController();
  final bidderDescription = TextEditingController();

  //
  getBidDetails(bidId) {
    if (bidId != null) {
      return _userRepo.getBidDetails(bidId);
    } else {
      return "Unknown";
    }
  }

  getAcceptedBidDetailsByJobID(jobID) {
    if (jobID != null) {
      return _userRepo.getAcceptedBidDetailsByJobID(jobID);
    } else {
      return "Unknown";
    }
  }

  getAllBids() {
    return _userRepo.getAllBids();
  }

  // Get Bids List By Filter
  getAllBidsByFilter({String? filterByJobID, String? filterByEmail}) {
    return _userRepo.getAllBidsByFilter(filterByJobID: filterByJobID, filterByEmail: filterByEmail);
  }

  // Get Account Balance By Bid Status
  getBalanceByAcceptedBid({String? balanceByBidEmail}) {
    return _userRepo.getBalanceByAcceptedBid(balanceByBidEmail: balanceByBidEmail);
  }

  Future<void> createBidPost(BidModel bidData) async {
    _userRepo.createBidDoc(bidData);
  }

  Future<void> acceptBidPost({required String bidID, required String jobID}) async {
    _userRepo.acceptBid(bidID: bidID, jobID: jobID);
  }
}
