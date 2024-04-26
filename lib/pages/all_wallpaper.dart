// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_wallpaper/models/photo_model.dart';
// import 'package:flutter_app_wallpaper/service/database.dart';
// import 'package:flutter_app_wallpaper/widget/widget.dart';

// class AllWallpaper extends StatefulWidget {
//   String category;
//   AllWallpaper({
//     Key? key,
//     required this.category,
//   }) : super(key: key);

//   @override
//   State<AllWallpaper> createState() => _AllWallpaperState();
// }

// class _AllWallpaperState extends State<AllWallpaper> {
//   Stream? categoryStream;
//   getontheload() async {
//     categoryStream = await DatabaseMethods().getCategory(widget.category);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     getontheload();
//   }

//   Widget allWallpaper() {
//     return StreamBuilder(
//         stream: categoryStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? GridView.builder(
//                   padding: EdgeInsets.zero,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.6,
//                     mainAxisSpacing: 10.0,
//                     crossAxisSpacing: 10.0,
//                   ),
//                   itemCount: snapshot.data.docs.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return Container(
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             ds['Image'],
//                             fit: BoxFit.cover,
//                           )),
//                     );
//                   })
//               : Container();
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(top: 60, left: 10, right: 10),
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 widget.category,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(child: allWallpaper()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaper/pages/full_screen.dart';
import 'package:flutter_app_wallpaper/service/database.dart';

class AllWallpaper extends StatefulWidget {
  final String category;

  const AllWallpaper({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<AllWallpaper> createState() => _AllWallpaperState();
}

class _AllWallpaperState extends State<AllWallpaper> {
  late Stream categoryStream;

  @override
  void initState() {
    super.initState();
    getOnLoad();
  }

  void getOnLoad() async {
    categoryStream = await DatabaseMethods().getCategory(widget.category);
    setState(() {});
  }

  Widget allWallpaper() {
    return StreamBuilder(
      stream: categoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreen(
                            imagepath: ds['Image'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          ds['Image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 10, right: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.category,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: allWallpaper()),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
