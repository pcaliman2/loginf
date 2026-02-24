// signup_section_mobile.dart
// Versión móvil simplificada basada en signup_section.dart
import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/colors.dart' as colors;
import 'package:owa_flutter/widgets/footer_section.dart';
import 'package:owa_flutter/widgets/login_section_mobile.dart';

class OWASignUpSectionMobile extends StatelessWidget {
  const OWASignUpSectionMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        elevation: 0,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Basier Square Mono',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in your details to sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Basier Square Mono',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            _SignUpFormMobile(),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navegar a login móvil real
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OWALoginSectionMobile(),
                  ),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
            const SizedBox(height: 32),
            const OWAFooter(),
          ],
        ),
      ),
    );
  }
}

class _SignUpFormMobile extends StatefulWidget {
  @override
  State<_SignUpFormMobile> createState() => _SignUpFormMobileState();
}

class _SignUpFormMobileState extends State<_SignUpFormMobile> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => email = v,
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter Email'
                        : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => firstName = v,
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter First Name'
                        : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => lastName = v,
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter Last Name'
                        : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            onChanged: (v) => password = v,
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter Password'
                        : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Up Successful!')),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
