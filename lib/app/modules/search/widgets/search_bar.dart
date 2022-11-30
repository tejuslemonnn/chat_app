import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, this.controller, this.onChanged});

  final onChanged;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          cursorColor: Colors.red[900],
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            hintText: "Search...",
            contentPadding: const EdgeInsets.symmetric(
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
}
