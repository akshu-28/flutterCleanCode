import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercleancode/features/login/data/models/login_request.dart';
import 'package:fluttercleancode/features/login/presentation/pages/widgets/primary_button.dart';
import 'package:fluttercleancode/features/login/presentation/pages/widgets/text_header.dart';

import '../../../../core/router/router.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;
  const LoginPage({Key? key, required this.loginBloc}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isShowPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  void _handleState(state) {
    if (state is LoggedInWithSuccess) {
      _isLoading = false;
      Navigator.pushReplacementNamed(context, AppRouter.routeWatchlist);
    } else if (state is LoggedInWithError) {
      _isLoading = false;
      _showAlert(state.message);
    } else if (state is LoggingIn) {
      _isLoading = true;
    }
  }

  void _showAlert(String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          );
        });
  }

  void _doLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailTextFieldController.text.toString().trim();
      String password = _passwordTextFieldController.text.toString().trim();
      widget.loginBloc
          .add(LoginUserEvent(parameters: LoginRequest(userName: email)));
    }
  }

  Widget _headerWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 36, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          TextHeader(text: "Sign In"),
          Text(
              "Please sign in first to get all feature of this app. If you don't have any account, create a new one"),
        ],
      ),
    );
  }

  Widget _loadingBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 28, left: 16, right: 16),
      child: LinearProgressIndicator(
        value: _isLoading ? null : 0,
      ),
    );
  }

  Widget _signInForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailTextFieldController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
              validator: (value) {
                if (value == null || value.toString().trim().isEmpty) {
                  return "Email must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: !_isShowPassword,
              controller: _passwordTextFieldController,
              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: InkWell(
                    onTap: () => {
                      setState(() {
                        _isShowPassword = !_isShowPassword;
                      })
                    },
                    child: _isShowPassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )),
              validator: (value) {
                if (value == null || value.toString().trim().isEmpty) {
                  return "Password must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              text: "Login",
              onClick: _isLoading ? null : _doLogin,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: BlocConsumer<LoginBloc, LoginState>(
      bloc: widget.loginBloc,
      listener: (context, state) {
        _handleState(state);
      },
      builder: (context, state) {
        return Column(
          children: [
            _headerWidget(),
            _loadingBar(),
            _signInForm(),
          ],
        );
      },
    ))));
  }
}
