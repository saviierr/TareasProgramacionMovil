import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_resilencia/providers/post_provider.dart';
import 'package:app_resilencia/widgets/shimmer_loading.dart';
import 'package:app_resilencia/widgets/error_view.dart';
import 'package:app_resilencia/widgets/empty_view.dart';
import 'package:app_resilencia/widgets/post_card.dart';

/// Home screen that displays posts
///
/// Uses Consumer to listen to PostProvider state changes
/// Renders different widgets based on the current state:
/// - Loading: ShimmerLoading
/// - Success: ListView of PostCards
/// - Empty: EmptyView
/// - Error: ErrorView with retry button
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch posts when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Publicaciones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Refresh button
          Consumer<PostProvider>(
            builder: (context, provider, child) {
              // Only show refresh if not loading
              if (provider.currentState != PostState.loading) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => provider.fetchPosts(),
                  tooltip: 'Actualizar',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          // Render different widgets based on current state
          switch (provider.currentState) {
            case PostState.loading:
              return const ShimmerLoading();

            case PostState.success:
              return RefreshIndicator(
                onRefresh: () => provider.fetchPosts(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: provider.posts[index]);
                  },
                ),
              );

            case PostState.empty:
              return const EmptyView();

            case PostState.error:
              return ErrorView(
                message: provider.errorMessage,
                onRetry: provider.retry,
              );
          }
        },
      ),
    );
  }
}
