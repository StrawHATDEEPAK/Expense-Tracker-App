import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/presentation/screens/auth/register_screen.dart';
import 'package:personal_expense_tracker/presentation/state_management/user_provider.dart';
import 'package:personal_expense_tracker/presentation/widgets/auth_button_widget.dart';
import 'package:personal_expense_tracker/presentation/widgets/auth_textfield_widget.dart';
import 'package:provider/provider.dart';

import '../expense/expense_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              AuthTextFieldWidget(
                  title: "Email Address", controller: emailController),
              const SizedBox(
                height: 15,
              ),
              AuthTextFieldWidget(
                  isPassword: true,
                  title: "Password",
                  controller: passwordController),
              const SizedBox(
                height: 40,
              ),
              AuthButtonWidget(
                isLoading:
                    Provider.of<UserProvider>(context, listen: true).isLoading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<UserProvider>(context, listen: false)
                        .login(emailController.text, passwordController.text);

                    if (Provider.of<UserProvider>(context, listen: true)
                        .isLoggedIn) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExpenseScreen()));
                    }
                  } else {}
                },
                title: "Login",
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not Registered Yet?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
