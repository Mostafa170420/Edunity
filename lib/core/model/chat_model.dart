import 'package:flutter/material.dart';

class ChatModel {
  final String id;
  final String receiverName;
  final String? receiverImageUrl;
  final String lastMessage;
  final String lastMessageTime;
  final bool isUnread;

  ChatModel({
    required this.id,
    required this.receiverName,
    this.receiverImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isUnread = false,
  });
}

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
