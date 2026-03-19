import 'package:flutter/material.dart';
import 'package:owa_flutter/cart/cart_scope.dart';
import 'package:owa_flutter/cart/cart_store.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/useful/is_desktop_from_context.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/useful/smooth_wheel_scroll_controller.dart';
import 'package:owa_flutter/widgets/bridge_section.dart';
import 'package:owa_flutter/widgets/cart_panel.dart';
import 'package:owa_flutter/widgets/discover_section.dart';
import 'package:owa_flutter/widgets/discover_section_mobile.dart';
import 'package:owa_flutter/widgets/events_section.dart';
import 'package:owa_flutter/widgets/events_section_mobile.dart';
import 'package:owa_flutter/widgets/follow_us_section_mobile.dart';
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/follow_us_section.dart';
import 'package:owa_flutter/widgets/hero_section.dart';
import 'package:owa_flutter/widgets/hero_section_mobile.dart';
import 'package:owa_flutter/widgets/info_section.dart';
import 'package:owa_flutter/widgets/info_section_mobile.dart';
import 'package:owa_flutter/widgets/memberships_section.dart';
import 'package:owa_flutter/widgets/memberships_section_mobile.dart';
import 'package:owa_flutter/widgets/mobile_footer.dart';
import 'package:owa_flutter/widgets/owa_drawer.dart';
import 'package:owa_flutter/widgets/therapies_section.dart';
import 'package:owa_flutter/widgets/therapies_section_mobile.dart';
import 'package:owa_flutter/widgets/whatsapp_floating_button.dart';

class OWALandingPage extends StatefulWidget {
  const OWALandingPage({super.key});

  @override
  State<OWALandingPage> createState() => _OWALandingPageState();
}

class _OWALandingPageState extends State<OWALandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = SmoothWheelScrollController();

  final _membershipsKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _therapiesKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _footerKey = GlobalKey();
  final _footerMobileKey = GlobalKey();
  double _desktopFooterHeight = 539;
  double _mobileFooterHeight = 0;

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  void _onNavTap(String label) {
    final state = _scaffoldKey.currentState;
    if ((state?.isDrawerOpen ?? false) || (state?.isEndDrawerOpen ?? false)) {
      Navigator.pop(context);
    }

    switch (label) {
      case 'Memberships':
        _scrollTo(_membershipsKey);
        break;
      case 'Services':
        _scrollTo(_servicesKey);
        break;
      case 'Therapies':
        _scrollTo(_therapiesKey);
        break;
      case 'Contact':
        _scrollTo(_contactKey);
        break;
      case 'FAQ':
        Navigator.pushNamed(context, '/faq');
        break;
    }
  }

  void _openCartDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _addDemoItem() {
    CartScope.of(context).addItem(
      id: 'demo-event-ticket',
      type: CartItemType.event,
      name: 'OWA Demo Event Ticket',
      price: 65,
      qty: 1,
    );
  }

  void _syncFooterHeights() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final desktopHeight = _footerKey.currentContext?.size?.height;
      final mobileHeight = _footerMobileKey.currentContext?.size?.height;

      if (desktopHeight != null &&
          desktopHeight > 0 &&
          desktopHeight != _desktopFooterHeight) {
        setState(() => _desktopFooterHeight = desktopHeight);
      }

      if (mobileHeight != null &&
          mobileHeight > 0 &&
          mobileHeight != _mobileFooterHeight) {
        setState(() => _mobileFooterHeight = mobileHeight);
      }
    });
  }

  double _footerRevealProgress(double footerHeight) {
    if (!_scrollController.hasClients) return 0.0;

    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return 0.0;

    final remainingScroll = maxScroll - _scrollController.offset;
    final revealDistance = footerHeight * 1.15;
    final rawProgress = 1 - (remainingScroll / revealDistance);
    return rawProgress.clamp(0.0, 1.0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDesktopFromContext(context);
    final cartStore = CartScope.of(context);
    final double footerHeight =
        isDesktop
            ? _desktopFooterHeight
            : (_mobileFooterHeight > 0 ? _mobileFooterHeight : 640.0);

    _syncFooterHeights();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.backgroundColor,
      drawer: !isDesktop ? const OWADrawer() : null,
      endDrawer: SizedBox(
        width: isDesktop ? 420 : MediaQuery.of(context).size.width * 0.92,
        child: const SafeArea(child: CartPanel(inDrawer: true)),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(right: 8, bottom: 8),
        child: WhatsAppFloatingButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: isDesktop
                ? OWAFooter(key: _footerKey)
                : OWAMobileFooter(key: _footerMobileKey),
          ),
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: isDesktop,
            interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics:
                  isDesktop
                      ? const ClampingScrollPhysics()
                      : const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
              child: Column(
                children: [
                  Container(
                    color: colors.backgroundColor,
                    child: Column(
                      children:
                          isDesktop
                              ? _buildDesktopLayout(cartStore)
                              : _buildMobileLayout(),
                    ),
                  ),
                  SizedBox(height: footerHeight),
                ],
              ),
            ),
          ),
          if (!isDesktop) _buildHamburgerMenu(),
          // Positioned(
          //   bottom: SizeConfig.h(18),
          //   right: SizeConfig.w(18),
          //   child: _buildAddDemoItemButton(),
          // ),
        ],
      ),
    );
  }

  Widget _buildHamburgerMenu() {
    return Positioned(
      top: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              // IconButton(
              //   icon: const Icon(
              //     Icons.shopping_bag_outlined,
              //     color: Colors.white,
              //     size: 26,
              //   ),
              //   onPressed: _openCartDrawer,
              // ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddDemoItemButton() {
    return GestureDetector(
      onTap: _addDemoItem,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(14),
          vertical: SizeConfig.h(10),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D).withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF181818), width: 0.8),
        ),
        child: Text(
          'Add Demo Item',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDesktopLayout(CartStore cartStore) {
    return [
      HeroSection(
        onNavTap: _onNavTap,
        onCartTap: _openCartDrawer,
        cartItemCount: cartStore.totalItems,
      ),
      InfoSection(key: UniqueKey()),
      OWADiscoverSection(key: _servicesKey),
      OWATherapiesSection(key: _therapiesKey),
      MembershipsSection(key: _membershipsKey),
      BridgeSection(key: UniqueKey()),
      OWAEventsSection(key: UniqueKey()),

      OWAFollowUsSection(key: UniqueKey()),
      SizedBox(key: _contactKey, height: 1),
    ];
  }

  List<Widget> _buildMobileLayout() {
    return [
      HeroSectionMobile(key: UniqueKey()),
      InfoSectionMobile(key: UniqueKey()),
      _buildMobileDivider(),
      OWADiscoverSectionMobile(key: _servicesKey),
      _buildMobileDivider(),
      OWATherapiesSectionMobile(key: _therapiesKey),
      _buildMobileDivider(),
      MembershipsSectionMobile(key: _membershipsKey),
      BridgeSection(key: UniqueKey()),
      OWAEventsSectionMobile(key: UniqueKey()),

      /// Mobile Follow Us Section
      OWAFollowUsSectionMobile(key: UniqueKey()),

      SizedBox(key: _contactKey, height: 1),
    ];
  }

  Widget _buildMobileDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
      child: Container(
        width: double.infinity,
        height: SizeConfig.h(1),
        color: const Color(0xFF656565),
      ),
    );
  }
}
