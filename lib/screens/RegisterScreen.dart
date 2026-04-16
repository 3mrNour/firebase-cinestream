import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cinestream/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
                top: 80,
                left: 20,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Color(0xffFFCD30),
                  ),
                ),
              ),
              Positioned(
                bottom: -150,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Opacity(
                    opacity: 0.02,
                    child: Image(
                      image: const AssetImage('assets/images/CineStream.png'),
                      width: 800,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/CineStream.png'),
                        width: 150,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xffFFCD30),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 30),
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
                      SizedBox(
                        height: userProvider.errorMessage.isNotEmpty ? 20 : 50,
                      ),
                      SizedBox(
                        width: 320,
                        child: Form(
                          key: userProvider.registerFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller:
                                    userProvider.registerFullNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                    76,
                                    65,
                                    48,
                                    102,
                                  ),
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
                                  FormBuilderValidators.required(
                                    errorText: 'Full name is required',
                                  ),
                                ]),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller:
                                    userProvider.registerEmailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                    76,
                                    65,
                                    48,
                                    102,
                                  ),
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
                                  FormBuilderValidators.required(
                                    errorText: 'Email is required',
                                  ),
                                  FormBuilderValidators.email(
                                    errorText: 'Please enter a valid email',
                                  ),
                                ]),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller:
                                    userProvider.registerPasswordController,
                                obscureText:
                                    userProvider.registerSecurePassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        userProvider.toggleRegisterPassword(),
                                    icon: userProvider.registerSecurePassword
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
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                    76,
                                    65,
                                    48,
                                    102,
                                  ),
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
                                  FormBuilderValidators.required(
                                    errorText: 'Password is required',
                                  ),
                                  FormBuilderValidators.minLength(
                                    6,
                                    errorText:
                                        'Password must be at least 6 characters',
                                  ),
                                ]),
                              ),
                              const SizedBox(height: 30),
                              MaterialButton(
                                color: const Color(0xffFFCD30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minWidth: double.maxFinite,
                                height: 55,
                                onPressed: userProvider.isLoading
                                    ? null
                                    : () {
                                        userProvider.register(context);
                                      },
                                child: userProvider.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.black,
                                              ),
                                        ),
                                      )
                                    : Text('Register'),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?  ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Log in",
                                      style: TextStyle(
                                        color: Color(0xffFFCD30),
                                        fontWeight: FontWeight.w700,
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
