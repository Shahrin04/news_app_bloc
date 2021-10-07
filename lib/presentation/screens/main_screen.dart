import 'package:flutter/material.dart';
import 'package:news_app/presentation/tabs/home_page.dart';
import 'package:news_app/presentation/tabs/search_page.dart';
import 'package:news_app/presentation/tabs/sources_page.dart';
import 'package:news_app/utils/universal_variables.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          backgroundColor: UniversalVariables.mainColor,
          title: Text(
            'News App',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [HomePage(), SourcesPage(), SearchPage()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey[100], spreadRadius: 0, blurRadius: 10)
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
              onTap: navigationTapped,
              backgroundColor: Colors.white,
              iconSize: 25,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    //label: 'Home',
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: (_page == 0)
                                ? UniversalVariables.mainColor
                                : Colors.grey),
                      ),
                    ),
                    icon: Icon(Icons.home,
                        color: (_page == 0)
                            ? UniversalVariables.mainColor
                            : Colors.grey)),
                BottomNavigationBarItem(
                    //label: 'Sources',
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Sources',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: (_page == 1)
                                ? UniversalVariables.mainColor
                                : Colors.grey),
                      ),
                    ),
                    icon: Icon(Icons.grid_view,
                        color: (_page == 1)
                            ? UniversalVariables.mainColor
                            : Colors.grey)),
                BottomNavigationBarItem(
                    //label: 'Search',
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: (_page == 2)
                                ? UniversalVariables.mainColor
                                : Colors.grey),
                      ),
                    ),
                    icon: Icon(Icons.search,
                        color: (_page == 2)
                            ? UniversalVariables.mainColor
                            : Colors.grey)),
              ]),
        ),
      ),
    );
  }
}
