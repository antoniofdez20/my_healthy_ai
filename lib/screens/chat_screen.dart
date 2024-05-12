import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/models/models.dart';
import 'package:my_healthy_ai/utils/utils.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<AuthController>(builder: (controller) {
                return GroupedListView<Message, DateTime>(
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  elements: controller.messages,
                  groupBy: (message) => DateTime(
                      message.date.year, message.date.month, message.date.day),
                  groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            DateFormat.yMMMd().format(message.date),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, Message message) => Align(
                    alignment: message.isSentByUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Card(
                      color: message.isSentByUser
                          ? Colors.blue
                          : MyColors.prussianBlue,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextField(
                      hintTextCustom: 'Type a message',
                      controller: authController.messageController,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (authController.messageController.text.isNotEmpty) {
                        authController.sendMessage();
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            CustomNavigationBar(user: authController.firebaseUser.value),
      ),
    );
  }
}
