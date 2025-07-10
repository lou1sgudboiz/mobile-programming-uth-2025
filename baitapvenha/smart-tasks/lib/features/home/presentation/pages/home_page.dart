// lib/features/task/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_tasks/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:smart_tasks/features/task/presentation/pages/task_list_page.dart';
import 'package:smart_tasks/injection.dart';

final pages = [
  const TaskListPage(),
  const Center(child: Text('Calendar Page')),
  const Center(child: Text('Settings Placeholder')),
  const Center(child: Text('Notes Page')),
];

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _showSettingsMenu(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                if (user != null) {
                  context.push('/profile');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                context.go('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                Navigator.pop(context);
                await ref.read(authViewModelProvider.notifier).signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: pages[selectedPage],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.zero,
        // padding: EdgeInsets.only(bottom: 20.0),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 8,
          borderRadius: BorderRadius.circular(40),
          shadowColor: Colors.black,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 2.0,
                color: Colors.white,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          size: 22,
                          color: selectedPage == 0 ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () =>
                            ref.read(selectedPageProvider.notifier).state = 0,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          size: 22,
                          color: selectedPage == 1 ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () =>
                            ref.read(selectedPageProvider.notifier).state = 1,
                      ),
                      const SizedBox(width: 40),
                      IconButton(
                        icon: Icon(
                          Icons.description,
                          size: 22,
                          color: selectedPage == 3 ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () =>
                            ref.read(selectedPageProvider.notifier).state = 3,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 22,
                          color: selectedPage == 2 ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () => _showSettingsMenu(context, ref),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        heroTag: 'add-task',
        shape: const CircleBorder(),
        elevation: 4.0,
        onPressed: () => context.push('/add-task'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
