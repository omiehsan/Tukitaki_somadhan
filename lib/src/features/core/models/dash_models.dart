import 'dart:math';

import '../../../constants/categories.dart';

class DashCategoriesModel {
  final String catName;
  final String catImage;
  int? catExperts;
  int? catJobs;
  // final VoidCallback? onTap;

  DashCategoriesModel(this.catName, this.catImage, {this.catExperts, this.catJobs}) {
    catExperts ??= Random().nextInt(650);
    catJobs ??= Random().nextInt(89);

    // if (catExperts == null) {
    //   catExperts = Random().nextInt(650);
    // } else {
    //   catExperts = catExperts;
    // }
    //
    // if (catJobs == null) {
    //   catJobs = Random().nextInt(89);
    // } else {
    //   catJobs = catJobs;
    // }
  }

  static List<DashCategoriesModel> catItems = [
    DashCategoriesModel(Ac_Servicing_Title, Ac_Services_Image, catExperts: 19, catJobs: 657),
    DashCategoriesModel(Appliance_Title, Appliance_Image),
    DashCategoriesModel(Car_Title, Car_Image),
    DashCategoriesModel(Electronics_Title, Electronics_Image),
    DashCategoriesModel(Painting_Title, Painting_Image),
    DashCategoriesModel(Plumbing_Title, Plumbing_Image),
    DashCategoriesModel(Motorcycle_Service_Title, Motorcycle_Service_Image),
    DashCategoriesModel(Mobile_Servicing_Title, Mobile_Servicing_Image),
    DashCategoriesModel(Computer_Servicing_Title, Computer_Servicing_Image),
    DashCategoriesModel(Moving_Servicing_Title, Moving_Servicing_Image),
    // DashCategoriesModel(SEO_Title, Moving_ServicingSEO_Image),
    // DashCategoriesModel(Social_Title, Social_Image),
    // DashCategoriesModel(Video_Animation_Title, Video_Animation_Image),
    // DashCategoriesModel(Music_Audio_Title, Music_Audio_Image),
    // DashCategoriesModel(Voice_Over_Title, Voice_Over_Image),
    // DashCategoriesModel(Writing_Translatation_Title, Writing_Translatation_Image),
    // DashCategoriesModel(Data_Entry_Title, Data_Entry_Image),
    // DashCategoriesModel(Lifestyle_Title, Lifestyle_Image),
    // DashCategoriesModel(Business_Title, Business_Image),
  ];
}
