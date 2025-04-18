import 'package:flutter/material.dart';
import 'package:project/widgets/sidbar.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool isSidebarCollapsed = true;

  void setSidebarCollapsed(bool value) {
    if (!SidebarState.isPinned.value) {
      setState(() {
        isSidebarCollapsed = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlue,
      //   title: const Text("Tank"),
      //   leading: isDesktop
      //       ? null
      //       : Builder(
      //           builder: (context) => IconButton(
      //             icon: const Icon(Icons.menu),
      //             onPressed: () => Scaffold.of(context).openDrawer(),
      //           ),
      //         ),
      // ),
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: Colors.blueGrey[800],
              child: SidebarContent(
                collapsed: false,
                onItemTap: () => Navigator.pop(context),
              ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            ValueListenableBuilder<bool>(
              valueListenable: SidebarState.isPinned,
              builder: (context, isPinned, _) {
                return MouseRegion(
                  onEnter: (_) => setSidebarCollapsed(false),
                  onExit: (_) => setSidebarCollapsed(true),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isPinned || !isSidebarCollapsed ? 200 : 70,
                    color: Colors.blueGrey[800],
                    child: SidebarContent(
                      onItemTap: () {},
                      collapsed: !(isPinned || !isSidebarCollapsed),
                    ),
                  ),
                );
              },
            ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
