import 'package:flutter/material.dart';
import 'brand_config.dart';
import 'brand_theme.dart';
import 'widgets/product_card.dart';
import 'widgets/product_detail.dart';
import 'widgets/cart_drawer.dart';
import 'widgets/header_footer.dart';

void main() {
  runApp(const ClothingStoreApp());
}

class ClothingStoreApp extends StatefulWidget {
  const ClothingStoreApp({super.key});

  @override
  State<ClothingStoreApp> createState() => _ClothingStoreAppState();
}

class _ClothingStoreAppState extends State<ClothingStoreApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: brandName,
      debugShowCheckedModeBanner: false,
      theme: BrandTheme.lightTheme,
      darkTheme: BrandTheme.darkTheme,
      themeMode: _themeMode,
      home: MainStorePage(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

class MainStorePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MainStorePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MainStorePage> createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<CartItem> _cart = [];
  String _activeCategory = 'All';
  String _searchQuery = '';

  // Filter products based on search query and category
  List<Product> get _filteredProducts {
    return productCatalog.where((product) {
      final matchesCategory =
          _activeCategory == 'All' || product.category == _activeCategory;
      final matchesSearch =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.materials.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // -------------------------------------------------------------------------
  // CART STATE ACTIONS
  // -------------------------------------------------------------------------
  void _addToCart(Product product, String size, String color) {
    setState(() {
      // Check if exact same item (product, size, color) exists
      final existingIndex = _cart.indexWhere(
        (item) =>
            item.product.id == product.id &&
            item.size == size &&
            item.color == color,
      );

      if (existingIndex >= 0) {
        _cart[existingIndex].quantity += 1;
      } else {
        _cart.add(
          CartItem(product: product, size: size, color: color, quantity: 1),
        );
      }
    });
  }

  void _incrementCartItem(CartItem item) {
    setState(() {
      item.quantity += 1;
    });
  }

  void _decrementCartItem(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        _cart.remove(item);
      }
    });
  }

  void _removeCartItem(CartItem item) {
    setState(() {
      _cart.remove(item);
    });
  }

  void _handleCheckout() {
    // Show checkout success modal
    Navigator.of(context).pop(); // Close cart drawer
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text('Order Placed Successfully!'),
            ],
          ),
          content: const Text(
            'Thank you for supporting sustainable fashion! We have received your order and are preparing carbon-neutral shipping in 100% recyclable plant-based packaging.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _cart.clear());
                Navigator.of(context).pop();
              },
              child: const Text('CONTINUE SHOPPING'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    // Count total items in the shopping bag
    int totalCartItems = _cart.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      key: _scaffoldKey,
      appBar: BrandHeader(
        cartItemCount: totalCartItems,
        activeCategory: _activeCategory,
        onCategoryChanged: (cat) {
          setState(() {
            _activeCategory = cat;
          });
        },
        onSearchChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        searchQuery: _searchQuery,
        isDarkMode: widget.isDarkMode,
        onThemeToggle: widget.onThemeToggle,
        onCartTap: () => _scaffoldKey.currentState?.openEndDrawer(),
        scaffoldKey: _scaffoldKey,
      ),

      // Mobile Menu Navigation Drawer (Left Side)
      drawer: !isDesktop
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: theme.colorScheme.surface),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          brandName,
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          brandTagline,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Mobile Search input
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  // Categories Link
                  ...['All', 'Modest Wear', 'Essentials', 'Knitwear'].map((
                    cat,
                  ) {
                    final isActive = _activeCategory == cat;
                    return Semantics(
                      selected: isActive,
                      button: true,
                      label: 'Navigate to category $cat',
                      child: ListTile(
                        title: Text(
                          cat.toUpperCase(),
                          style: TextStyle(
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isActive
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _activeCategory = cat;
                          });
                          Navigator.of(context).pop(); // Close drawer
                        },
                      ),
                    );
                  }),
                ],
              ),
            )
          : null,

      // Shopping Cart End Drawer (Right Side)
      endDrawer: CartDrawer(
        cartItems: _cart,
        onIncrement: _incrementCartItem,
        onDecrement: _decrementCartItem,
        onRemove: _removeCartItem,
        onCheckout: _handleCheckout,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. HERO CAMPAIGN BANNER SECTION
            _buildHeroSection(context),

            // 2. SUSTAINABILITY VALUE PROPOSITIONS BAR
            _buildSustainabilityProps(context),

            // 3. PRODUCT CATALOG GRID
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _activeCategory == 'All'
                                ? 'THE COLLECTION'
                                : _activeCategory.toUpperCase(),
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isDesktop ? 30 : 24,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Showing ${_filteredProducts.length} of ${productCatalog.length} conscious products',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Products Grid
                  _filteredProducts.isEmpty
                      ? SizedBox(
                          height: 250,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 48,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products matches your search.',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            // Responsive column counts
                            int columns = 1;
                            if (constraints.maxWidth > 1200) {
                              columns = 4;
                            } else if (constraints.maxWidth > 800) {
                              columns = 3;
                            } else if (constraints.maxWidth > 500) {
                              columns = 2;
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _filteredProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: columns,
                                    childAspectRatio: 0.68,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 32,
                                  ),
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];
                                return ProductCard(
                                  product: product,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ProductDetailDialog(
                                          product: product,
                                          onAddToCart: _addToCart,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),

            // 4. THE BRAND FOOTER
            const BrandFooter(),
          ],
        ),
      ),
    );
  }

  // Hero Campaign Section
  Widget _buildHeroSection(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Semantics(
      label: 'Campaign banner: $brandHeroTitle',
      child: Container(
        height: isMobile ? 420 : 600,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(heroBannerAssetPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withValues(alpha: 0.45),
                Colors.black.withValues(alpha: 0.15),
              ],
            ),
          ),
          padding: const EdgeInsets.all(40.0),
          alignment: isMobile ? Alignment.bottomLeft : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hexToColor(hexPrimaryLight),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      '100% CIRCULAR FASHION',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: hexToColor(hexPrimaryLight),
                        letterSpacing: 1,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    brandHeroTitle,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 26 : 34,
                      fontWeight: FontWeight.bold,
                      color: hexToColor(hexPrimaryLight),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    brandHeroSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: hexToColor(hexTextMutedLight),
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Semantics(
                    label: 'CTA Button: Shop the sustainable collection',
                    button: true,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _activeCategory = 'All';
                        });
                        // Smoothly scroll down to product grid
                        Scrollable.ensureVisible(
                          _scaffoldKey.currentContext!,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hexToColor(hexPrimaryLight),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('SHOP THE COLLECTION'),
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

  // Sustainability Propositions Bar
  Widget _buildSustainabilityProps(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 750;

    final List<Map<String, dynamic>> props = [
      {
        'icon': Icons.spa_outlined,
        'title': 'Organic & Recyclable',
        'desc':
            'Zero synthetics. Zero microplastics. Woven strictly from flax linen, bamboo, & merino wool.',
      },
      {
        'icon': Icons.loop_rounded,
        'title': 'Circular Lifecycles',
        'desc':
            'Every item is 100% biodegradable. Return used items for recycling & credit.',
      },
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Carbon Neutral Deliveries',
        'desc':
            'Offsetting all logistics footprints with sustainable cardboard shipping packaging.',
      },
    ];

    Widget buildPropCard(Map<String, dynamic> prop) {
      return Expanded(
        flex: isMobile ? 0 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                prop['icon'] as IconData,
                color: theme.colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prop['title'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      prop['desc'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: isMobile
          ? Column(children: props.map((prop) => buildPropCard(prop)).toList())
          : Row(children: props.map((prop) => buildPropCard(prop)).toList()),
    );
  }
}
