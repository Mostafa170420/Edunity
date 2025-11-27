import 'package:edunity/core/model/chat_model.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key, required this.chat});

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    // Determine the style based on whether the message is unread
    final titleStyle = TextStyles.getBody(
      fontSize: 16,
      fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w500,
      color: AppColors.darkgreyColor,
    );

    final subtitleStyle = TextStyles.getBody(
      fontSize: 14,
      fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w400,
      color: chat.isUnread ? AppColors.darkgreyColor : AppColors.greyColor,
    );
    
    final timeStyle = TextStyles.getSmall(
      fontSize: 12,
      fontWeight: chat.isUnread ? FontWeight.w700 : FontWeight.w400,
      color: chat.isUnread ? AppColors.primaryDarkColor : AppColors.greyColor,
    );

    return InkWell(
      onTap: () {
        // عند الضغط على المحادثة، ننتقل لشاشة الدردشة الفردية
        pushTo(
          context,
          Routes.chatScreen,
          extra: chat,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE5E7EB), // Very light border for separation
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundImage: chat.receiverImageUrl != null
                  ? NetworkImage(chat.receiverImageUrl!)
                  : null,
              backgroundColor: AppColors.primaryDarkColor.withOpacity(0.8),
              child: chat.receiverImageUrl == null
                  ? const Icon(
                      Icons.person,
                      color: AppColors.whiteColor,
                      size: 28,
                    )
                  : null,
            ),
            const Gap(15),

            // Name and Last Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.receiverName,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    chat.lastMessage,
                    style: subtitleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(10),

            // Time and Unread Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.lastMessageTime,
                  style: timeStyle,
                ),
                const Gap(8),
                if (chat.isUnread)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDarkColor, // Use primary color for unread dot
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
