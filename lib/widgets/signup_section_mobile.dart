import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_service.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/header2_mobile.dart';
import 'package:owa_flutter/widgets/mobile_footer.dart';
import 'package:owa_flutter/widgets/login_section.dart';

class OWASignUpSectionMobile extends StatelessWidget {
  const OWASignUpSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const OWAHeader2Mobile(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: _MobileSignUpCard(),
            ),
            OWAMobileFooter(key: UniqueKey()),
          ],
        ),
      ),
    );
  }
}

class _MobileSignUpCard extends StatelessWidget {
  const _MobileSignUpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colors.backgroundColor,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MobileImagePanel(),
          SizedBox(height: 28),
          _MobileLeftSignUpPanel(),
        ],
      ),
    );
  }
}

class _MobileImagePanel extends StatelessWidget {
  const _MobileImagePanel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/discover_4.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'GET STARTED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Basier Square Mono',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Already have an Account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Basier Square Mono',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  _MobileRightPanelButton(text: 'LOG IN'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileLeftSignUpPanel extends StatelessWidget {
  const _MobileLeftSignUpPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: colors.backgroundColor,
      child: const _MobileSignUpForm(),
    );
  }
}

class _MobileSignUpForm extends StatefulWidget {
  const _MobileSignUpForm();

  @override
  State<_MobileSignUpForm> createState() => _MobileSignUpFormState();
}

class _MobileSignUpFormState extends State<_MobileSignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _birthday = TextEditingController();
  final _phone = TextEditingController();
  final _phoneCodeController = TextEditingController(text: '+1');
  final _countryOrigin = TextEditingController();
  final _countryResidence = TextEditingController();
  final _line1 = TextEditingController();
  final _line2 = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _postal = TextEditingController();

  String _gender = "Male";
  String _phoneCode = "+1";

  InputDecoration _dec() => const InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.only(bottom: 8),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2C2C2C), width: 1.5),
    ),
  );

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool obscure = false,
    int lines = 1,
    VoidCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: ctrl,
            obscureText: obscure,
            maxLines: lines,
            readOnly: onTap != null,
            onTap: onTap,
            inputFormatters: inputFormatters,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: _dec().copyWith(suffixIcon: suffixIcon),
            validator:
                (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
          ),
        ],
      ),
    );
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OWALoginSection()),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _birthday.dispose();
    _phone.dispose();
    _phoneCodeController.dispose();
    _countryOrigin.dispose();
    _countryResidence.dispose();
    _line1.dispose();
    _line2.dispose();
    _city.dispose();
    _state.dispose();
    _postal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CREATE YOUR ACCOUNT",
            style: TextStyle(
              fontFamily: 'Basier Square Mono',
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Fill in your details to access your dashboard.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 18),

          _field("First name", _firstName),
          _field("Last name", _lastName),
          _field("Email", _email),
          _field("Password", _password, obscure: true),

          const SizedBox(height: 24),

          Center(
            child: _MobileSignUpButton(
              text: "SIGN UP",
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Form Valid")));
                }
              },
            ),
          ),

          const SizedBox(height: 14),

          Center(
            child: GestureDetector(
              onTap: _goToLogin,
              child: const Text(
                'Already a member? Log In',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileSignUpButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _MobileSignUpButton({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF2C2C2C), width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Basier Square Mono',
            fontSize: 14,
            letterSpacing: 1.2,
            color: Color(0xFF2C2C2C),
          ),
        ),
      ),
    );
  }
}

class _MobileRightPanelButton extends StatelessWidget {
  final String text;

  const _MobileRightPanelButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OWALoginSection()),
        );
      },
      child: Container(
        width: 180,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Basier Square Mono',
            fontSize: 13,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
