import 'package:flutter/material.dart';

class _LocationData {
  final String name;
  final String address;
  final String hours;
  final bool isOpen;

  const _LocationData({
    required this.name,
    required this.address,
    required this.hours,
    required this.isOpen,
  });
}

class LocationsPage extends StatelessWidget {
  final VoidCallback? onClose;

  const LocationsPage({super.key, this.onClose});

  static const List<_LocationData> _locations = [
    _LocationData(
      name: 'Downtown Roastery',
      address: '123 Main Street',
      hours: '7:00 – 20:00',
      isOpen: true,
    ),
    _LocationData(
      name: 'Central Station Kiosk',
      address: '45 Station Road',
      hours: '6:00 – 22:00',
      isOpen: true,
    ),
    _LocationData(
      name: 'Riverside Café',
      address: '78 River Walk',
      hours: '8:00 – 18:00',
      isOpen: false,
    ),
    _LocationData(
      name: 'University Corner',
      address: '12 Campus Drive',
      hours: '7:30 – 21:00',
      isOpen: true,
    ),
    _LocationData(
      name: 'Westside Brew Bar',
      address: '300 West Avenue',
      hours: '9:00 – 17:00',
      isOpen: false,
    ),
  ];

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
                    'Locations',
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

            // ── Map placeholder ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.7),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.map_rounded,
                        size: 44,
                        color: Colors.black.withValues(alpha: 0.12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Map coming soon',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Location list ──
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: bottomPadding + 20,
                ),
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  final loc = _locations[index];
                  return _LocationTile(location: loc);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  final _LocationData location;

  const _LocationTile({required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.50),
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
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                size: 22,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    location.address,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location.hours,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: location.isOpen
                    ? const Color(0xFF3B7A57).withValues(alpha: 0.12)
                    : Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                location.isOpen ? 'Open' : 'Closed',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: location.isOpen
                      ? const Color(0xFF3B7A57)
                      : Colors.red.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
