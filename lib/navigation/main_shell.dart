import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../pages/home_page_1.dart';
import '../pages/profile_page.dart';
import '../pages/scan_screen.dart';

/// Central navigation shell.
///
/// To add a new page:
///   1. Add a [NavTab] entry to [_tabs].
///   2. Regular page  → set [isPopup] = false, provide [page].
///   3. Popup overlay → set [isPopup] = true, provide [popupBuilder].
///
/// The nav bar items are auto-generated from [_tabs].
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

// ─── Tab definition ────────────────────────────────────────────────

class NavTab {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  /// Regular page widget — used when [isPopup] is false.
  final Widget? page;

  /// If true, tapping this tab opens a popup instead of switching pages.
  final bool isPopup;

  /// Builder for the popup content — used when [isPopup] is true.
  final Widget Function(BuildContext context, VoidCallback close)? popupBuilder;

  const NavTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.page,
    this.isPopup = false,
    this.popupBuilder,
  }) : assert(
          isPopup ? popupBuilder != null : page != null,
        );
}

// ─── State ─────────────────────────────────────────────────────────

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // ════════════════════════════════════════════════════════════════
  //  TAB REGISTRY — edit this list to add / reorder / remove pages
  // ════════════════════════════════════════════════════════════════
  late final List<NavTab> _tabs = [
    const NavTab(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      page: HomePage1(),
    ),
    NavTab(
      label: 'Scan',
      icon: Icons.qr_code_scanner_rounded,
      activeIcon: Icons.qr_code_scanner_rounded,
      isPopup: true,
      popupBuilder: (context, close) => ScanScreen(
        onClose: close,
        onCodeScanned: (code) {
          close();
          // TODO: handle scanned code
        },
      ),
    ),
    const NavTab(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person_rounded,
      page: ProfilePage(),
    ),
  ];

  /// Indices of regular (non-popup) tabs for the IndexedStack.
  late final List<int> _pageTabIndices =
      _tabs.indexed.where((e) => !e.$2.isPopup).map((e) => e.$1).toList();

  /// Maps a tab index → its position inside the IndexedStack.
  int _stackPosition(int tabIndex) => _pageTabIndices.indexOf(tabIndex);

  /// Build NavBarItem list from _tabs (single source of truth).
  late final List<NavBarItem> _navBarItems = _tabs
      .map((t) => NavBarItem(
            label: t.label,
            icon: t.icon,
            activeIcon: t.activeIcon,
            canBeActive: !t.isPopup,
          ))
      .toList();

  void _onNavTap(int index) {
    final tab = _tabs[index];
    if (tab.isPopup) {
      _openPopup(tab);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  void _openPopup(NavTab tab) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: tab.popupBuilder!(ctx, () => Navigator.of(ctx).pop()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: IndexedStack(
                index: _stackPosition(_currentIndex),
                children: [
                  for (final i in _pageTabIndices) _tabs[i].page!,
                ],
              ),
            ),
            BottomNavBar(
              items: _navBarItems,
              currentIndex: _currentIndex,
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}