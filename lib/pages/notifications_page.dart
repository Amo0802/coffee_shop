import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final VoidCallback? onClose;

  const NotificationsPage({super.key, this.onClose});

  void _handleClose(BuildContext context) {
    if (onClose != null) {
      onClose!();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6EDE4),
              Color(0xFFE8D9C8),
              Color(0xFFD2B8A3),
            ],
          ),
        ),
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: EdgeInsets.only(
                top: topPadding + 14,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => _handleClose(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.8),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            // ── Notification list ──
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: bottomPadding + 20,
                ),
                children: const [
                  _NotificationTile(
                    icon: Icons.local_offer_rounded,
                    title: 'Double points this weekend!',
                    subtitle: 'Earn 2x points on all purchases Saturday & Sunday.',
                    time: '2h ago',
                    isUnread: true,
                  ),
                  _NotificationTile(
                    icon: Icons.card_giftcard_rounded,
                    title: 'New reward available',
                    subtitle: 'Premium Coffee Box just added to rewards.',
                    time: '1d ago',
                    isUnread: true,
                  ),
                  _NotificationTile(
                    icon: Icons.coffee_rounded,
                    title: 'You earned a stamp!',
                    subtitle: 'Only 7 more to go for a free coffee.',
                    time: '3d ago',
                    isUnread: false,
                  ),
                  _NotificationTile(
                    icon: Icons.celebration_rounded,
                    title: 'Welcome to the loyalty program!',
                    subtitle: 'Start collecting stamps and earning points.',
                    time: '1w ago',
                    isUnread: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const _NotificationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread
              ? Colors.white.withValues(alpha: 0.65)
              : Colors.white.withValues(alpha: 0.40),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isUnread
                    ? Colors.black
                    : Colors.black.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isUnread ? Colors.white : Colors.black38,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isUnread ? FontWeight.w700 : FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B7A57),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.45),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withValues(alpha: 0.25),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
