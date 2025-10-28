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

// بيانات وهمية (Fake Data) لعرض قائمة المحادثات
final List<ChatModel> mockChats = [
  ChatModel(
    id: 'chat_1',
    receiverName: 'Dr. Ahmad Hassan',
    receiverImageUrl: 'https://placehold.co/100x100/4C7FFF/FFFFFF?text=AH',
    lastMessage: 'تمام، سأراجع الملاحظات وأرد عليك غدًا.',
    lastMessageTime: '10:05 AM',
    isUnread: true,
  ),
  ChatModel(
    id: 'chat_2',
    receiverName: 'Eng. Layla Ali',
    receiverImageUrl: 'https://placehold.co/100x100/6A99FF/FFFFFF?text=LA',
    lastMessage: 'هل يمكننا تأجيل اجتماع التوجيه ليوم الثلاثاء؟',
    lastMessageTime: 'Yesterday',
    isUnread: false,
  ),
  ChatModel(
    id: 'chat_3',
    receiverName: 'Mr. Omar Tarek',
    receiverImageUrl: 'https://placehold.co/100x100/FFA500/FFFFFF?text=OT',
    lastMessage: 'Great progress on the final project!',
    lastMessageTime: 'Sun',
    isUnread: true,
  ),
  ChatModel(
    id: 'chat_4',
    receiverName: 'Student Support',
    receiverImageUrl: 'https://placehold.co/100x100/4CAF50/FFFFFF?text=SS',
    lastMessage: 'Your payment was successfully processed.',
    lastMessageTime: '01/05/2024',
    isUnread: false,
  ),
];
