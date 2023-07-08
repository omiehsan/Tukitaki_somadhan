import 'package:cloud_firestore/cloud_firestore.dart';

class BidModel {
  final String? id;
  final String? jobID;
  final String? bidderName;
  final String? bidderEmail;
  final String location;
  final num askingPrice;
  final String bidderDescription;
  String? status;

  BidModel({
    this.id,
    this.jobID,
    this.bidderName,
    this.bidderEmail,
    required this.location,
    required this.askingPrice,
    required this.bidderDescription,
    this.status,
  }) {
    status ??= "Pending";
  }

  toJson() {
    return {
      "JobID": jobID,
      "BidderName": bidderName,
      "BidderEmail": bidderEmail,
      "Location": location,
      "AskingPrice": askingPrice,
      "Description": bidderDescription,
      "Status": status,
    };
  }

  factory BidModel.fromDatabase(DocumentSnapshot<Map<String, dynamic>> document) {
    final bidData = document.data()!;

    return BidModel(
        id: document.id,
        jobID: bidData["JobID"],
        bidderName: bidData["BidderName"],
        bidderEmail: bidData["BidderEmail"],
        location: bidData["Location"],
        askingPrice: bidData["AskingPrice"],
        bidderDescription: bidData["Description"],
        status: bidData["Status"] ?? "Missing");
  }
}
