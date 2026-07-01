import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            // Foodgo text and Start Now at bottom left
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
                  // Text(
                  //   'Start Now',
                  //   style: TextStyle(
                  //     fontFamily: 'Lobster',
                  //     fontWeight: FontWeight.w400,
                  //     fontSize: 24.sp,
                  //     letterSpacing: 0,
                  //     color: Colors.white.withOpacity(0.8),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Arrow image at bottom right - INCREASED SIZE
            Positioned(
              right: 30.w,
              bottom: 10.h,
              child: GestureDetector(
                onTap: () {
                  // Add navigation or action here
                },
                child: Container(
                  width: 140.w,  // Increased from 80 to 120
                  height: 140.w, // Increased from 80 to 120
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