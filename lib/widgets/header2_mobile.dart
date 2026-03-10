// header2_mobile.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:owa_flutter/crud/privacy_notice_screen.dart';

enum Header2MobileNavItemType { squareMono, circleMono }

class OWAHeader2Mobile extends StatelessWidget {
  const OWAHeader2Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: const Color(0xFFF6EFE7),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: SizedBox(
          height: 36,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OWAPrivacyNoticePage()),
                    );
                  },
                  child: _buildLogo(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => _openMenu(context),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Icon(Icons.menu, size: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 28,
      child: SvgPicture.asset(
        'assets/OWA_Logo.svg',
        height: 28,
        fit: BoxFit.fitHeight,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF6EFE7),
      barrierColor: Colors.black.withOpacity(0.35),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (_) {
        return const _OWAHeader2MobileMenuSheet();
      },
    );
  }
}

class _OWAHeader2MobileMenuSheet extends StatelessWidget {
  const _OWAHeader2MobileMenuSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'MENU',
                    style: TextStyle(
                      fontFamily: 'Basier Square Mono',
                      fontSize: 12,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Icon(Icons.close, size: 22, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(height: 1, thickness: 1, color: Color(0xFFDDD2C7)),
            const SizedBox(height: 10),

            _OWAHeader2MobileNavItem(
              text: 'BECOME A MEMBER',
              type: Header2MobileNavItemType.squareMono,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _OWAHeader2MobileNavItem(
              text: 'BOOK A SESSION',
              type: Header2MobileNavItemType.squareMono,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _OWAHeader2MobileNavItem(
              text: 'SERVICES',
              type: Header2MobileNavItemType.circleMono,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _OWAHeader2MobileNavItem(
              text: 'FAQ',
              type: Header2MobileNavItemType.circleMono,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _OWAHeader2MobileNavItem(
              text: 'THERAPIES',
              type: Header2MobileNavItemType.circleMono,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _OWAHeader2MobileNavItem extends StatefulWidget {
  final String text;
  final Header2MobileNavItemType type;
  final VoidCallback? onTap;

  const _OWAHeader2MobileNavItem({
    required this.text,
    required this.type,
    this.onTap,
  });

  @override
  State<_OWAHeader2MobileNavItem> createState() =>
      _OWAHeader2MobileNavItemState();
}

class _OWAHeader2MobileNavItemState extends State<_OWAHeader2MobileNavItem> {
  bool _isPressed = false;

  TextStyle _getTextStyle() {
    return const TextStyle(
      fontFamily: 'Instrument Sans',
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0,
    );
  }

  TextStyle _getPressedTextStyle() {
    return _getTextStyle().copyWith(fontWeight: FontWeight.w500);
  }

  Widget _leadingMarker() {
    switch (widget.type) {
      case Header2MobileNavItemType.squareMono:
        return Container(width: 7, height: 7, color: Colors.black);
      case Header2MobileNavItemType.circleMono:
        return Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDDD2C7), width: 1),
          ),
        ),
        child: Row(
          children: [
            _leadingMarker(),
            const SizedBox(width: 14),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 120),
                style: _isPressed ? _getPressedTextStyle() : _getTextStyle(),
                child: Text(widget.text),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
