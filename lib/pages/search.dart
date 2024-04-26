import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaper/models/photo_model.dart';
import 'package:flutter_app_wallpaper/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchcontroller = TextEditingController();
  bool search = false;
  getSearchWallpaper(String searchQuery) async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$searchQuery&per_page=30'),
        headers: {
          "Authorization":
              "Ya6ExrNroolKxEOHJEt2mf3zuSBcPUyzo8DUaactmrn0hxaDihDfF7et"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData['photos'].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {
        search = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Center(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextField(
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        getSearchWallpaper(searchcontroller.text);
                      },
                      child: search
                          ? GestureDetector(
                              onTap: () {
                                photos = [];
                                search = false;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 84, 87, 93),
                              ),
                            )
                          : Icon(
                              Icons.search_outlined,
                              color: Color.fromARGB(255, 84, 87, 93),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: wallpaper(photos, context)),
          ],
        ),
      ),
    );
  }
}
