import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leadingWidth: 90,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Image.asset("assets/logo/noimage.png"),
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lorem",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "Status Lorem",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (controller.isShowEmoji.isTrue) {
            controller.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }

          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: const [
                    bubble_chat(
                      isSender: true,
                    ),
                    bubble_chat(
                      isSender: false,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: controller.isShowEmoji.isTrue
                      ? 5
                      : context.mediaQueryPadding.bottom),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: Get.width,
              height: 100,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: TextField(
                          controller: controller.chatC,
                          focusNode: controller.focusNode,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                controller.focusNode.unfocus();
                                controller.isShowEmoji.toggle();
                              },
                              icon: const Icon(Icons.emoji_emotions_outlined),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red[900],
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => (controller.isShowEmoji.isTrue)
                  ? SizedBox(
                      height: 300,
                      child: EmojiPicker(
                        onBackspacePressed: () {
                          controller.deleteEmoji();
                        },
                        onEmojiSelected: (category, emoji) {
                          controller.addEmojiToCHat(emoji);
                        },
                        config: const Config(
                          columns: 7,
                          emojiSizeMax: 32,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Color(0xFFB71C1C),
                          iconColor: Colors.grey,
                          iconColorSelected: Color(0xFFB71C1C),
                          backspaceColor: Color(0xFFB71C1C),
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecents: Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          // Needs to be const Widget
                          loadingIndicator: SizedBox.shrink(),
                          // Needs to be const Widget
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class bubble_chat extends StatelessWidget {
  const bubble_chat({
    Key? key,
    required this.isSender,
  }) : super(key: key);

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isSender
          ? const EdgeInsets.fromLTRB(50, 15, 15, 15)
          : const EdgeInsets.fromLTRB(20, 15, 50, 15),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: isSender
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
            ),
            child: const Text(
              "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "10:20 PM ",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
