import 'package:flutter/material.dart';
import '../brand_config.dart';
import '../app_language.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dynamic scale and shadow for premium hover animation
    final double cardScale = _isHovered ? 1.02 : 1.0;
    final double shadowElevation = _isHovered ? 8.0 : 0.0;

    return Semantics(
      label:
          'Product: ${widget.product.name}. Category: ${widget.product.category}. Price: ${AppLanguageProvider.of(context).formatPrice(widget.product.price, widget.product.egpPrice)}. Materials: ${widget.product.materials}.',
      hint:
          'Double tap or press enter to view detailed description and purchase options.',
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // ignore: deprecated_member_use
        transform: Matrix4.identity()..scale(cardScale),
        child: FocusableActionDetector(
          onShowHoverHighlight: (hovering) {
            setState(() {
              _isHovered = hovering;
            });
          },
          child: Card(
            elevation: shadowElevation,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: widget.onTap,
              focusColor: BrandColors.focus.withValues(alpha: 0.15),
              hoverColor: Colors.transparent, // Handled by AnimatedContainer
              highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: 'product_image_${widget.product.id}',
                            child: Image.asset(
                              widget.product.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: theme.colorScheme.surface,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 48,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Sustainability tag
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.9,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'SUSTAINABLE',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product Info Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Text(
                          widget.product.category.toUpperCase(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Product Name
                        Text(
                          widget.product.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        // Sustainable material summary (small)
                        Text(
                          widget.product.materials,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        // Price & "View Details"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLanguageProvider.of(context).formatPrice(widget.product.price, widget.product.egpPrice),
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'View Details →',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
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
          ),
        ),
      ),
    );
  }
}
