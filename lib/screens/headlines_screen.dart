import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/shimmer_card.dart';
import 'detail_screen.dart';

class HeadlinesScreen extends StatelessWidget {
  const HeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'HEADLINES',
          style: GoogleFonts.robotoSlab(
            fontSize: 29,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFFFFFF),
            letterSpacing: 3,
          ),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, _) {
          if (provider.status == NewsStatus.loading) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              itemCount: 6,
              itemBuilder: (_, _) => const ShimmerCard(),
            );
          }

          if (provider.status == NewsStatus.error &&
              provider.articles.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white38, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: provider.fetchHeadlines,
                      child: Text(
                        'Retry',
                        style: GoogleFonts.robotoSlab(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.red,
            backgroundColor: Colors.black,
            onRefresh: provider.fetchHeadlines,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              itemCount: provider.articles.length,
              itemBuilder: (context, index) {
                final article = provider.articles[index];
                return ArticleCard(
                  article: article,
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 350),
                      pageBuilder: (context, animation,_) => FadeTransition(
                        opacity: animation,
                        child: DetailScreen(article: article),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}