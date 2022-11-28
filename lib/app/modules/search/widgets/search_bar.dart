import 'package:chat_app/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';

abstract class SearchBar extends GetView<SearchController> {
  static final searchC = Get.find<SearchController>();
  static final search = Padding(
    padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        controller: searchC.searchC,
        cursorColor: Colors.red[900],
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          hintText: "Search...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          suffixIcon: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Icon(
              Icons.search_outlined,
              color: Colors.red[900],
            ),
          ),
        ),
      ),
    ),
  );
}
