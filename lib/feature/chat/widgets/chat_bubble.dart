import 'package:edunity/core/models/msg_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    // Determine alignment and colors based on who sent the message
    final isMe = message.isMe;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    
    // Rounded corners configuration
    final borderRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          );

    // Sender's bubble uses the primary gradient for that 'Messenger' look
    final boxDecoration = isMe
        ? BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryDarkColor, AppColors.primaryLightColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            color: AppColors.primaryDarkColor, // Lighter grey for incoming messages
            borderRadius: borderRadius,
          );

    final textColor = isMe ? AppColors.whiteColor : AppColors.darkgreyColor;
    final timeColor = isMe
        ? AppColors.whiteColor.withOpacity(0.7)
        : AppColors.greyColor.withOpacity(0.7);

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyles.getBody(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(4),
            Text(
              message.time,
              style: TextStyles.getSmall(
                color: timeColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
