import 'package:flutter/material.dart';

class DashBlogTiles extends StatelessWidget {
  const DashBlogTiles({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text("");

    //   SizedBox(
    //   height: 373,
    //   child: ListView(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     children: [
    //       Container(
    //         height: 353,
    //         width: 400,
    //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //         child: Card(
    //           clipBehavior: Clip.antiAlias,
    //           elevation: 5,
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 70,
    //                 child: ListTile(
    //                   tileColor: TTS_LogoColor.withOpacity(0.9),
    //                   leading: CircleAvatar(
    //                     radius: 20,
    //                     backgroundColor: Colors.white,
    //                     child: const CircleAvatar(
    //                       radius: 18,
    //                       backgroundImage: AssetImage(TTS_Dash_Blog_Cont_Author_Img_1),
    //                       backgroundColor: Colors.white,
    //                     ),
    //                   ),
    //                   trailing: const Icon(Icons.verified, color: Colors.black),
    //                   title: Text(
    //                     TTS_Dash_Blog_Cont_Title_1,
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.subtitle2?.apply(color: Colors.white.withOpacity(0.9)),
    //                   ),
    //                   subtitle: Text(
    //                     "$TTS_Dash_Blog_Cont_Author_1 - Curated Contents",
    //                     style: textTheme.bodyText2?.apply(color: Colors.white.withOpacity(0.5)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 150,
    //                 width: double.infinity,
    //                 child: const Image(
    //                   image: AssetImage(TTS_DashBlog_Cont_FeaImg_1),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 85,
    //                 child: Container(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Text(
    //                     TTS_Dash_Blog_Cont_Subtitle_1,
    //                     maxLines: 3,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.6)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 40,
    //                 child: Container(
    //                   color: Colors.grey.shade100,
    //                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       TextButton(child: const Text(TTS_Read_More), onPressed: () {}),
    //                       Row(
    //                         children: [
    //                           IconButton(
    //                             icon: const Icon(Icons.favorite_outline_sharp, color: Colors.redAccent),
    //                             onPressed: () {},
    //                           ),
    //                           IconButton(
    //                             icon: const Icon(Icons.share, color: Colors.green),
    //                             onPressed: () {},
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         height: 353,
    //         width: 400,
    //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //         child: Card(
    //           clipBehavior: Clip.antiAlias,
    //           elevation: 5,
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 70,
    //                 child: ListTile(
    //                   tileColor: TTS_LogoColor.withOpacity(0.9),
    //                   leading: CircleAvatar(
    //                     radius: 20,
    //                     backgroundColor: Colors.white,
    //                     child: const CircleAvatar(
    //                       radius: 18,
    //                       backgroundImage: AssetImage(TTS_Dash_Blog_Cont_Author_Img_2),
    //                       backgroundColor: Colors.white,
    //                     ),
    //                   ),
    //                   trailing: const Icon(Icons.verified, color: Colors.black),
    //                   title: Text(
    //                     TTS_Dash_Blog_Cont_Title_2,
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.subtitle2?.apply(color: Colors.white.withOpacity(0.9)),
    //                   ),
    //                   subtitle: Text(
    //                     "$TTS_Dash_Blog_Cont_Author_2 - Curated Contents",
    //                     style: textTheme.bodyText2?.apply(color: Colors.white.withOpacity(0.5)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 150,
    //                 width: double.infinity,
    //                 child: const Image(
    //                   image: AssetImage(TTS_DashBlog_Cont_FeaImg_2),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 85,
    //                 child: Container(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Text(
    //                     TTS_Dash_Blog_Cont_Subtitle_2,
    //                     maxLines: 3,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.6)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 40,
    //                 child: Container(
    //                   color: Colors.grey.shade100,
    //                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       TextButton(child: const Text(TTS_Read_More), onPressed: () {}),
    //                       Row(
    //                         children: [
    //                           IconButton(
    //                             icon: const Icon(Icons.favorite_outline_sharp, color: Colors.redAccent),
    //                             onPressed: () {},
    //                           ),
    //                           IconButton(
    //                             icon: const Icon(Icons.share, color: Colors.green),
    //                             onPressed: () {},
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         height: 353,
    //         width: 400,
    //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //         child: Card(
    //           clipBehavior: Clip.antiAlias,
    //           elevation: 5,
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 70,
    //                 child: ListTile(
    //                   tileColor: TTS_LogoColor.withOpacity(0.9),
    //                   leading: CircleAvatar(
    //                     radius: 20,
    //                     backgroundColor: Colors.white,
    //                     child: const CircleAvatar(
    //                       radius: 18,
    //                       backgroundImage: AssetImage(TTS_Dash_Blog_Cont_Author_Img_3),
    //                       backgroundColor: Colors.white,
    //                     ),
    //                   ),
    //                   trailing: const Icon(Icons.verified, color: Colors.black),
    //                   title: Text(
    //                     TTS_Dash_Blog_Cont_Title_3,
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.subtitle2?.apply(color: Colors.white.withOpacity(0.9)),
    //                   ),
    //                   subtitle: Text(
    //                     "$TTS_Dash_Blog_Cont_Author_3 - Curated Contents",
    //                     style: textTheme.bodyText2?.apply(color: Colors.white.withOpacity(0.5)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 150,
    //                 width: double.infinity,
    //                 child: const Image(
    //                   image: AssetImage(TTS_DashBlog_Cont_FeaImg_3),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 85,
    //                 child: Container(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Text(
    //                     TTS_Dash_Blog_Cont_Subtitle_3,
    //                     maxLines: 3,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.6)),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 40,
    //                 child: Container(
    //                   color: Colors.grey.shade100,
    //                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       TextButton(child: const Text(TTS_Read_More), onPressed: () {}),
    //                       Row(
    //                         children: [
    //                           IconButton(
    //                             icon: const Icon(Icons.favorite_outline_sharp, color: Colors.redAccent),
    //                             onPressed: () {},
    //                           ),
    //                           IconButton(
    //                             icon: const Icon(Icons.share, color: Colors.green),
    //                             onPressed: () {},
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
