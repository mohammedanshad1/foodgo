import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategory = 0;
  final List<String> categories = ['All', 'Combos', 'Sliders', 'Classifieds'];
  
  // Icon list for bottom navigation
  final List<IconData> iconList = [
    Icons.home,
    Icons.favorite_border,
    Icons.shopping_cart_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              // Header with Foodgo and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foodgo',
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontWeight: FontWeight.w400,
                          fontSize: 45.sp,
                          height: 1.35,
                          letterSpacing: 0,
                          color: Color(0xFF3C2F2F),
                        ),
                      ),
                      Text(
                        'Order your favourite food!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: Color(0xFF2B2D42).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  // Profile Image - Square with 60x60 dimensions
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              // Search Bar with Settings Slider - Side by Side
              Row(
                children: [
                  // Search Bar - Expanded with 20px border radius
                  Expanded(
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17.sp,
                            color: Color(0xFF2B2D42).withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 29.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Settings Slider Container - Fixed Size with 20px border radius
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7C91B),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/settings-sliders.png',
                        width: 32.w,
                        height: 32.h,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Category Tabs with Horizontal Scroll
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 14.w),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategory == index;
                    final tabWidth = index == 0 ? 75.w : 120.w;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      child: Container(
                        width: tabWidth,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? Color(0xFFF7C91B)
                              : Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: isSelected
                                  ? Color(0xFF2B2D42)
                                  : Color(0xFF2B2D42).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5.h),
              // Food Items Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 185 / 225, // width:height ratio
                children: [
                  _buildFoodItem(
                    'assets/images/food1.png',
                    'Cheeseburger',
                    "Wendy's Burger",
                    '4.9',
                  ),
                  _buildFoodItem(
                    'assets/images/food2.png',
                    'Hamburger',
                    'Veggie Burger',
                    '4.8',
                  ),
                  _buildFoodItem(
                    'assets/images/food3.png',
                    'Hamburger',
                    'Chicken Burger',
                    '4.6',
                  ),
                  _buildFoodItem(
                    'assets/images/food4.png',
                    'Hamburger',
                    'Fried Chicken Burger',
                    '4.5',
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        backgroundColor: Color(0xFFF7C91B),
        child: Icon(
          Icons.add,
          color: Color(0xFF2B2D42),
          size: 32.sp,
        ),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeColor: Color(0xFFF7C91B),
        inactiveColor: Color(0xFF2B2D42).withOpacity(0.5),
        iconSize: 24.sp,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

Widget _buildFoodItem(String imagePath, String title, String subtitle, String rating) {
  return Container(
    width: 185.w,
    height: 225.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Left aligned
      children: [
        // Food Image - 120x120 centered
        Center(
          child: Container(
            width: 120.w,
            height: 120.h,
            margin: EdgeInsets.only(top: 11.h),
            alignment: Alignment.center,
            child: Image.asset(
              imagePath,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        // Title - Bold 16px - Left aligned
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              height: 1.39,
              letterSpacing: 0,
              color: Color(0xFF2B2D42),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Subtitle - Semi Bold 16px - Left aligned
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              height: 1.39,
              letterSpacing: 0,
              color: Color(0xFF2B2D42).withOpacity(0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        // Rating and Heart
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Rating with star image
              Row(
                children: [
                  Image.asset(
                    'assets/images/star.png',
                    width: 16.w,
                    height: 16.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    rating,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Color(0xFF2B2D42),
                    ),
                  ),
                ],
              ),
              // Heart icon
              Image.asset(
                'assets/images/heart.png',
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}