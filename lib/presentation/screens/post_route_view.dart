import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';

class PostRouteView extends ConsumerStatefulWidget {
  const PostRouteView({super.key});

  @override
  ConsumerState<PostRouteView> createState() => _PostRouteViewState();
}

class _PostRouteViewState extends ConsumerState<PostRouteView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(postUserProvider);

    ref.listen(postUserProvider, (prev, next) {
      if (next is AsyncData && (next.value?.isNotEmpty ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User Created: ${nameController.text}, Job: ${jobController.text}',
            ),
          ),
        );
        nameController.clear();
        jobController.clear();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(labelText: 'Job'),
            ),
            const SizedBox(height: 24),
            postAsync.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      ref
                          .read(postUserProvider.notifier)
                          .postUser(nameController.text, jobController.text);
                    },
                    child: const Text('Submit'),
                  ),
            if (postAsync.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    const Text('Failed to post user.'),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(postUserProvider.notifier)
                            .postUser(nameController.text, jobController.text);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
