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
                        borderRadius: BorderRadius.circular(20.r), // Changed to 20px
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
                      borderRadius: BorderRadius.circular(20.r), // Already 20px
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      child: Container(
                        width: 120.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? Color(0xFFF7C91B) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected 
                                ? Colors.transparent 
                                : Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
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
              SizedBox(height: 20.h),
              // Food Items Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.75,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Color(0xFF2B2D42),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Color(0xFF2B2D42).withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xFFF7C91B),
                      size: 16.sp,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}