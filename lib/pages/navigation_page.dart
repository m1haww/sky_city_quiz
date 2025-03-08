import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/Settings_page.dart';
import 'package:sky_city_quiz/pages/quiz_page.dart';
import 'package:sky_city_quiz/pages/shopping_page.dart';
import 'package:sky_city_quiz/pages/start_quiz_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _select = 0;
  final Color _selected = Color(0xffFFB22C);

  final List<Widget> _pages = [StartQuizPage(), ShoppingPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _pages[_select],
      bottomNavigationBar: ClipRRect(
        child: CupertinoTabBar(
          backgroundColor: Colors.black,
          height: MediaQuery.of(context).size.height * 0.08,
          currentIndex: _select,
          onTap: (index) {
            setState(() {
              _select = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _select == 0 ? _selected : Colors.grey),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,
                  color: _select == 1 ? _selected : Colors.grey),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,
                  color: _select == 2 ? _selected : Colors.grey),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
