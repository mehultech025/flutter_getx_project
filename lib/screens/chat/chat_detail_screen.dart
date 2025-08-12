import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/screens/chat/controller/chat_controller.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CustomTextWidget(
                        text: controller.userName.substring(0, 1).toUpperCase(),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomTextWidget(
                      text: controller.userName,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Message List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(controller.chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final messages = snapshot.data!.docs;

                    messages.sort((a, b) {
                      final aTime =
                          (a['timestamp'] as Timestamp?)?.toDate() ??
                          DateTime.now();
                      final bTime =
                          (b['timestamp'] as Timestamp?)?.toDate() ??
                          DateTime.now();
                      return aTime.compareTo(bTime);
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.scrollToBottom();
                    });

                    DateTime? lastDate;

                    return ListView.builder(
                      controller: controller.scrollController,
                      reverse: false,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isMe =
                            msg['sender'] == controller.currentUserName;
                        final timestamp = (msg['timestamp'] as Timestamp?)
                            ?.toDate();
                        final msgDate = timestamp != null
                            ? DateTime(
                                timestamp.year,
                                timestamp.month,
                                timestamp.day,
                              )
                            : null;

                        bool showDateHeader = false;
                        if (msgDate != null &&
                            (lastDate == null || msgDate != lastDate)) {
                          showDateHeader = true;
                          lastDate = msgDate;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showDateHeader)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CustomTextWidget(
                                      text: controller.formatDateHeader(
                                        msgDate!,
                                      ),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isMe)
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: CustomTextWidget(
                                      text: msg['sender']
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (!isMe) const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Colors.white.withOpacity(0.1)
                                          : Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(16),
                                        topRight: const Radius.circular(16),
                                        bottomLeft: Radius.circular(
                                          isMe ? 16 : 0,
                                        ),
                                        bottomRight: Radius.circular(
                                          isMe ? 0 : 16,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isMe
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                          text: msg['text'],
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 4),
                                        CustomTextWidget(
                                          text: timestamp != null
                                              ? "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}"
                                              : "Sending...",
                                          fontSize: 10,
                                          color: Colors.white70,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isMe) const SizedBox(width: 8),
                                if (isMe)
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: CustomTextWidget(
                                      text: controller.currentUserName
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              // Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CustomTextWidget(
                          text: controller.currentUserName
                              .substring(0, 1)
                              .toUpperCase(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Type your message...",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => controller.sendMessage(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.sendMessage(),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
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
