import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showNotifications = true;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primaryDarkColor;
    final inactiveColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Notifications & Messages',
            style: TextStyles.getSmall(),
          ),
        ),
      ),
      body: Column(
        children: [
          Gap(15),

          // --- Toggle Buttons Container ---
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // --- Notifications Button ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showNotifications = true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: showNotifications ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Notifications",
                          style: TextStyles.getSmall(
                            color: showNotifications
                                ? Colors.white
                                : AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // --- Messages Button ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showNotifications = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: !showNotifications ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Messages",
                          style: TextStyles.getSmall(
                            color: !showNotifications
                                ? Colors.white
                                : AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Gap(15),

          // --- Main Content ---
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showNotifications
                  ? _buildNotificationsList()
                  : _buildMessagesList(),
            ),
          ),
        ],
      ),
    );
  }

  // Dummy Notification list
  Widget _buildNotificationsList() {
    return Column(
      key: const ValueKey('notifications'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Notifications",
                  style: TextStyles.getSmall(fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {},
                child: Text("Clear All",
                    style: TextStyles.getSmall(
                        fontSize: 15, color: AppColors.primaryDarkColor)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return _buildCustomTile(
                icon: Icons.notifications,
                title: "Booking Confirmed ${index + 1}",
                description: "Your booking has been confirmed successfully.",
                unread: index < 3, // example: first 3 are unread
              );
            },
          ),
        ),
      ],
    );
  }

  // Dummy Messages list
  Widget _buildMessagesList() {
    return Column(
      key: const ValueKey('messages'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Messages",
                  style: TextStyles.getSmall(fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () {},
                child: Text("Clear All",
                    style: TextStyles.getSmall(
                        fontSize: 15, color: AppColors.primaryDarkColor)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return _buildCustomTile(
                icon: Icons.message,
                title: "Message ${index + 1}",
                description: "This is a sample message for the student.",
                unread: index == 0, // example: only first is unread
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTile({
    required IconData icon,
    required String title,
    required String description,
    required bool unread,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              icon,
              size: 30,
              color: AppColors.primaryDarkColor,
            ),
          ),

          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Dot + Delete button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                    if (unread)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {},
                      color: Colors.grey[600],
                      tooltip: 'Delete',
                    ),
                  ],
                ),

                // Description
                Text(
                  description,
                  style: TextStyles.getSmall(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 4),

                // Fixed Time Row
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "4 hrs ago",
                    style: TextStyles.getSmall(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
