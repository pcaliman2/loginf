// login_section.dart
// Copia de signup_section.dart adaptada para login_section.dart
import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/header2.dart';
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/signup_section.dart';

class OWALoginSection extends StatelessWidget {
  const OWALoginSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Corrección: evita overflow cuando esta sección se monta dentro de un Scaffold
    // (por ejemplo al navegar). La sección ahora puede crecer y scrollear.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OWAHeader(),
          Container(
            width: SizeConfig.w(1440),
            color: colors.backgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.w(42),
              vertical: SizeConfig.h(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado y línea horizontal
                Text(
                  'Login Upxxx',
                  style: TextStyle(
                    fontFamily: 'Basier Square Mono',
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.t(19),
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
                SizedBox(height: SizeConfig.h(12)),
                Container(
                  width: double.infinity,
                  height: SizeConfig.h(1),
                  color: const Color(0xFF656565),
                ),
                SizedBox(height: SizeConfig.h(30)),
                Center(
                  child: SizedBox(
                    width: 1000,
                    height: 350,
                    child: Row(
                      children: [
                        // Left Side: Login Form
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    'Login Account',
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Color(0xFF2C2C2C),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: _LoginForm(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Right Side: Imagen con overlay, texto y botón
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.backgroundColor,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      'assets/events4.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.black.withOpacity(0.35),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              'Welcome Back',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    'Basier Square Mono',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 32,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            const Text(
                                              'Not a Member yet?',
                                              style: TextStyle(
                                                fontFamily:
                                                    'Basier Square Mono',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            _LoginImageButton(
                                              backgroundColor:
                                                  Colors.transparent,
                                              borderColor: Colors.white,
                                              textColor: Colors.white,
                                              textHoverColor: const Color(
                                                0xFF2C2C2C,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                ),
              ],
            ),
          ),
          OWAFooter(key: UniqueKey()),
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
    this.text = 'Sign In',
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.borderColor = const Color(0xFF2C2C2C),
    this.textColor = const Color(0xFF2C2C2C),
    this.textHoverColor = Colors.white,
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
        onTap: () {
          if (widget.text == 'Sign In') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scaffold(body: OWASignUpSection()),
              ),
            );
          } else if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Container(
          width: 220,
          height: 26,
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFE6FF00) : widget.backgroundColor,
            border: Border.all(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Arbeit',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: isHovered ? widget.textHoverColor : widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            'Email',
            onChanged: (v) => email = v,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            'Password',
            onChanged: (v) => password = v,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _LoginImageButton(
              text: 'Login',
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful!')),
                  );
                }
              },
              backgroundColor: Colors.transparent,
              borderColor: const Color(0xFF2C2C2C),
              textColor: const Color(0xFF2C2C2C),
              textHoverColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required Function(String) onChanged,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    Icon? icon;
    switch (label) {
      case 'Email':
        icon = const Icon(Icons.email);
        break;
      case 'Password':
        icon = const Icon(Icons.lock);
        break;
      default:
        icon = null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: icon,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator:
            (value) =>
                (value == null || value.isEmpty) ? 'Please enter $label' : null,
      ),
    );
  }
}
