import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF464646),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Hero(
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

            // Dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xDD000000)],
                  stops: [0.2, 1.0],
                ),
              ),
            ),

            // Text content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title — 29sp Bold #ffffff
                  Text(
                    _cleanTitle(article.title, article.source),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoSlab(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF2F2F2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Source + date — 12sp Bold #bababa
                  Row(
                    children: [
                      Text(
                        article.source ?? '',
                        style: GoogleFonts.robotoSlab(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFBABABA),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _formatDate(article.publishedAt),
                        style: GoogleFonts.robotoSlab(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFBABABA),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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