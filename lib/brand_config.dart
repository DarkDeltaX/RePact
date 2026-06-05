import 'package:flutter/material.dart';

/// =========================================================================
/// REPACT ATELIER - BRAND & THEME CONFIGURATION
/// =========================================================================
///
/// Welcome! This file is designed so that you can easily customize the brand identity
/// without diving into complex UI code. Feel free to edit the colors, brand name,
/// font styles, and the product catalog below.
///

// -------------------------------------------------------------------------
// 1. BRAND STRINGS & IMAGES
// -------------------------------------------------------------------------
const String brandName = 'RePact';
const String brandTagline = 'SUSTAINABLE & MODEST ATELIER';
const String brandHeroTitle = 'Conscious Modesty for a Greener Tomorrow';
const String brandHeroSubtitle =
    'Timeless designs crafted from 100% organic, biodegradable, and recyclable fabrics.';

// Logo asset path (or null to use a clean typographic logo in the code)
const String? logoAssetPath =
    null; // Set to 'assets/images/logo.png' when ready

// Main hero image banner path
const String heroBannerAssetPath = 'assets/images/Second Life Collection (Line)4.jpeg';

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
  final double price;    // EUR price (Dutch/European market)
  final double egpPrice; // EGP price (Egyptian market)
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
    required this.egpPrice,
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
  // Denim Collection (6 items)
  Product(
    id: 'denim_01',
    name: 'Sustainable Raw Denim Jacket',
    price: 129.95,
    egpPrice: 3199,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)1.jpeg',
    materials: '100% Organic Cotton Denim',
    description: 'A timeless, raw denim jacket crafted with sustainable water-saving practices. Designed to age beautifully with you over time.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Indigo'],
  ),
  Product(
    id: 'denim_02',
    name: 'Classic Straight Jeans',
    price: 89.95,
    egpPrice: 1999,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)2.jpeg',
    materials: '100% Organic Cotton Denim',
    description: 'A classic straight-leg fit designed for everyday wear. Produced with zero toxic dyes.',
    sizes: ['28', '30', '32', '34'],
    colors: ['Vintage Wash'],
  ),
  Product(
    id: 'denim_03',
    name: 'Relaxed Wide-Leg Denim',
    price: 95.00,
    egpPrice: 2299,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)3.jpeg',
    materials: '100% Organic Cotton Denim',
    description: 'Wide-leg jeans offering a relaxed, comfortable silhouette with a high-rise waist.',
    sizes: ['26', '28', '30', '32'],
    colors: ['Light Blue'],
  ),
  Product(
    id: 'denim_04',
    name: 'Upcycled Denim Tote',
    price: 49.95,
    egpPrice: 899,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)4.jpeg',
    materials: '100% Upcycled Denim',
    description: 'A spacious and durable everyday tote bag made entirely from reclaimed denim fabrics.',
    sizes: ['One Size'],
    colors: ['Mixed Denim'],
  ),
  Product(
    id: 'denim_05',
    name: 'Oversized Denim Overshirt',
    price: 119.95,
    egpPrice: 2799,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)5.jpeg',
    materials: '100% Organic Cotton Denim',
    description: 'The perfect layering piece. This oversized shirt doubles as a lightweight jacket.',
    sizes: ['S', 'M', 'L'],
    colors: ['Deep Indigo'],
  ),
  Product(
    id: 'denim_06',
    name: 'Tailored Denim Midi Skirt',
    price: 79.95,
    egpPrice: 1699,
    category: 'Denim',
    imagePath: 'assets/images/Denim (Line)6.jpeg',
    materials: '100% Organic Cotton Denim',
    description: 'A sophisticated midi-length skirt with a front slit, made from soft, sustainable denim.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Mid-Blue Wash'],
  ),

  // Linen Collection (6 items)
  Product(
    id: 'linen_01',
    name: 'Relaxed Flax Linen Trousers',
    price: 89.95,
    egpPrice: 1799,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)1.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'Breathable, lightweight, and effortlessly chic. These linen trousers are perfect for conscious summer wardrobes.',
    sizes: ['S', 'M', 'L'],
    colors: ['Ivory', 'Natural Flax'],
  ),
  Product(
    id: 'linen_02',
    name: 'Breezy Linen Button-Down',
    price: 69.95,
    egpPrice: 1299,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)2.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'A loose-fit, lightweight button-down shirt that keeps you cool in warm climates.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Sage'],
  ),
  Product(
    id: 'linen_03',
    name: 'Wrap-Style Linen Dress',
    price: 119.00,
    egpPrice: 2499,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)3.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'An elegant midi wrap dress featuring adjustable ties and an incredibly soft texture.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Terracotta', 'Olive'],
  ),
  Product(
    id: 'linen_04',
    name: 'Linen Lounge Shorts',
    price: 49.95,
    egpPrice: 899,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)4.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'Comfortable, elastic-waist shorts ideal for lounging or a casual day out.',
    sizes: ['S', 'M', 'L'],
    colors: ['Navy', 'Oatmeal'],
  ),
  Product(
    id: 'linen_05',
    name: 'Boxy Linen Crop Top',
    price: 39.95,
    egpPrice: 699,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)5.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'A modern boxy crop top that pairs perfectly with high-waisted trousers or skirts.',
    sizes: ['XS', 'S', 'M'],
    colors: ['Mustard', 'White'],
  ),
  Product(
    id: 'linen_06',
    name: 'Lightweight Linen Blazer',
    price: 149.95,
    egpPrice: 3499,
    category: 'Linen',
    imagePath: 'assets/images/Linen (Line)6.jpeg',
    materials: '100% Organic Flax Linen',
    description: 'A smart-casual blazer tailored for warmer weather, offering a relaxed yet polished look.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Sand', 'Charcoal'],
  ),

  // Organic Cotton Collection (8 items)
  Product(
    id: 'cotton_01',
    name: 'Everyday Organic Cotton Tee',
    price: 29.95,
    egpPrice: 599,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)1.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'The perfect essential tee. Soft, durable, and grown without harmful chemicals or pesticides.',
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    colors: ['White', 'Earth Brown', 'Sage'],
  ),
  Product(
    id: 'cotton_02',
    name: 'Classic Crewneck Sweater',
    price: 59.95,
    egpPrice: 1299,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)2.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'A mid-weight crewneck sweater with ribbed cuffs. A versatile layer for any season.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Heather Grey', 'Navy'],
  ),
  Product(
    id: 'cotton_03',
    name: 'Ribbed Cotton Tank Top',
    price: 24.95,
    egpPrice: 449,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)3.jpeg',
    materials: '95% Organic Cotton, 5% Elastane',
    description: 'A form-fitting, soft ribbed tank top offering flexibility and breathability.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Black', 'White', 'Dusty Rose'],
  ),
  Product(
    id: 'cotton_04',
    name: 'Organic Cotton Sweatpants',
    price: 64.95,
    egpPrice: 1499,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)4.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'Lounge in style. These premium sweatpants offer a brushed interior for maximum comfort.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Charcoal', 'Oat'],
  ),
  Product(
    id: 'cotton_05',
    name: 'Long-Sleeve Henley',
    price: 39.95,
    egpPrice: 799,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)5.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'A classic three-button henley shirt, crafted for everyday softness and durability.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Forest Green', 'Off-White'],
  ),
  Product(
    id: 'cotton_06',
    name: 'Structured Cotton Chinos',
    price: 79.95,
    egpPrice: 1699,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)6.jpeg',
    materials: '100% GOTS Certified Organic Cotton Twill',
    description: 'Durable and sharp. These chinos are made from heavy-weight organic twill cotton.',
    sizes: ['30', '32', '34', '36'],
    colors: ['Khaki', 'Navy'],
  ),
  Product(
    id: 'cotton_07',
    name: 'Cotton Jersey Maxi Dress',
    price: 89.95,
    egpPrice: 1999,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)7.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'A flowing, ultra-soft maxi dress designed for ultimate comfort and elegant simplicity.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Black', 'Burgundy'],
  ),
  Product(
    id: 'cotton_08',
    name: 'Heavyweight Cotton Hoodie',
    price: 85.00,
    egpPrice: 1899,
    category: 'Organic Cotton',
    imagePath: 'assets/images/Organic Cotton (Line)8.jpeg',
    materials: '100% GOTS Certified Organic Cotton',
    description: 'A thick, cozy oversized hoodie featuring a roomy front pocket and an adjustable hood.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Stone', 'Black'],
  ),

  // Zero Waste Accessories Collection (10 items)
  Product(
    id: 'acc_01',
    name: 'Upcycled Canvas Tote Bag',
    price: 39.95,
    egpPrice: 749,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)1.jpeg',
    materials: '100% Upcycled Textile Scraps',
    description: 'A sturdy and spacious tote bag made entirely from studio offcuts. Zero waste, maximum utility.',
    sizes: ['One Size'],
    colors: ['Mixed Patchwork'],
  ),
  Product(
    id: 'acc_02',
    name: 'Reclaimed Fabric Scrunchie Set',
    price: 14.95,
    egpPrice: 249,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)2.jpeg',
    materials: 'Upcycled Silk and Cotton Scraps',
    description: 'A set of three soft hair scrunchies sewn from leftover premium fabrics.',
    sizes: ['One Size'],
    colors: ['Assorted Colors'],
  ),
  Product(
    id: 'acc_03',
    name: 'Minimalist Card Holder',
    price: 24.95,
    egpPrice: 449,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)3.jpeg',
    materials: 'Plant-based Vegan Leather (Cactus)',
    description: 'A sleek, 4-slot card holder crafted from innovative biodegradable cactus leather.',
    sizes: ['One Size'],
    colors: ['Desert Green'],
  ),
  Product(
    id: 'acc_04',
    name: 'Zero-Waste Crossbody Pouch',
    price: 45.00,
    egpPrice: 899,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)4.jpeg',
    materials: '100% Upcycled Cotton Canvas',
    description: 'Perfect for holding your essentials on the go. Features an adjustable strap and zip closure.',
    sizes: ['One Size'],
    colors: ['Natural Unbleached'],
  ),
  Product(
    id: 'acc_05',
    name: 'Woven Recycled Belt',
    price: 29.95,
    egpPrice: 549,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)5.jpeg',
    materials: 'Recycled Post-Consumer Plastics & Cotton',
    description: 'A highly durable woven belt made from a blend of recycled ocean plastics and cotton fibers.',
    sizes: ['S', 'M', 'L'],
    colors: ['Charcoal/Grey'],
  ),
  Product(
    id: 'acc_06',
    name: 'Patchwork Bucket Hat',
    price: 34.95,
    egpPrice: 649,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)6.jpeg',
    materials: 'Upcycled Denim and Twill Scraps',
    description: 'Stay shaded in style. This bucket hat is uniquely pieced together from fabric offcuts.',
    sizes: ['S/M', 'L/XL'],
    colors: ['Blue Patchwork'],
  ),
  Product(
    id: 'acc_07',
    name: 'Reusable Produce Bags (Set of 3)',
    price: 18.95,
    egpPrice: 299,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)7.jpeg',
    materials: '100% Organic Cotton Mesh',
    description: 'Eliminate single-use plastics with these strong, breathable organic cotton mesh bags for groceries.',
    sizes: ['Small, Medium, Large'],
    colors: ['Natural'],
  ),
  Product(
    id: 'acc_08',
    name: 'Scrap-Yarn Beanie',
    price: 29.95,
    egpPrice: 499,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)8.jpeg',
    materials: '100% Reclaimed Wool & Cotton Yarn',
    description: 'A warm, thick beanie knit from surplus yarn, making each piece beautifully unique.',
    sizes: ['One Size'],
    colors: ['Speckled Grey'],
  ),
  Product(
    id: 'acc_09',
    name: 'Upcycled Denim Pencil Case',
    price: 22.95,
    egpPrice: 399,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)9.jpeg',
    materials: '100% Upcycled Denim',
    description: 'A durable zippered pouch ideal for stationery or small cosmetics, featuring a recycled brass zipper.',
    sizes: ['One Size'],
    colors: ['Indigo'],
  ),
  Product(
    id: 'acc_10',
    name: 'Plant-Leather Keyring',
    price: 15.95,
    egpPrice: 249,
    category: 'Zero Waste Accessories',
    imagePath: 'assets/images/Accessories Zero Waste Collection (Line)10.jpeg',
    materials: 'Plant-based Vegan Leather (Apple Peel)',
    description: 'A minimal and elegant keyring crafted from apple waste leather alternatives.',
    sizes: ['One Size'],
    colors: ['Tan'],
  ),
];
