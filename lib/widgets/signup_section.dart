import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/header2.dart';
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/login_section.dart';

class OWASignUpSection extends StatelessWidget {
  const OWASignUpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: const _SignUpCard(),
          ),
          OWAFooter(key: UniqueKey()),
        ],
      ),
    );
  }
}

class _SignUpCard extends StatelessWidget {
  const _SignUpCard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: colors.backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const _SignUpForm(),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _gender = TextEditingController(text: "male");
  final _birthday = TextEditingController();
  final _phone = TextEditingController();
  final _countryOrigin = TextEditingController();
  final _countryResidence = TextEditingController();
  final _line1 = TextEditingController();
  final _line2 = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _postal = TextEditingController();

  // 🔥 DECORATION SOLO BORDE INFERIOR
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
    int lines = 1,
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
            maxLines: lines,
            decoration: _dec(),
            validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create your account",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text("Fill in your details to access your dashboard."),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(child: _field("First name", _firstName)),
              const SizedBox(width: 12),
              Expanded(child: _field("Last name", _lastName)),
            ],
          ),

          _field("Email", _email),
          _field("Password", _password, obscure: true),

          Row(
            children: [
              Expanded(child: _field("Gender", _gender)),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BIRTHDAY",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _birthday,
                        readOnly: true,
                        decoration: _dec(),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            _birthday.text = _formatDate(picked);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          _field("Phone number", _phone),

          Row(
            children: [
              Expanded(child: _field("Country of origin", _countryOrigin)),
              const SizedBox(width: 12),
              Expanded(
                child: _field("Country of residence", _countryResidence),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Text("ADDRESS", style: TextStyle(fontWeight: FontWeight.w800)),

          _field("Line 1", _line1),
          _field("Line 2", _line2),

          Row(
            children: [
              Expanded(child: _field("City", _city)),
              const SizedBox(width: 12),
              Expanded(child: _field("State", _state)),
            ],
          ),

          _field("Postal code", _postal),

          const SizedBox(height: 16),

          Center(
            child: _LoginImageButton(
              text: "Sign Inzzz",
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Form Valid")));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Botón reutilizable para imagen
class _LoginImageButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color textHoverColor;

  const _LoginImageButton({
    this.text = 'Sign In',
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.borderColor = const Color(0xFF2C2C2C),
    this.textColor = const Color(0xFF2C2C2C),
    this.textHoverColor = Colors.white,
    Key? key,
  }) : super(key: key);

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
        onTap: () {
          if (widget.text == 'Sign In') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Scaffold(body: OWASignUpSection()),
              ),
            );
            return;
          }
          widget.onTap?.call();
        },
        child: Container(
          width: 220,
          height: 36,
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFE6FF00) : widget.backgroundColor,
            border: Border.all(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Arbeit',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: isHovered ? widget.textHoverColor : widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
