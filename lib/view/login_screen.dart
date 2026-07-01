import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:foodgo/viewmodel/login_viewmodel.dart';
import 'package:foodgo/view/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          // Show snackbar on error
          if (viewModel.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(viewModel.errorMessage!),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
              viewModel.clearError();
            });
          }

          // Navigate to Home on success
          if (viewModel.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Successful!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            });
          }

          return Scaffold(
            body: Container(
              width: 1.sw,
              height: 1.sh,
              color: Color(0xFFF9FAFB),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 120.h),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 27.sp,
                          height: 1.0,
                          color: Color(0xFFF9C80E),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Color(0xFF2B2D42),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        'E mail',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Color(0xFF2B2D42),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Color(0xFF363E44).withOpacity(0.5),
                          ),
                        ),
                        child: TextField(
                          controller: _emailController,
                          enabled: !viewModel.isLoading,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF2B2D42),
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your E mail',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF2B2D42).withOpacity(0.6),
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Color(0xFF2B2D42),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Color(0xFF363E44).withOpacity(0.5),
                          ),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          enabled: !viewModel.isLoading,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF2B2D42),
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF2B2D42).withOpacity(0.6),
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFFF7C91B).withOpacity(0.5),
                                size: 20.sp,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Color(0xFFFF8C69),
                          ),
                        ),
                      ),
                      SizedBox(height: 180.h),
                      Container(
                        width: 1.sw,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: viewModel.isLoading 
                              ? Color(0xFFF7C91B).withOpacity(0.6)
                              : Color(0xFFF7C91B),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ElevatedButton(
                          onPressed: viewModel.isLoading
                              ? null
                              : () async {
                                  if (_emailController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter your email'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  if (_passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter your password'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  // Call login API
                                  await viewModel.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: viewModel.isLoading
                              ? SizedBox(
                                  height: 24.h,
                                  width: 24.h,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF2B2D42),
                                    strokeWidth: 2.w,
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Color(0xFF2B2D42),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              color: Color(0xFF2B2D42),
                            ),
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                              ),
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF8C69),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.5.h,
                              color: Color(0xFF363E44),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'Or Login With',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                height: 1.0,
                                color: Color(0xFF2B2D42),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 0.5.h,
                              color: Color(0xFF363E44),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 36.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color(0xFF7BDCB5).withOpacity(0.5),
                                  width: 1.w,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.w),
                                child: Image.asset(
                                  'assets/images/google icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color(0xFF7BDCB5).withOpacity(0.5),
                                  width: 1.w,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.w),
                                child: Image.asset(
                                  'assets/images/apple icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}