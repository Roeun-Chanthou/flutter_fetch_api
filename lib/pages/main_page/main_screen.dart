import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/pages/cart/cart_screen.dart';
import 'package:flutter_fetch_api/pages/favorite_page/favorite_screen.dart';
import 'package:flutter_fetch_api/pages/screens/home_screen.dart';
import 'package:flutter_fetch_api/pages/profile_page/profile_screen.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          FavoriteScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blueAccent,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
        ),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? SvgPicture.asset(
                    "assets/icons/house-blank-2.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.blueAccent,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    "assets/icons/house-blank.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? SvgPicture.asset(
                    "assets/icons/heart-2.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.blueAccent,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    "assets/icons/heart.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? SvgPicture.asset(
                    "assets/icons/shopping-cart-2.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.blueAccent,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    "assets/icons/shopping-cart.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? SvgPicture.asset(
                    "assets/icons/user-2.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.blueAccent,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    "assets/icons/user.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
