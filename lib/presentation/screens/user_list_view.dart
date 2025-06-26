import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';

class UserListView extends ConsumerWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: usersAsync.when(
        data: (users) => RefreshIndicator(
          onRefresh: () => ref.read(userListProvider.notifier).refresh(),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Failed to load users.'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.read(userListProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(userListProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add User'),
          onPressed: () => Navigator.pushNamed(context, '/post'),
        ),
      ),
    );
  }
}
