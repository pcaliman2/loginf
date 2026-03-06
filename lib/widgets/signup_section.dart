import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/header2.dart';
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/login_section.dart';

class OWASignUpSection extends StatelessWidget {
  const OWASignUpSection({super.key});

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
              child: const _SignUpCard(),
            ),
            OWAFooter(key: UniqueKey()),
          ],
        ),
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
        constraints: const BoxConstraints(maxWidth: 1180),
        child: SizedBox(
          height: 760,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(flex: 11, child: _LeftSignUpPanel()),
              SizedBox(width: 24),
              Expanded(flex: 9, child: _RightImagePanel()),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftSignUpPanel extends StatelessWidget {
  const _LeftSignUpPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const _SignUpForm(),
    );
  }
}

class _RightImagePanel extends StatelessWidget {
  const _RightImagePanel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/discover_4.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.35)),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'GET STARTED',
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
                'Already have an Account?',
                style: TextStyle(
                  fontFamily: 'Basier Square Mono',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _RightPanelButton(text: 'Log In'),
            ],
          ),
        ),
      ],
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
  final _birthday = TextEditingController();
  final _phone = TextEditingController();
  final _countryOrigin = TextEditingController();
  final _countryResidence = TextEditingController();
  final _line1 = TextEditingController();
  final _line2 = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _postal = TextEditingController();

  String _gender = "Male";

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
    VoidCallback? onTap,
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
            readOnly: onTap != null,
            onTap: onTap,
            decoration: _dec(),
            validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      "${d.year.toString().padLeft(4, '0')}-"
      "${d.month.toString().padLeft(2, '0')}-"
      "${d.day.toString().padLeft(2, '0')}";

  void _selectCountry(TextEditingController controller) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      countryListTheme: CountryListThemeData(
        backgroundColor: colors.backgroundColor,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.78,
        borderRadius: BorderRadius.zero,
        inputDecoration: const InputDecoration(
          hintText: 'Search country',
          prefixIcon: Icon(Icons.search),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBDBDBD)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2C2C2C), width: 1.5),
          ),
        ),
      ),
      onSelect: (Country country) {
        controller.text = country.name;
      },
    );
  }

  Future<void> _selectBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(surface: colors.backgroundColor),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: colors.backgroundColor,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: colors.backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _birthday.text = _formatDate(picked);
    }
  }

  void _goToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OWALoginSection()),
      );
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _birthday.dispose();
    _phone.dispose();
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
      child: SingleChildScrollView(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "GENDER",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: _gender,
                          dropdownColor: colors.backgroundColor,
                          borderRadius: BorderRadius.zero,
                          decoration: _dec(),
                          items: const [
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text("Female"),
                            ),
                            DropdownMenuItem(
                              value: "Non-Disclosed",
                              child: Text("Non-Disclosed"),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _gender = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field("Birthday", _birthday, onTap: _selectBirthday),
                ),
              ],
            ),
            _field("Phone number", _phone),
            Row(
              children: [
                Expanded(
                  child: _field(
                    "Country of origin",
                    _countryOrigin,
                    onTap: () => _selectCountry(_countryOrigin),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    "Country of residence",
                    _countryResidence,
                    onTap: () => _selectCountry(_countryResidence),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "ADDRESS",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
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
              child: Column(
                children: [
                  _LoginImageButton(
                    text: "Sign Up",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Form Valid")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _goToLogin,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Already a member? ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2C2C2C),
                          ),
                          children: [
                            TextSpan(
                              text: "Log In",
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

class _LoginImageButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color textHoverColor;

  const _LoginImageButton({
    this.text = 'Log In',
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

class _RightPanelButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color textHoverColor;

  const _RightPanelButton({
    this.text = 'Log In',
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.textHoverColor = const Color(0xFF2C2C2C),
    Key? key,
  }) : super(key: key);

  @override
  State<_RightPanelButton> createState() => _RightPanelButtonState();
}

class _RightPanelButtonState extends State<_RightPanelButton> {
  bool isHovered = false;

  void _goToLogin(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OWALoginSection()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap ?? () => _goToLogin(context),
        child: Container(
          width: 220,
          height: 36,
          decoration: BoxDecoration(
            color:
                isHovered
                    ? const Color.fromARGB(255, 66, 66, 65)
                    : widget.backgroundColor,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(2),
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
