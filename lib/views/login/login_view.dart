import 'package:dsw52725_projekt/utils/my_images.dart';
import 'package:dsw52725_projekt/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:dsw52725_projekt/utils/my_colors.dart';
import '../register/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 3), () async {
        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          String exampleEmail = "example@example.com";
          String examplePassword = "password123";
          String enteredEmail = _emailController.text;
          String enteredPassword = _passwordController.text;

          if (enteredEmail == exampleEmail &&
              enteredPassword == examplePassword) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid email or password')),
            );
          }
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
                          controller: _emailController,
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
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
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
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
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
                              )),
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
                            foregroundColor:
                                WidgetStateProperty.all(MyColors.purpleColor),
                          ),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    MyColors.lightpurpleColor),
                                foregroundColor: WidgetStateProperty.all(
                                    MyColors.whiteColor),
                                minimumSize: WidgetStateProperty.all(
                                    const Size(double.infinity, 40)),
                                shape: WidgetStateProperty.all(
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
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: MyColors.purpleColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterView()),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor:
                                  WidgetStateProperty.all(MyColors.purpleColor),
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
