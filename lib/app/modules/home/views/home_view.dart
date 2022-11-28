import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> myChats = List.generate(
      20,
      (index) => ListTile(
        onTap: () => Get.toNamed(Routes.CHAT_ROOM),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black26,
          child: Image.asset(
            "assets/logo/noimage.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Lorem ${index + 1}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          "Status Lorem",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Chip(
          label: Text(
            "3",
          ),
        ),
      ),
    ).reversed.toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(
          Icons.message_rounded,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Material(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      color: Colors.red[900],
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.PROFILE),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => myChats[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
