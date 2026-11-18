import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<ChatConversation> _activeChats = [
    ChatConversation(
      id: '1',
      name: 'Burger King Support',
      lastMessage: 'Your order #ORD-001 is being prepared',
      time: '2 min ago',
      unreadCount: 2,
      isSupport: true,
      avatarUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100',
    ),
    ChatConversation(
      id: '2',
      name: 'Pizza Palace',
      lastMessage: 'Driver Mike is on the way',
      time: '5 min ago',
      unreadCount: 1,
      isSupport: false,
      avatarUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=100',
    ),
    ChatConversation(
      id: '3',
      name: 'Sushi Express',
      lastMessage: 'Order delivered successfully!',
      time: '1 hour ago',
      unreadCount: 0,
      isSupport: false,
      avatarUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=100',
    ),
  ];

  final List<ChatConversation> _supportChats = [
    ChatConversation(
      id: '4',
      name: 'Foodie Customer Support',
      lastMessage: 'How can we help you today?',
      time: 'Yesterday',
      unreadCount: 0,
      isSupport: true,
      avatarUrl: 'https://images.unsplash.com/photo-1551434678-e076c223a692?w=100',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Messages', style: AppTextStyles.headline3Bold),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.black60,
          labelStyle: AppTextStyles.headline5Semibold,
          unselectedLabelStyle: AppTextStyles.headline5Medium,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Support'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatList(_activeChats),
          _buildChatList(_supportChats),
        ],
      ),
    );
  }

  Widget _buildChatList(List<ChatConversation> chats) {
    if (chats.isEmpty) {
      return _buildEmptyState();
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return _buildChatTile(chats[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightGrey10,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.chat_bubble_outline_rounded, size: 50, color: AppColors.black40),
            ),
            const SizedBox(height: 24),
            Text('No messages yet', style: AppTextStyles.headline3Bold),
            const SizedBox(height: 8),
            Text(
              'Your conversations will appear here',
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTile(ChatConversation chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: chat.unreadCount > 0 ? AppColors.primary.withValues(alpha: 0.3) : AppColors.lightGrey60,
          width: chat.unreadCount > 0 ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            if (chat.isSupport)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: const Icon(Icons.headset_mic_rounded, size: 10, color: AppColors.onPrimary),
                ),
              ),
          ],
        ),
        title: Text(chat.name, style: AppTextStyles.headline5Semibold),
        subtitle: Text(
          chat.lastMessage,
          style: AppTextStyles.placeholder1Regular.copyWith(
            color: chat.unreadCount > 0 ? AppColors.onSurface : AppColors.black60,
            fontWeight: chat.unreadCount > 0 ? FontWeight.w500 : FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(chat.time, style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.black60)),
            if (chat.unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  chat.unreadCount.toString(),
                  style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.onPrimary, fontSize: 10),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          // Navigate to chat detail
        },
      ),
    );
  }
}

class ChatConversation {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isSupport;
  final String avatarUrl;

  const ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isSupport,
    required this.avatarUrl,
  });
}