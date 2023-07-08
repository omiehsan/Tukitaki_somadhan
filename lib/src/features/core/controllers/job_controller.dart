import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/user_repo/user_repo.dart';
import '../models/job_model.dart';

class JobPostController extends GetxController {
  static JobPostController get instance => Get.find();

  final _userRepo = Get.put(UserRepo());

  // TextFormField Controllers To Get Form Data

  final jobTitle = TextEditingController();
  final category = TextEditingController();
  final location = TextEditingController();
  final budget = TextEditingController();
  final description = TextEditingController();
  final additionalInfo = TextEditingController();

  // All List of All JObs
  getAllJobs() {
    return _userRepo.getAllJobs();
  }

  // Get Job Details By ID
  getJobDetails(jobId) {
    if (jobId != null) {
      return _userRepo.getJobDetails(jobId);
    } else {
      return "Unknown";
    }
  }

  // Get Job List By Filter
  getAllJobsByFilter({String? filterByCat, String? filterByEmail, String? filterByStatus}) {
    return _userRepo.getAllJobsByFilter(filterByCat, filterByEmail, filterByStatus);
  }

  Future<void> createJobPost(JobModel jobData) async {
    _userRepo.createJobDoc(jobData);
  }

  Future<void> acceptDelivery({required String jobID}) async {
    _userRepo.acceptDelivery(jobID: jobID);
  }

  Future<void> deliverOrder({required String jobID}) async {
    _userRepo.deliverOrder(jobID: jobID);
  }
}
