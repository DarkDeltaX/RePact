import 'package:flutter/material.dart';
import '../brand_config.dart';

class BrandHeader extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount;
  final String activeCategory;
  final Function(String category) onCategoryChanged;
  final ValueChanged<String> onSearchChanged;
  final String searchQuery;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onCartTap;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BrandHeader({
    super.key,
    required this.cartItemCount,
    required this.activeCategory,
    required this.onCategoryChanged,
    required this.onSearchChanged,
    required this.searchQuery,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onCartTap,
    required this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Semantics(
      header: true,
      label: 'Website header navigation bar',
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            // Left: Logo & Brand Name
            Semantics(
              label: '$brandName brand logo',
              child: InkWell(
                onTap: () => onCategoryChanged('All'),
                borderRadius: BorderRadius.circular(4),
                focusColor: BrandColors.focus.withValues(alpha: 0.15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    children: [
                      logoAssetPath != null
                          ? Image.asset(logoAssetPath!, height: 32)
                          : Text(
                              brandName,
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                              ),
                            ),
                      const SizedBox(width: 10),
                      if (isDesktop)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          child: Text(
                            'ECO',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.secondary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Middle: Category Tabs (Desktop only)
            if (isDesktop)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: ['All', 'Modest Wear', 'Essentials', 'Knitwear'].map((
                  cat,
                ) {
                  final isActive = activeCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Semantics(
                      selected: isActive,
                      button: true,
                      label: 'Category tab: $cat',
                      child: TextButton(
                        onPressed: () => onCategoryChanged(cat),
                        style: TextButton.styleFrom(
                          foregroundColor: isActive
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                        ),
                        child: Text(
                          cat.toUpperCase(),
                          style: TextStyle(
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

            if (isDesktop) const Spacer(),

            // Search Bar Input (Desktop only)
            if (isDesktop)
              Semantics(
                label: 'Search catalog text input field',
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search_rounded, size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(width: 16),

            // Theme Toggle Button
            Semantics(
              label: isDarkMode
                  ? 'Switch to light visual mode'
                  : 'Switch to dark visual mode',
              button: true,
              child: IconButton(
                icon: Icon(
                  isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
                onPressed: onThemeToggle,
                tooltip: 'Toggle Theme',
              ),
            ),

            const SizedBox(width: 8),

            // Cart Button with Badge
            Semantics(
              label:
                  'Shopping bag containing $cartItemCount items. Double tap to view your cart drawer.',
              button: true,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, size: 26),
                    onPressed: onCartTap,
                    tooltip: 'View Shopping Bag',
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Mobile Menu Button (Hamburger Drawer)
            if (!isDesktop) ...[
              const SizedBox(width: 8),
              Semantics(
                label:
                    'Open mobile side menu drawer containing product categories and filters',
                button: true,
                child: IconButton(
                  icon: const Icon(Icons.menu_rounded, size: 26),
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  tooltip: 'Menu',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BrandFooter extends StatelessWidget {
  const BrandFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Semantics(
      label:
          'Website footer bar containing brand credentials, policies, and newsletter signup',
      child: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          children: [
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Col 1: Brand details
                      Expanded(flex: 4, child: _buildBrandCol(context)),
                      const Spacer(),
                      // Col 2: Shop links
                      Expanded(flex: 2, child: _buildShortcutsCol(context)),
                      // Col 3: Sustainability details
                      Expanded(flex: 3, child: _buildEcoCommitmentCol(context)),
                      // Col 4: Newsletter signup
                      Expanded(flex: 3, child: _buildNewsletterCol(context)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandCol(context),
                      const SizedBox(height: 40),
                      _buildShortcutsCol(context),
                      const SizedBox(height: 40),
                      _buildEcoCommitmentCol(context),
                      const SizedBox(height: 40),
                      _buildNewsletterCol(context),
                    ],
                  ),
            const SizedBox(height: 60),
            const Divider(height: 1),
            const SizedBox(height: 30),

            // Sub-footer
            Row(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Text(
                  '© ${DateTime.now().year} $brandName Atelier. All Rights Reserved.',
                  style: theme.textTheme.bodySmall,
                ),
                if (isDesktop)
                  Row(
                    children: [
                      _buildFooterLink(context, 'Privacy Policy'),
                      const SizedBox(width: 20),
                      _buildFooterLink(context, 'Terms of Service'),
                      const SizedBox(width: 20),
                      _buildFooterLink(context, 'Accessibility Statement'),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandCol(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brandName,
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          brandTagline,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Crafting high-quality modest wear and contemporary essentials from circular, recyclable, and organic textiles. Zero polyester. Zero plastic microfibres. Woven for eternity.',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildShortcutsCol(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SHOP SECTIONS',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink(context, 'All Products'),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'Modest Abayas & Hijabs'),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'Organic Blouses & Jackets'),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'Cable Knitwear'),
      ],
    );
  }

  Widget _buildEcoCommitmentCol(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CIRCULAR DESIGN',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Our fabric selection uses GOTS certified linen, organic cotton, and closed-loop bamboo. Every purchase supports plastic-free circular manufacturing. Return your garments at end-of-life for store credit and fully recycle them.',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildNewsletterCol(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JOIN THE MOVEMENT',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Subscribe to get updates on sustainable drops and seasonal edits.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Semantics(
                label: 'Newsletter email subscription text field',
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Semantics(
              label: 'Submit newsletter email button',
              button: true,
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, size: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Semantics(
      link: true,
      label: 'Footer link to $title page',
      child: InkWell(
        onTap: () {},
        focusColor: BrandColors.focus.withValues(alpha: 0.15),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
