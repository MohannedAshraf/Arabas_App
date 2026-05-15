// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/free_content_cubit.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/free_content_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreeContentScreen extends StatefulWidget {
  const FreeContentScreen({super.key});

  @override
  State<FreeContentScreen> createState() => _FreeContentScreenState();
}

class _FreeContentScreenState extends State<FreeContentScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<FreeContentCubit>().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "القسم المجاني",
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textGray,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          onTap: (index) {
            if (index == 0) {
              context.read<FreeContentCubit>().fetchArticles();
            } else {
              context.read<FreeContentCubit>().fetchVideos();
            }
          },
          tabs: const [Tab(text: "المحاضرات"), Tab(text: "الفيديوهات")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [_articlesTab(), _videosTab()],
      ),
    );
  }

  /// ================= Articles =================

  Widget _articlesTab() {
    return BlocBuilder<FreeContentCubit, FreeContentState>(
      builder: (context, state) {
        if (state is FreeContentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ArticlesLoaded) {
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              final article = state.articles[index];

              return _cardItem(
                title: article.title,
                color: AppColors.primary,
                icon: Icons.arrow_forward_ios,
                onTap: () {
                  // 🔥 التنقل لصفحة تفاصيل المحاضرة
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ArticleDetailsScreen(
                  //       articleId: article.id,
                  //     ),
                  //   ),
                  // );
                },
              );
            },
          );
        }

        if (state is FreeContentError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }

  /// ================= Videos =================

  Widget _videosTab() {
    return BlocBuilder<FreeContentCubit, FreeContentState>(
      builder: (context, state) {
        if (state is FreeContentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is VideosLoaded) {
          return ListView.builder(
            itemCount: state.videos.length,
            itemBuilder: (context, index) {
              final video = state.videos[index];

              return _cardItem(
                title: video.title,
                color: AppColors.primary,
                icon: Icons.play_circle_fill,
                onTap: () {
                  // 🔥 التنقل لصفحة تشغيل الفيديو
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => VideoPlayerScreen(
                  //       videoId: video.id,
                  //     ),
                  //   ),
                  // );
                },
              );
            },
          );
        }

        if (state is FreeContentError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }

  /// ================= Shared Card =================

  Widget _cardItem({
    required String title,
    required Color color,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: color),
        ),
        trailing: Icon(icon, color: color),
      ),
    );
  }
}
