import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/presentation/screens/expense/expense_screen.dart';
import 'package:provider/provider.dart';

import '../../state_management/user_provider.dart';
import '../../widgets/auth_button_widget.dart';
import '../../widgets/auth_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
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
                'Register',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              AuthTextFieldWidget(
                  title: "Username", controller: usernameController),
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
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool isLoggedIn =
                        await Provider.of<UserProvider>(context, listen: false)
                            .signup(usernameController.text,
                                emailController.text, passwordController.text);
                    if (isLoggedIn) {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExpenseScreen(),
                            ));
                      }
                    }
                  } else {}
                },
                title: "Register",
              )
            ],
          ),
        ),
      ),
    );
  }
}
