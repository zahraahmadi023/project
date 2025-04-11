
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar:AppBar(
        backgroundColor: Colors.lightBlue,
        title:Text("Tank") ,
        leading: isDesktop
            ? null
            : Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

      ),
      drawer: isDesktop
          ? null
          : Drawer(
        backgroundColor:Colors.blueGrey[800],
        child: SidebarContent(
          collapsed: false,
          onItemTap: () => Navigator.pop(context),
        ),
      ),
      body:  Row(
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
                  onItemTap: (){},
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
    this.collapsed = false, required void Function() onItemTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 40,),
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

