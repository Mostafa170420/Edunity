import 'package:edunity/core/model/msg_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/chat/widgets/chat_bubble.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:gap/gap.dart';

class ChatScreen extends StatefulWidget {
  // We'll pass the name of the person/mentor we are chatting with
  final String receiverName;
  final String? receiverImageUrl;

  const ChatScreen({
    super.key,
    required this.receiverName,
    this.receiverImageUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Mock messages for demonstration
  final List<MessageModel> _messages = [
    MessageModel(
      text:
          "Hi John! I saw your message about the Python course. How can I help you?",
      isMe: false,
      time: "9:30 AM",
    ),
    MessageModel(
      text:
          "Hello Professor. I was wondering if the prerequisites section is mandatory for the final project.",
      isMe: true,
      time: "9:32 AM",
    ),
    MessageModel(
      text:
          "That's a great question. The prerequisites are highly recommended to ensure you have a solid foundation, but the final project criteria only requires concepts from Module 4 onwards. You'll be fine!",
      isMe: false,
      time: "9:35 AM",
    ),
    MessageModel(
      text: "Perfect, thank you for the clarification!",
      isMe: true,
      time: "9:36 AM",
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          MessageModel(
            text: _messageController.text.trim(),
            isMe: true,
            time:
                "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
          ),
        );
        _messageController.clear();
      });
      // In a real app, you would also call a function here to send the message to a backend.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Message List Area
          Expanded(
            child: ListView.builder(
              reverse: true, // Show latest messages at the bottom
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Reverse the list index to display messages chronologically from bottom up
                final reversedIndex = _messages.length - 1 - index;
                return MessageBubble(message: _messages[reversedIndex]);
              },
            ),
          ),
          // Message Input Area
        ],
      ),
      bottomNavigationBar: _buildMessageInput(),
      resizeToAvoidBottomInset: true,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(IconlyLight.arrow_left_2,
            color: AppColors.darkgreyColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0, // Remove default title spacing
      title: Row(
        children: [
          // Circular Avatar for the mentor/receiver
          CircleAvatar(
            radius: 20,
            backgroundImage: widget.receiverImageUrl != null
                ? NetworkImage(widget.receiverImageUrl!)
                : null,
            child: widget.receiverImageUrl == null
                ? const Icon(
                    IconlyLight.profile,
                    color: AppColors.whiteColor,
                    size: 20,
                  )
                : null,
            backgroundColor: AppColors.primaryDarkColor.withOpacity(0.8),
          ),
          const Gap(12),
          Text(
            widget.receiverName,
            style: TextStyles.getBody(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.darkgreyColor,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(IconlyLight.call, color: AppColors.primaryDarkColor),
          onPressed: () {},
        ),
        IconButton(
          icon:
              const Icon(IconlyLight.video, color: AppColors.primaryDarkColor),
          onPressed: () {},
        ),
        const Gap(5),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        // Using box shadow for a lift effect, similar to CustomTextField
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Attachment button
            IconButton(
              icon: const Icon(IconlyLight.image,
                  color: AppColors.primaryDarkColor),
              onPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: _messageController,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: 'Message...',
                    hintStyle: TextStyles.getBody(
                        color: AppColors.greyColor, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    filled: true,
                    fillColor: AppColors.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            // Send button
            IconButton(
              icon: const Icon(IconlyLight.send,
                  color: AppColors.primaryDarkColor),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
