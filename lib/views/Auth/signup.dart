import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mcqtest/viewModels/auth_vm.dart';
import 'package:mcqtest/views/Auth/login.dart';
import 'package:mcqtest/views/Auth/widgets/cust_text_field.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Let\'s Get Started 🚀',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextfield(
                      controller: _nameController,
                      labelText: 'Name',
                      icon: Iconsax.user,
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _emailController,
                      labelText: 'Email',
                      icon: Icons.alternate_email_rounded,
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Iconsax.lock_1,
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      icon: Iconsax.lock_1,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_nameController.text.isEmpty) {
                          CustomSnackBar(
                            message: 'Name cannot be empty',
                          ).show(context);
                          return;
                        }
                        if (_emailController.text.isEmpty) {
                          CustomSnackBar(
                            message: 'Email cannot be empty',
                          ).show(context);
                          return;
                        }
                        if (_passwordController.text.isEmpty) {
                          CustomSnackBar(
                            message: 'Password cannot be empty',
                          ).show(context);
                          return;
                        }
                        if (_confirmPasswordController.text.isEmpty) {
                          CustomSnackBar(
                            message: 'Confirm Password cannot be empty',
                          ).show(context);
                          return;
                        }
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          CustomSnackBar(
                            message: 'Passwords do not match',
                          ).show(context);

                          return;
                        }

                        _authViewModel.registerWithEmailAndPassword(
                          _nameController.text.trim(),
                          _emailController.text,
                          _passwordController.text,
                          context,
                        );
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                      child: const Text('Already have an account? Login'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSnackBar {
  final String message;

  CustomSnackBar({required this.message});

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
