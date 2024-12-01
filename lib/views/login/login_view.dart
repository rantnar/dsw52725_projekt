import 'package:dsw52725_projekt/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:dsw52725_projekt/utils/my_colors.dart';
import '../register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterView()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 62),
                Image.asset(MyImages.logo),
                const SizedBox(height: 21),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Sign In',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: MyColors.purpleColor,
                      )),
                ),
                const SizedBox(height: 21),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            labelText: 'Email or User Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.purpleColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded,
                              color: MyColors.purpleColor,
                            ),
                            prefixIconColor: MyColors.lightpurpleColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email or user name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20), // Increased padding
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            labelText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                              color: MyColors.lightpurpleColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: MyColors.purpleColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            )
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20), // Increased padding
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(MyColors.purpleColor),
                          ),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(MyColors.lightpurpleColor),
                                foregroundColor: MaterialStateProperty.all(MyColors.whiteColor),
                                minimumSize: MaterialStateProperty.all(const Size(double.infinity, 40)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: _submit,
                              child: const Text('Sign In'),
                            ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? '),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterView()),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(MyColors.purpleColor),
                            ),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Add padding at the bottom
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}