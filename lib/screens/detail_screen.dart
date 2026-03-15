import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen background image
          Positioned.fill(
            child: Hero(
              tag: article.url ?? article.title,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: const Color(0xFF464646)),
                errorWidget: (context, url, error) =>
                    Container(color: const Color(0xFF464646)),
              ),
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x44000000),
                    Color(0xCC000000),
                    Color(0xEE000000),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Back button — 42dp x 42dp
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: SizedBox(
              width: 42,
              height: 42,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Content at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title — left 24dp, color #f2f2f2, 29sp, bold
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
                      child: Text(
                        _cleanTitle(article.title, article.source),
                        style: GoogleFonts.robotoSlab(
                          fontSize: 29,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF2F2F2),
                          height: 1.3,
                        ),
                      ),
                    ),

                    // 64dp gap between title and source/date
                    const SizedBox(height: 64),

                    // Source + Date — 20sp, #f2f2f2, regular
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.source ?? '',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFF2F2F2),
                            ),
                          ),
                          Text(
                            _formatDate(article.publishedAt),
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 16dp gap between source/date and description
                    const SizedBox(height: 16),

                    // Description — 14sp, #bababa, regular — puri aayegi
                    if (article.description != null &&
                        article.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
                        child: Text(
                          article.description!,
                          style: GoogleFonts.robotoSlab(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFFBABABA),
                            height: 1.6,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.length < 10) return '';
    return iso.substring(0, 10);
  }

  String _cleanTitle(String title, String? source) {
    if (source == null) return title;
    return title.replaceAll(' - $source', '').trim();
  }
}