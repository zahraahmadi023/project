
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveLayout extends StatefulWidget {
  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool isSidebarCollapsed = true;

  void setSidebarCollapsed(bool value) {
    setState(() {
      isSidebarCollapsed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('ُTank '),
      ),
      body: Row(
        children: [
          if (isDesktop)
            MouseRegion(
              onEnter: (_) => setSidebarCollapsed(false),
              onExit: (_) => setSidebarCollapsed(true),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: isSidebarCollapsed ? 70 : 200,
                color: Colors.blueGrey[800],
                child: SidebarContent(
                  collapsed: isSidebarCollapsed,
                ),
              ),
            ),
          const Expanded(
            child: Center(
              child: Text(
                'Main',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarContent extends StatelessWidget {
  final bool collapsed;

  const SidebarContent({
    this.collapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.calculate, color: Colors.white),
          title: collapsed ? null : const Text('ماشین حساب', style: TextStyle(color: Colors.white)),
          onTap: () {
            context.go('/calc');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.white),
          title: collapsed ? null : const Text('تنظیمات', style: TextStyle(color: Colors.white)),
          onTap: () {
            context.go('/setting');
          },
        ),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.white),
          title: collapsed ? null : const Text('درباره ما', style: TextStyle(color: Colors.white)),
          onTap: () {
            context.go('/about');
          },
        ),
        ListTile(
          leading: const Icon(Icons.article, color: Colors.white),
          title: collapsed ? null : const Text('مقاله', style: TextStyle(color: Colors.white)),
          onTap: () {
            context.go('/article');
          },
        ),
      ],
    );
  }
}

