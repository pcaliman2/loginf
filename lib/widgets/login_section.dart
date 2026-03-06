import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/header2.dart';
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/signup_section.dart';

class OWALoginSection extends StatelessWidget {
  const OWALoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const OWAHeader(),
            Container(
              width: SizeConfig.w(1440),
              color: colors.backgroundColor,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.w(42),
                vertical: SizeConfig.h(40),
              ),
              child: const _LoginCard(),
            ),
            OWAFooter(key: UniqueKey()),
          ],
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: colors.backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 32),
                  child: _LoginForm(),
                ),
              ),
              Expanded(child: _LoginRightImage()),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  InputDecoration _dec() => const InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 8),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
            decoration: _dec(),
            validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
          ),
        ],
      ),
    );
  }

  void _goToSignUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OWASignUpSection()),
      );
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome back",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text("Log In to access your dashboard."),
            const SizedBox(height: 14),
            _field("Email", _email),
            _field("Password", _password, obscure: true),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  _LoginImageButton(
                    text: "Log In",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login form valid")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _goToSignUp,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Not a Member? ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2C2C2C),
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _LoginRightImage extends StatelessWidget {
  const _LoginRightImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/events4.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Basier Square Mono',
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Not a Member yet?',
                  style: TextStyle(
                    fontFamily: 'Basier Square Mono',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                _LoginImageButton(
                  text: 'Sign Up',
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  textHoverColor: const Color(0xFF2C2C2C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginImageButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color textHoverColor;

  const _LoginImageButton({
    this.text = 'Sign Up',
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.borderColor = const Color(0xFF2C2C2C),
    this.textColor = const Color(0xFF2C2C2C),
    this.textHoverColor = Colors.white,
    super.key,
  });

  @override
  State<_LoginImageButton> createState() => _LoginImageButtonState();
}

class _LoginImageButtonState extends State<_LoginImageButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 220,
          height: 36,
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFE6FF00) : widget.backgroundColor,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Arbeit',
              fontSize: 12,
              color: isHovered ? widget.textHoverColor : widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
