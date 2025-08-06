import 'package:flutter/material.dart';

class AutoScrollPageView extends StatefulWidget {
  @override
  _AutoScrollPageViewState createState() => _AutoScrollPageViewState();
}

class _AutoScrollPageViewState extends State<AutoScrollPageView> {
  late PageController _pageController;
  int _pageIndex = 0;
  final int _pageCount = 5;
  bool _isScrolling = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    while (_isScrolling && mounted) {
      await Future.delayed(const Duration(seconds: 2));

      if (!_pageController.hasClients) continue;

      _pageIndex = (_pageIndex + 1) % _pageCount;

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _isScrolling = false;
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _buildPages() {
    return List.generate(
      _pageCount,
          (index) => Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Page ${index + 1}',
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auto-Scroll PageView')),
      body: PageView(
        controller: _pageController,
        children: _buildPages(),
      ),
    );
  }
}
