import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  String? id;
  String? createdBy;
  String? email;
  String? category;
  String? status;
  final String jobTitle;
  final String location;
  final num budget;
  final String description;
  final String? additionalInfo;
  final DateTime date;

  JobModel(
      {this.id,
      required this.jobTitle,
      this.category,
      this.status,
      required this.location,
      required this.budget,
      required this.description,
      this.additionalInfo,
      this.createdBy,
      this.email,
      required this.date}) {
    createdBy ??= "Admin";
    email ??= "admin@tukitakisomadhan.com";
    category ??= "Other Services...";
    status ??= "Hiring";
  }

  toJson() {
    return {
      "JobTitle": jobTitle,
      "Category": category,
      "Status": status,
      "Location": location,
      "Budget": budget,
      "Description": description,
      "MoreInfo": additionalInfo,
      "Date": date,
      "CreatedBy": createdBy,
      "Email": email,
    };
  }

  factory JobModel.fromDatabase(DocumentSnapshot<Map<String, dynamic>> document) {
    final jobData = document.data()!;

    parseDate(data) {
      if (data == null || data == "") {
        return DateTime.parse("2023-03-12T18:42:49.608466Z");
      } else {
        final timeToMS = data.millisecondsSinceEpoch;
        return DateTime.fromMillisecondsSinceEpoch(timeToMS);
      }
    }

    return JobModel(
      id: document.id,
      jobTitle: jobData["JobTitle"],
      category: jobData["Category"] == null
          ? "Missing"
          : jobData["Category"] == ""
              ? "Not Specified"
              : jobData["Category"],
      status: jobData["Status"] ?? "Missing",
      email: jobData["Email"] ?? "Missing",
      location: jobData["Location"],
      budget: jobData["Budget"],
      description: jobData["Description"],
      additionalInfo: jobData["MoreInfo"],
      date: parseDate(jobData["Date"]),
      createdBy: jobData["CreatedBy"],
    );
  }
}
