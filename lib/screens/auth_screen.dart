import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sicef_hakaton/misc/snackbar.dart';
import 'package:sicef_hakaton/misc/snackbar_enum.dart';
import 'package:sicef_hakaton/services/user_services.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;

  bool isNameError = false;
  bool isEmailError = false;
  bool isPassError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  Future<void> login() async {
    String email = _emailController.text;
    String pass = _passController.text;
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      setState(() {
        isEmailError = true;
      });
      return;
    } else {
      setState(() {
        isEmailError = false;
      });
    }

    if (pass.length < 8) {
      setState(() {
        isPassError = true;
      });
      return;
    } else {
      setState(() {
        isEmailError = false;
      });
    }

    try {
      setState(() {
        _isLoading = true;
      });
      await UserServices.login(email, pass);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      CustomSnackbar.show(context, SnackBarType.Error,
          'Login unseccessful. Please check your login info and try again.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> register() async {
    String email = _emailController.text;
    String pass = _passController.text;
    String name = _nameController.text;

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      setState(() {
        isEmailError = true;
      });
      return;
    } else {
      setState(() {
        isEmailError = false;
      });
    }

    if (pass.length < 8) {
      setState(() {
        isPassError = true;
      });
      return;
    } else {
      setState(() {
        isPassError = false;
      });
    }

    if (name.isEmpty) {
      setState(() {
        isNameError = true;
      });
      return;
    } else {
      setState(() {
        isNameError = false;
      });
    }

    try {
      setState(() {
        _isLoading = true;
      });
      await UserServices.register(name, email, pass);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      CustomSnackbar.show(context, SnackBarType.Error,
          'Registration unseccessful. Please check your login info and try again.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/city-bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _isLogin ? 'Login' : 'Registration',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                if (!_isLogin) ...[
                                  SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        errorText: isNameError ? '' : null,
                                        errorStyle:
                                            const TextStyle(height: 0.0),
                                        isDense: true,
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red[400]!,
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red[400]!,
                                            width: 2.0,
                                          ),
                                        ),
                                        iconColor: Colors.white,
                                        labelText: 'Full name',
                                        hintText: 'Pera Perić',
                                        labelStyle: const TextStyle(
                                            color: Colors
                                                .white), // Set label text color to white
                                        hintStyle: const TextStyle(
                                            color: Colors
                                                .white38), // Set hint text color to white
                                      ),
                                      style: const TextStyle(
                                          color: Colors
                                              .white), // Set input text color to white
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.alternate_email,
                                        color: Colors.white,
                                      ),
                                      errorText: isEmailError ? '' : null,
                                      errorStyle: const TextStyle(height: 0.0),
                                      isDense: true,
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.red[400]!,
                                            width: 2.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.red[400]!,
                                          width: 2.0,
                                        ),
                                      ),
                                      iconColor: Colors.white,
                                      labelText: 'Email',
                                      hintText: 'name@example.com',
                                      labelStyle: const TextStyle(
                                          color: Colors
                                              .white), // Set label text color to white
                                      hintStyle: const TextStyle(
                                          color: Colors
                                              .white38), // Set hint text color to white
                                    ),
                                    style: const TextStyle(
                                        color: Colors
                                            .white), // Set input text color to white
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: _passController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      errorText: isPassError ? '' : null,
                                      errorStyle: const TextStyle(height: 0.0),
                                      isDense: true,
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.red[400]!,
                                            width: 2.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.red[400]!,
                                          width: 2.0,
                                        ),
                                      ),
                                      iconColor: Colors.white,
                                      fillColor: Colors.white,
                                      labelText: 'Password',
                                      hintText: '···········',
                                      labelStyle: const TextStyle(
                                          color: Colors
                                              .white), // Set label text color to white
                                      hintStyle: const TextStyle(
                                          color: Colors
                                              .white38), // Set hint text color to white
                                    ),
                                    style: const TextStyle(
                                        color: Colors
                                            .white), // Set input text color to white
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        _isLogin ? login() : register(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                            height: 19,
                                            width: 19,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              strokeWidth: 4,
                                              strokeCap: StrokeCap.round,
                                            ),
                                          )
                                        : Text(
                                            _isLogin
                                                ? 'Log in'
                                                : 'Create account',
                                            style: const TextStyle(
                                                color: Color(0xFF292929),
                                                fontSize: 16),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    _isLogin = !_isLogin;
                                  }),
                                  child: Text(
                                    _isLogin
                                        ? 'Don`t have an account? Create one.'
                                        : 'Already have an account? Log in.',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                          height: 90,
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Image.asset('assets/logo-text.png')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
