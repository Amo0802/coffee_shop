import 'package:flutter/material.dart';

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}

class FaqPage extends StatefulWidget {
  final VoidCallback? onClose;

  const FaqPage({super.key, this.onClose});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  static const List<_FaqItem> _faqs = [
    _FaqItem(
      question: 'How do I earn stamps?',
      answer:
          'Simply scan the QR code on your receipt after each purchase. Each qualifying drink earns you one stamp towards a free coffee.',
    ),
    _FaqItem(
      question: 'How many stamps do I need for a free coffee?',
      answer:
          'Collect 8 stamps to unlock a free coffee. Once unlocked, tap the Collect button on your home screen to claim your reward.',
    ),
    _FaqItem(
      question: 'How do points work?',
      answer:
          'You earn points with every purchase. Points can be redeemed in the Rewards section for drinks, combos, and other items. Different rewards require different point amounts.',
    ),
    _FaqItem(
      question: 'Do my points expire?',
      answer:
          'Points reset periodically — check the reset date shown on your home screen. Make sure to redeem your points before the reset!',
    ),
    _FaqItem(
      question: 'I scanned my receipt but didn\'t get a stamp. What do I do?',
      answer:
          'Try using the manual code entry option on the Scan screen. Enter the code printed on your receipt. If the issue persists, tap "Having trouble?" for support.',
    ),
    _FaqItem(
      question: 'Can I use rewards at any location?',
      answer:
          'Yes! All rewards can be redeemed at any of our participating locations. Just show the QR code from your reward to the cashier.',
    ),
    _FaqItem(
      question: 'How do I update my profile?',
      answer:
          'Go to the Profile section and tap the Profile tile. From there you can update your name, email, and password.',
    ),
  ];

  int _expandedIndex = -1;

  void _handleClose() {
    if (widget.onClose != null) {
      widget.onClose!();
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
            colors: [Color(0xFFF6EDE4), Color(0xFFE8D9C8), Color(0xFFD2B8A3)],
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
                      onTap: _handleClose,
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
                    'FAQ',
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

            // ── FAQ list ──
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: bottomPadding + 20,
                ),
                itemCount: _faqs.length,
                itemBuilder: (context, index) {
                  final faq = _faqs[index];
                  final isExpanded = index == _expandedIndex;

                  return _FaqTile(
                    question: faq.question,
                    answer: faq.answer,
                    isExpanded: isExpanded,
                    onTap: () {
                      setState(() {
                        _expandedIndex = isExpanded ? -1 : index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FaqTile({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isExpanded
                    ? Colors.white.withValues(alpha: 0.65)
                    : Colors.white.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.7),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isExpanded ? 0.06 : 0.03),

                blurRadius: isExpanded ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withValues(alpha: 0.8),
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 22,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.5),
                      height: 1.5,
                    ),
                  ),
                ),
                crossFadeState:
                    isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
