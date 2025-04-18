import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarContent extends StatelessWidget {
  final bool collapsed;
  final VoidCallback onItemTap;

  const SidebarContent({
    Key? key,
    this.collapsed = false,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SidebarState.isPinned,
      builder: (context, isPinned, _) {
        return ListView(
          children: [
            const SizedBox(height: 40),
            ListTile(
              leading: Icon(
                isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                color: Colors.white,
              ),
              title: collapsed
                  ? null
                  : Text(
                      isPinned ? 'Pin' : 'UnPin ',
                      style: const TextStyle(color: Colors.white),
                    ),
              onTap: () {
                SidebarState.isPinned.value = !SidebarState.isPinned.value;
              },
            ),
            const Divider(color: Colors.white30),
            ListTile(
              leading: const Icon(Icons.calculate, color: Colors.white),
              title: collapsed
                  ? null
                  : const Text('ماشین حساب',
                      style: TextStyle(color: Colors.white)),
              onTap: () {
                context.go('/calc');
                onItemTap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: collapsed
                  ? null
                  : const Text('تنظیمات',
                      style: TextStyle(color: Colors.white)),
              onTap: () {
                context.go('/setting');
                onItemTap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: collapsed
                  ? null
                  : const Text('درباره ما',
                      style: TextStyle(color: Colors.white)),
              onTap: () {
                context.go('/about');
                onItemTap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.article, color: Colors.white),
              title: collapsed
                  ? null
                  : const Text('مقاله', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.go('/article');
                onItemTap();
              },
            ),
          ],
        );
      },
    );
  }
}

class SidebarState {
  static ValueNotifier<bool> isPinned = ValueNotifier<bool>(false);
}
