import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  ChangeProfileView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Change Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              AvatarGlow(
                endRadius: 110,
                glowColor: Colors.black,
                duration: const Duration(seconds: 2),
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: authC.user.photoUrl == "noimage"
                        ? Image.asset("assets/logo/noimage.png")
                        : Image.network(
                            "${authC.user.photoUrl}",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              TextField(
                controller: controller.emailC,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.nameC,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.statusC,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("No Image"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Choose Image"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
