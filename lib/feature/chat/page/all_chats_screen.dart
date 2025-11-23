import 'package:edunity/core/models/chat_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/chat/widgets/chat_list_tile.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false, // لا يوجد زر رجوع افتراضي
        title: Text(
          'Chats', // Chats
          style: TextStyles.getTitle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkgreyColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              IconlyLight.search,
              color: AppColors.darkgreyColor,
            ),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(
              IconlyLight.edit, // icon to start a new chat
              color: AppColors.primaryDarkColor,
            ),
            onPressed: () {
              // TODO: Implement new chat functionality
            },
          ),
        ],
        // تطبيق نفس الظل الموجود في شاشات أخرى
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              color: AppColors.whiteColor, // Ensure the container itself is white
            ),
            height: 1.0, // Just a visual divider
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: fakeChats.length,
        itemBuilder: (context, index) {
          final chat = fakeChats[index];
          return ChatListTile(chat: chat);
        },
      ),
    );
  }
}
