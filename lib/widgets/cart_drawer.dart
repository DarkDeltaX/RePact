import 'package:flutter/material.dart';
import '../brand_config.dart';

// Represents an item added to the shopping cart
class CartItem {
  final Product product;
  final String size;
  final String color;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.color,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}

class CartDrawer extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(CartItem item) onIncrement;
  final Function(CartItem item) onDecrement;
  final Function(CartItem item) onRemove;
  final VoidCallback onCheckout;

  const CartDrawer({
    super.key,
    required this.cartItems,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate subtotal
    double subtotal = cartItems.fold(0, (sum, item) => sum + item.total);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Your Bag',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close bag',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Empty state or Items List
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your bag is empty',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Discover our sustainable styles.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: cartItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return _buildCartItem(context, item);
                      },
                    ),
            ),
            const Divider(height: 1),

            // Eco Impact Summary (Shown only if items exist)
            if (cartItems.isNotEmpty) _buildEcoSummary(context),

            // Footer Subtotal and Checkout
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$${subtotal.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Shipping & duties calculated at checkout. Free shipping on carbon-neutral orders over \$100.',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label:
                          'Proceed to checkout. Total order value: \$${subtotal.toStringAsFixed(2)}',
                      button: true,
                      child: ElevatedButton(
                        onPressed: onCheckout,
                        child: const Text('PROCEED TO CHECKOUT'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Individual Cart Item Widget
  Widget _buildCartItem(BuildContext context, CartItem item) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            item.product.imagePath,
            width: 80,
            height: 96,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 80,
              height: 96,
              color: theme.colorScheme.surface,
              child: const Icon(Icons.image_outlined),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Item Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Size: ${item.size}  •  Color: ${item.color}',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                'Materials: ${item.product.category == "Modest Wear" ? "Recyclable Linen/Bamboo" : "Organic Recycled Fibres"}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // Quantity adjust & Price Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Custom accessible quantity controls
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.15,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Semantics(
                          label: 'Decrease quantity of ${item.product.name}',
                          button: true,
                          child: IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: () => onDecrement(item),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${item.quantity}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Semantics(
                          label: 'Increase quantity of ${item.product.name}',
                          button: true,
                          child: IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () => onIncrement(item),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Item Total Price
                  Text(
                    '\$${item.total.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Remove Button
        Semantics(
          label: 'Remove ${item.product.name} from bag',
          button: true,
          child: IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              color: theme.colorScheme.error.withValues(alpha: 0.8),
              size: 20,
            ),
            onPressed: () => onRemove(item),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            alignment: Alignment.topRight,
          ),
        ),
      ],
    );
  }

  // Interactive Sustainability Summary Widget
  Widget _buildEcoSummary(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.eco_outlined,
                color: theme.colorScheme.secondary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'YOUR SUSTAINABILITY IMPACT',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'By opting for local flax linen, bamboo fibres, and recycled cotton, your selection supports closed-loop water systems and saves synthetic polymers from landfills. Feel good wearing garments designed to go back into the earth.',
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
