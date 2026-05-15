import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/article_details_cubit.dart';
import '../bloc/article_details_state.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailsScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleDetailsCubit>().fetchArticle(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "المحاضرة",
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
        builder: (context, state) {
          if (state is ArticleDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ArticleDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ArticleDetailsLoaded) {
            final article = state.article;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Html(data: article.content),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
