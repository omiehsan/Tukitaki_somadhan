import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/features/core/controllers/bid_controller.dart';
import 'package:tasking/src/features/core/controllers/job_controller.dart';

import '../../../../constants/sizes.dart';
import '../../../../repository/common_repo/common_controller.dart';
import '../../../auth/models/users_model.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';

class BiddingJobFormWidget extends StatelessWidget {
  const BiddingJobFormWidget({Key? key, required this.jobID}) : super(key: key);

  final String? jobID;

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final jobController = Get.put(JobPostController());
    final bidController = Get.put(BidPostController());
    final userCommonCtrl = Get.put(CommonUseController());

    double jobMaxPrice = 950.00;

    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: jobController.getJobDetails(jobID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      JobModel jobDetails = snapshot.data! as JobModel;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            jobMaxPrice = double.parse(jobDetails.budget.toString());
                            return const Text("");
                          });
                    } else if (snapshot.hasError) {
                      // return const Center(child: Text("Something Went Wrong!"));
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Please Login In To Continue..."));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: TTS_DefaultSize - 10),
              TextFormField(
                controller: bidController.location,
                validator: (value) {
                  // Is Empty Validation2
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Area';
                  }

                  // Return Null If Valid
                  return null;
                },
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.pin_drop_outlined), label: Text("Location"), hintText: "Sector #10, Uttara, Dhaka"),
              ),
              const SizedBox(height: TTS_DefaultSize - 10),
              TextFormField(
                controller: bidController.askingPrice,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  // Is Empty Validation
                  if (value == null || value.isEmpty) {
                    return 'Please Ask Your Price';
                  }
                  if (double.parse(value) > jobMaxPrice) {
                    return 'Client\'s Max Budget ৳$jobMaxPrice';
                  }

                  // Return Null If Valid
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(LineAwesomeIcons.hand_holding_us_dollar),
                    label: const Text("Your Offer Price"),
                    hintText: "eg. ${jobMaxPrice}"),
              ),
              const SizedBox(height: TTS_DefaultSize - 10),
              TextFormField(
                controller: bidController.bidderDescription,
                validator: (value) {
                  // Is Empty Validation
                  if (value == null || value.isEmpty) {
                    return 'Bidder Description is Required';
                  }
                  // Return Null If Valid
                  return null;
                },
                maxLines: 4,
                decoration: const InputDecoration(
                    // prefixIcon: Icon(Icons.bookmark),
                    label: Text("Bidder Description"),
                    hintText: "Please Provide Expertise"),
              ),
              const SizedBox(height: TTS_DefaultSize - 10),
              SizedBox(
                width: double.infinity,
                child: FutureBuilder(
                    future: userCommonCtrl.getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;

                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final bidData = BidModel(
                                  jobID: jobID.toString(),
                                  bidderName: userData.fullName.toString(),
                                  bidderEmail: userData.email.toString(),
                                  location: bidController.location.text.trim(),
                                  askingPrice: double.parse(bidController.askingPrice.text.trim()),
                                  bidderDescription: bidController.bidderDescription.text.trim(),
                                );
                                BidPostController.instance.createBidPost(bidData);
                              }
                            },
                            child: Text("Bid On The Post".toUpperCase()),
                          );
                        } else if (snapshot.hasError) {
                          // return const Center(child: Text("Something Went Wrong!"));
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(child: Text("Please Login In To Continue..."));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
