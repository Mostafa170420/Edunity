import 'package:flutter/material.dart';

/// A model representing a chat conversation.
class ChatModel {
  /// The unique identifier for the chat.
  final String id;

  /// The name of the person the user is chatting with.
  final String receiverName;

  /// The URL of the receiver's profile image.
  final String? receiverImageUrl;

  /// The last message sent in the chat.
  final String lastMessage;

  /// The time the last message was sent.
  final String lastMessageTime;

  /// Whether the chat has unread messages.
  final bool isUnread;

  /// Creates a new [ChatModel] instance.
  ChatModel({
    required this.id,
    required this.receiverName,
    this.receiverImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isUnread = false,
  });
}

/// A list of fake chat data for demonstration purposes.
final List<ChatModel> fakeChats = [
  ChatModel(
    id: 'chat_1',
    receiverName: 'Dr. Ahmad Hassan',
    receiverImageUrl: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
    lastMessage: 'تمام، سأراجع الملاحظات وأرد عليك غدًا.',
    lastMessageTime: '10:05 AM',
    isUnread: true,
  ),
  ChatModel(
    id: 'chat_2',
    receiverName: 'Eng. Layla Ali',
    receiverImageUrl: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
    lastMessage: 'هل يمكننا تأجيل اجتماع التوجيه ليوم الثلاثاء؟',
    lastMessageTime: 'Yesterday',
    isUnread: false,
  ),
  ChatModel(
    id: 'chat_3',
    receiverName: 'Mr. Omar Tarek',
    receiverImageUrl: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
    lastMessage: 'Great progress on the final project!',
    lastMessageTime: 'Sun',
    isUnread: true,
  ),
  ChatModel(
    id: 'chat_4',
    receiverName: 'Student Support',
    receiverImageUrl: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
    lastMessage: 'Your payment was successfully processed.',
    lastMessageTime: '01/05/2024',
    isUnread: false,
  ),
];
