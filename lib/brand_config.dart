import 'package:flutter/material.dart';

/// =========================================================================
/// RE:SEWIT ATELIER - BRAND & THEME CONFIGURATION
/// =========================================================================
///
/// Welcome! This file is designed so that you can easily customize the brand identity
/// without diving into complex UI code. Feel free to edit the colors, brand name,
/// font styles, and the product catalog below.
///

// -------------------------------------------------------------------------
// 1. BRAND STRINGS & IMAGES
// -------------------------------------------------------------------------
const String brandName = 'Re:Sewit';
const String brandTagline = 'SUSTAINABLE & MODEST ATELIER';
const String brandHeroTitle = 'Conscious Modesty for a Greener Tomorrow';
const String brandHeroSubtitle =
    'Timeless designs crafted from 100% organic, biodegradable, and recyclable fabrics.';

// Logo asset path (or null to use a clean typographic logo in the code)
const String? logoAssetPath =
    null; // Set to 'assets/images/logo.png' when ready

// Main hero image banner path
const String heroBannerAssetPath = 'assets/images/hero_banner.png';

// -------------------------------------------------------------------------
// 2. DESIGN TOKENS (COLORS) - EDIT THESE HEX CODES TO CHANGE THE LOOK!
// -------------------------------------------------------------------------
// Hex colors must start with '#' followed by 6 characters (e.g., '#FFFFFF')

// Light Theme Colors
const String hexPrimaryLight = '#2D3E35'; // Deep Sage Green (Luxury/Earth feel)
const String hexSecondaryLight = '#8C7D70'; // Earthy Taupe / Clay
const String hexBackgroundLight = '#FAF8F5'; // Warm Off-White / Cream
const String hexSurfaceLight = '#F3EFEA'; // Sand / Card background
const String hexTextMainLight =
    '#1C2821'; // Very dark green-grey (A11y contrast)
const String hexTextMutedLight = '#5C6B61'; // Muted grey-green

// Dark Theme Colors (Optional toggle for high contrast/dark mode users)
const String hexPrimaryDark = '#FAF8F5'; // Off-white text/accents
const String hexSecondaryDark = '#B09E90'; // Soft Warm Grey
const String hexBackgroundDark = '#121C17'; // Deep Forest Black
const String hexSurfaceDark = '#1B2921'; // Muted Green-Black card background
const String hexTextMainDark = '#FAF8F5'; // Main readable text
const String hexTextMutedDark = '#9EAEA2'; // Secondary text

// A11y & Focus colors
const String hexFocusOutline =
    '#D0A97E'; // Gold outline for keyboard navigation focus
const String hexAlertColor = '#8A3324'; // Red/Rust for errors or warning items

// -------------------------------------------------------------------------
// 3. COLOR HELPER (Converts hex string to Flutter Color object)
// -------------------------------------------------------------------------
Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

// Getters to fetch actual Flutter Color objects
class BrandColors {
  static Color get primary => hexToColor(hexPrimaryLight);
  static Color get secondary => hexToColor(hexSecondaryLight);
  static Color get background => hexToColor(hexBackgroundLight);
  static Color get surface => hexToColor(hexSurfaceLight);
  static Color get textMain => hexToColor(hexTextMainLight);
  static Color get textMuted => hexToColor(hexTextMutedLight);

  static Color get focus => hexToColor(hexFocusOutline);
  static Color get alert => hexToColor(hexAlertColor);

  // Dark mode getters
  static Color get primaryDark => hexToColor(hexPrimaryDark);
  static Color get secondaryDark => hexToColor(hexSecondaryDark);
  static Color get backgroundDark => hexToColor(hexBackgroundDark);
  static Color get surfaceDark => hexToColor(hexSurfaceDark);
  static Color get textMainDark => hexToColor(hexTextMainDark);
  static Color get textMutedDark => hexToColor(hexTextMutedDark);
}

// -------------------------------------------------------------------------
// 4. PRODUCT CATALOG - ADD OR EDIT PRODUCTS HERE!
// -------------------------------------------------------------------------
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imagePath;
  final String materials;
  final String category;
  final List<String> sizes;
  final List<String> colors;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.materials,
    required this.category,
    required this.sizes,
    required this.colors,
  });
}

// The active list of products sold on the website
const List<Product> productCatalog = [
  Product(
    id: 'abaya_01',
    name: 'Sustainable Linen Abaya',
    price: 149.00,
    category: 'Modest Wear',
    imagePath: 'assets/images/abaya.png',
    materials: '100% Organic Flax Linen (100% Biodegradable & Recyclable)',
    description:
        'An elegant, fluid abaya tailored from premium organic linen. Breathable, hypoallergenic, and zero-waste construction, featuring dynamic sleeve buttons and hidden deep side pockets.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Desert Sand', 'Olive Sage', 'Charcoal'],
  ),
  Product(
    id: 'hijab_01',
    name: 'Bamboo-Cotton Hijab Scarf',
    price: 29.00,
    category: 'Modest Wear',
    imagePath: 'assets/images/hijab.png',
    materials: '70% Bamboo Viscose, 30% Organic Cotton (Recyclable fibres)',
    description:
        'Ultra-soft, lightweight modest hijab scarf crafted from sustainable bamboo. Features thermoregulating properties and a natural drape, finished with hand-rolled hems.',
    sizes: ['One Size (70 x 180 cm)'],
    colors: ['Oatmeal', 'Sage Green', 'Dusty Rose'],
  ),
  Product(
    id: 'jacket_01',
    name: 'Minimalist Trench Coat',
    price: 189.00,
    category: 'Essentials',
    imagePath: 'assets/images/jacket.png',
    materials: '100% Recycled Post-Consumer Cotton (Circularity Approved)',
    description:
        'A timeless, double-breasted utility jacket with a clean profile. Built for durability from recycled heavy-duty cotton weaves and completed with biodegradable corozo-nut buttons.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Camel', 'Earthy Clay'],
  ),
  Product(
    id: 'shirt_01',
    name: 'Relaxed Classic Linen Shirt',
    price: 89.00,
    category: 'Essentials',
    imagePath: 'assets/images/shirt.png',
    materials: '100% Organic Flax Linen (Earth-safe dyes)',
    description:
        'A summer essential, this relaxed button-down shirt is woven with local organic flax. Garment-dyed with low-impact botanical extracts for a beautiful lived-in look.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Ivory White', 'Flax Tan'],
  ),
  Product(
    id: 'sweater_01',
    name: 'Heavy-Knit Merino Sweater',
    price: 129.00,
    category: 'Knitwear',
    imagePath: 'assets/images/sweater.png',
    materials: '100% RWS Certified Merino Wool (Naturally Recyclable)',
    description:
        'A chunky, high-collar cable-knit sweater providing natural thermal insulation. Made from Responsible Wool Standard certified merino wool, yielding zero synthetic microplastics.',
    sizes: ['S', 'M', 'L'],
    colors: ['Forest Green', 'Wheat Beige'],
  ),
];
