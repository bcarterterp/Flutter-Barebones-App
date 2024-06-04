import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sa_onsite/login_state.dart';
import 'package:flutter_sa_onsite/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          padding: const EdgeInsets.all(24),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return getContent(viewModel);
            },
          ),
        ),
      ),
    );
  }

  Widget getContent(LoginViewModel viewModel) {
    if (viewModel.state is LoginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showSnackBar(context, "Login Success!");
        },
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/logo.png')),
          const SizedBox(height: 20),
          const Image(image: AssetImage('assets/tree_search_logo.png')),
          const SizedBox(height: 48),
          if (viewModel.state is LoginLoading) ...[
            getLoadingIndicator(context),
          ] else
            ...getLoginContent(viewModel),
        ],
      ),
    );
  }

  List<Widget> getLoginContent(LoginViewModel viewModel) {
    return [
      SizedBox(
        height: 40,
        child: TextField(
          controller: usernameController,
          style: const TextStyle(
            color: Color(0xFF636366),
          ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Username",
          ),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 40,
        child: TextField(
          controller: passwordController,
          style: const TextStyle(
            color: Color(0xFF636366),
          ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password",
          ),
        ),
      ),
      const SizedBox(height: 48),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: const Color(0xFF1C77C3),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        onPressed: () {
          viewModel.login(
            usernameController.text,
            passwordController.text,
          );
        },
        child: const Text("Login"),
      ),
    ];
  }

  Widget getLoadingIndicator(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return const CupertinoActivityIndicator();
    }
    return const CircularProgressIndicator();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
