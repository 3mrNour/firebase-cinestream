import 'package:cinestream/providers/user_provider.dart';
import 'package:cinestream/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        body: Container(
          width: .infinity,
          height: .infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff291E40), Color(0xff413066), Color(0xff120D1D)],
              stops: [0.1, 0.5, 0.9],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -150,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Opacity(
                    opacity: 0.02,
                    child: Image(
                      image: AssetImage('assets/images/CineStream.png'),
                      width: 800,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/CineStream.png'),
                        width: 150,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            "Welcome Back! ",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            "Log in",
                            style: TextStyle(
                              color: Color(0xffFFCD30),
                              fontSize: 24,
                              fontWeight: .w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // Error Message Display
                      if (userProvider.errorMessage.isNotEmpty)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            border: Border.all(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  userProvider.errorMessage,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: userProvider.clearError,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: userProvider.errorMessage.isNotEmpty ? 20 : 50),
                      SizedBox(
                        width: 320,
                        child: Form(
                          key: userProvider.loginFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: userProvider.loginEmailController,

                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  floatingLabelBehavior: .never,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(160, 65, 48, 102),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(0, 255, 207, 48),
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xffFFCD30),
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Email is required'),
                                  FormBuilderValidators.email(errorText: 'Please enter a valid email'),
                                ]),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: userProvider.loginPasswordController,

                                obscureText: userProvider.loginSecurePassword,

                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        userProvider.toggleLoginPassword(),
                                    icon: userProvider.loginSecurePassword
                                        ? Icon(
                                            Icons.visibility,
                                            color: const Color.fromARGB(
                                              120,
                                              255,
                                              255,
                                              255,
                                            ),
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: const Color.fromARGB(
                                              120,
                                              255,
                                              255,
                                              255,
                                            ),
                                          ),
                                  ),
                                  labelText: "Password",
                                  floatingLabelBehavior: .never,
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(160, 65, 48, 102),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(0, 255, 207, 48),
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xffFFCD30),
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Password is required'),
                                ]),
                              ),
                              const SizedBox(height: 30),
                              MaterialButton(
                                color: Color(0xffFFCD30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minWidth: .maxFinite,
                                height: 55,
                                onPressed: userProvider.isLoading
                                    ? null
                                    : () {
                                        userProvider.login(context);
                                      },
                                child: userProvider.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.black,
                                          ),
                                        ),
                                      )
                                    : Text('Login'),
                              ),
                              const SizedBox(height: 15),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 55),
                                  side: const BorderSide(
                                    color: Color(0xffFFCD30),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: userProvider.isLoading
                                    ? null
                                    : () {
                                        userProvider.loginWithGoogle(context);
                                      },
                                child: userProvider.isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color(0xffFFCD30),
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Sign in with Google',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    "Don't have an account?  ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Color(0xffFFCD30),
                                        fontWeight: .w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}