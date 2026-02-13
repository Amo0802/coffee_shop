import 'package:flutter/material.dart';
import 'profile_settings_page.dart';
import 'notifications_page.dart';
import 'locations_page.dart';
import 'faq_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _openPage(BuildContext context, Widget Function(VoidCallback close) builder) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: builder(() => Navigator.of(ctx).pop()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: topPadding + 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF3B7A57),
            ),
            child: const Center(
              child: Text(
                'Hello Moa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Grid
          Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1.3,
              children: [
                _buildGridTile(
                  icon: Icons.person,
                  label: 'PROFILE',
                  onTap: () => _openPage(
                    context,
                    (close) => ProfileSettingsPage(onClose: close),
                  ),
                ),
                _buildGridTile(
                  icon: Icons.notifications_outlined,
                  label: 'NOTIFICATIONS',
                  badgeCount: 2,
                  onTap: () => _openPage(
                    context,
                    (close) => NotificationsPage(onClose: close),
                  ),
                ),
                _buildGridTile(
                  icon: Icons.location_on_outlined,
                  label: 'LOCATIONS',
                  onTap: () => _openPage(
                    context,
                    (close) => LocationsPage(onClose: close),
                  ),
                ),
                _buildGridTile(
                  icon: Icons.help_outline,
                  label: 'FAQ',
                  onTap: () => _openPage(
                    context,
                    (close) => FaqPage(onClose: close),
                  ),
                ),
              ],
            ),
          ),

          // Photo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/images/dog.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Privacy | Terms
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF3B7A57),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF3B7A57),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '|',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Terms of Use',
                  style: TextStyle(
                    color: Color(0xFF3B7A57),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF3B7A57),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Copyright
          Text(
            '© ${DateTime.now().year} MoaIT. All rights reserved.',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.35),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget _buildGridTile({
    required IconData icon,
    required String label,
    int badgeCount = 0,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 36, color: Colors.black87),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B7A57),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}