import 'package:flutter/material.dart';
import '../brand_config.dart';
import '../app_language.dart';

class ProductDetailDialog extends StatefulWidget {
  final Product product;
  final Function(Product product, String size, String color) onAddToCart;

  const ProductDetailDialog({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailDialog> createState() => _ProductDetailDialogState();
}

class _ProductDetailDialogState extends State<ProductDetailDialog> {
  late String _selectedSize;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.sizes.first;
    _selectedColor = widget.product.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 750;

    // Define content widgets to layout responsively
    Widget imageSection = Hero(
      tag: 'product_image_${widget.product.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          widget.product.imagePath,
          fit: BoxFit.cover,
          height: isDesktop ? double.infinity : 350,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: theme.colorScheme.surface,
              height: 350,
              child: Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 64,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            );
          },
        ),
      ),
    );

    Widget purchaseDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category tag
        Text(
          widget.product.category.toUpperCase(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),

        // Product title
        Text(
          widget.product.name,
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: isDesktop ? 32 : 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Price
        Text(
          AppLanguageProvider.of(context).formatPrice(widget.product.price, widget.product.egpPrice),
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Sustainability/Material Badge (Highlighting Circular Economy)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.recycling_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUSTAINABLE FABRIC DETAILS',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product.materials,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(AppLanguageProvider.of(context).t('materials'), style: theme.textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(widget.product.description, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 24),

        // Color selector
        Text('${AppLanguageProvider.of(context).t('colors')}: $_selectedColor', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: widget.product.colors.map((color) {
            final isSelected = _selectedColor == color;
            return Semantics(
              label: 'Color: $color',
              selected: isSelected,
              button: true,
              child: ChoiceChip(
                label: Text(color),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedColor = color);
                  }
                },
                selectedColor: theme.colorScheme.primary,
                disabledColor: theme.colorScheme.surface,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Size selector
        Text('${AppLanguageProvider.of(context).t('sizes')}: $_selectedSize', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: widget.product.sizes.map((sizeOption) {
            final isSelected = _selectedSize == sizeOption;
            return Semantics(
              label: 'Size: $sizeOption',
              selected: isSelected,
              button: true,
              child: ChoiceChip(
                label: Text(sizeOption),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedSize = sizeOption);
                  }
                },
                selectedColor: theme.colorScheme.primary,
                disabledColor: theme.colorScheme.surface,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // Add to Cart Button
        Semantics(
          label:
              'Add ${widget.product.name} in size $_selectedSize and color $_selectedColor to your shopping cart',
          button: true,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onAddToCart(
                  widget.product,
                  _selectedSize,
                  _selectedColor,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added ${widget.product.name} (Size: $_selectedSize, Color: $_selectedColor) to cart.',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(AppLanguageProvider.of(context).t('add_to_cart').toUpperCase()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ),
        ),
      ],
    );

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 900,
          maxHeight: isDesktop ? size.height * 0.8 : size.height * 0.9,
        ),
        child: Stack(
          children: [
            // Main Content Layout
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image on Left
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: imageSection,
                        ),
                      ),
                      // Scrollable Details on Right
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            top: 40,
                            right: 32,
                            bottom: 32,
                            left: 16,
                          ),
                          child: purchaseDetails,
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          imageSection,
                          const SizedBox(height: 24),
                          purchaseDetails,
                        ],
                      ),
                    ),
                  ),

            // Close Button
            Positioned(
              right: 8,
              top: 8,
              child: Semantics(
                label: 'Close product details dialog',
                button: true,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: AppLanguageProvider.of(context).t('close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
