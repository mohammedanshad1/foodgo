import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo/service/api_service.dart';
import 'package:foodgo/view/login_screen.dart';
import 'package:foodgo/view/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for 2 seconds for splash screen display
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if user is logged in
    bool isLoggedIn = await ApiService.isLoggedIn();
    
    if (mounted) {
      if (isLoggedIn) {
        // Navigate to Home Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Navigate to Login Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Foodgo text at bottom left
            Positioned(
              left: 30.w,
              bottom: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foodgo',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontWeight: FontWeight.w400,
                      fontSize: 85.sp,
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            // Arrow image at bottom right
            Positioned(
              right: 30.w,
              bottom: 10.h,
              child: GestureDetector(
                onTap: () async {
                  // Check login status before navigating
                  bool isLoggedIn = await ApiService.isLoggedIn();
                  if (isLoggedIn) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  }
                },
                child: Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/arrow splash.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}