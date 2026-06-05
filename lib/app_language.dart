import 'package:flutter/material.dart';

// =========================================================================
// APP LANGUAGE - Language & Currency Manager
// =========================================================================
// Holds the current locale and provides translated strings + currency formatting.
// Widgets can call AppLanguage.of(context) to get the current instance.

class AppLanguage extends ChangeNotifier {
  // Singleton
  static final AppLanguage _instance = AppLanguage._internal();
  factory AppLanguage() => _instance;
  AppLanguage._internal();

  String _locale = 'en'; // 'en', 'nl', 'ar'

  String get locale => _locale;
  bool get isArabic => _locale == 'ar';
  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  void setLocale(String locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  // -------------------------------------------------------------------------
  // CURRENCY FORMATTING
  // -------------------------------------------------------------------------
  String formatPrice(double eurPrice, double egpPrice) {
    if (_locale == 'ar') {
      // Egyptian Pound
      final formatted = egpPrice.toStringAsFixed(0);
      return 'ج.م $formatted';
    } else {
      // Euro
      return '€${eurPrice.toStringAsFixed(2)}';
    }
  }

  String formatPriceRaw(double eurPrice, double egpPrice) {
    if (_locale == 'ar') {
      return 'ج.م ${egpPrice.toStringAsFixed(0)}';
    }
    return '€${eurPrice.toStringAsFixed(2)}';
  }

  // -------------------------------------------------------------------------
  // TRANSLATIONS
  // -------------------------------------------------------------------------
  String t(String key) => _strings[_locale]?[key] ?? _strings['en']?[key] ?? key;

  static const Map<String, Map<String, String>> _strings = {
    // --- ENGLISH ---
    'en': {
      // Brand
      'brand_tagline': 'SUSTAINABLE & MODEST ATELIER',
      'hero_title': 'Conscious Modesty for a Greener Tomorrow',
      'hero_subtitle':
          'Timeless designs crafted from 100% organic, biodegradable, and recyclable fabrics.',
      'hero_cta': 'SHOP NOW',

      // Navigation categories
      'cat_all': 'All Products',
      'cat_denim': 'Denim',
      'cat_linen': 'Linen',
      'cat_cotton': 'Organic Cotton',
      'cat_accessories': 'Zero Waste Accessories',

      // Sections
      'section_trending': 'TRENDING',
      'section_second_life': 'SECOND LIFE COLLECTION',
      'second_life_desc':
          'Give pre-loved pieces a new beginning. Curated vintage and upcycled items.',
      'section_about': 'ABOUT US',

      // About
      'about_mission_title': 'OUR MISSION',
      'about_mission_body':
          'The business aims to offer stylish, affordable, and sustainable fashion products to environmentally conscious consumers. The brand\'s value proposition is based on combining sustainability, quality, and affordability.',
      'about_vision_title': 'OUR VISION',
      'about_vision_body':
          'To become a leading international sustainable fashion brand that inspires responsible consumption and contributes to a more environmentally conscious future.',
      'about_values_title': 'OUR VALUES',
      'value_sustainability': 'Sustainability First',
      'value_quality': 'Uncompromising Quality',
      'value_integrity': 'Integrity & Transparency',
      'value_customer': 'Customer-Centred Approach',

      // Product detail
      'materials': 'Materials',
      'sizes': 'Sizes',
      'colors': 'Colors',
      'add_to_cart': 'Add to Cart',
      'close': 'Close',

      // Cart
      'cart_title': 'Your Cart',
      'cart_empty': 'Your cart is empty.',
      'cart_subtotal': 'Subtotal',
      'checkout': 'Proceed to Checkout',

      // Search
      'search_hint': 'Search products...',
      'no_results': 'No products match your search.',

      // Header
      'change_language': 'Change Language',
      'toggle_theme': 'Toggle theme',

      // Footer
      'footer_shop': 'Shop',
      'footer_about': 'About',
      'footer_contact': 'Contact',
      'footer_rights': '© 2025 RePact. All rights reserved.',
      'footer_eco': 'Eco-certified. Sustainably produced.',
    },

    // --- DUTCH ---
    'nl': {
      // Brand
      'brand_tagline': 'DUURZAAM & BESCHEIDEN ATELIER',
      'hero_title': 'Bewuste Bescheidenheid voor een Groenere Morgen',
      'hero_subtitle':
          'Tijdloze ontwerpen gemaakt van 100% biologische, afbreekbare en recyclebare stoffen.',
      'hero_cta': 'NU WINKELEN',

      // Navigation
      'cat_all': 'Alle Producten',
      'cat_denim': 'Denim',
      'cat_linen': 'Linnen',
      'cat_cotton': 'Biologisch Katoen',
      'cat_accessories': 'Zero Waste Accessoires',

      // Sections
      'section_trending': 'TRENDING',
      'section_second_life': 'SECOND LIFE COLLECTIE',
      'second_life_desc':
          'Geef gedragen stukken een nieuw leven. Gecureerde vintage en gerecyclede items.',
      'section_about': 'OVER ONS',

      // About
      'about_mission_title': 'ONZE MISSIE',
      'about_mission_body':
          'Het bedrijf streeft ernaar stijlvolle, betaalbare en duurzame modeproducten aan te bieden aan milieubewuste consumenten.',
      'about_vision_title': 'ONZE VISIE',
      'about_vision_body':
          'Een toonaangevend internationaal duurzaam modemerk worden dat verantwoorde consumptie inspireert.',
      'about_values_title': 'ONZE WAARDEN',
      'value_sustainability': 'Duurzaamheid Voorop',
      'value_quality': 'Ongecompromitteerde Kwaliteit',
      'value_integrity': 'Integriteit & Transparantie',
      'value_customer': 'Klantgerichte Aanpak',

      // Product detail
      'materials': 'Materialen',
      'sizes': 'Maten',
      'colors': 'Kleuren',
      'add_to_cart': 'In Winkelwagen',
      'close': 'Sluiten',

      // Cart
      'cart_title': 'Uw Winkelwagen',
      'cart_empty': 'Uw winkelwagen is leeg.',
      'cart_subtotal': 'Subtotaal',
      'checkout': 'Doorgaan naar Afrekenen',

      // Search
      'search_hint': 'Zoek producten...',
      'no_results': 'Geen producten gevonden.',

      // Header
      'change_language': 'Taal wijzigen',
      'toggle_theme': 'Thema wisselen',

      // Footer
      'footer_shop': 'Winkel',
      'footer_about': 'Over ons',
      'footer_contact': 'Contact',
      'footer_rights': '© 2025 RePact. Alle rechten voorbehouden.',
      'footer_eco': 'Eco-gecertificeerd. Duurzaam geproduceerd.',
    },

    // --- ARABIC ---
    'ar': {
      // Brand
      'brand_tagline': 'أتيليه مستدام وأنيق',
      'hero_title': 'تواضع واعٍ من أجل غدٍ أكثر خضرة',
      'hero_subtitle':
          'تصاميم خالدة مصنوعة من أقمشة عضوية وقابلة للتحلل وإعادة التدوير بنسبة 100٪.',
      'hero_cta': 'تسوق الآن',

      // Navigation
      'cat_all': 'جميع المنتجات',
      'cat_denim': 'دنيم',
      'cat_linen': 'كتان',
      'cat_cotton': 'قطن عضوي',
      'cat_accessories': 'إكسسوارات صديقة للبيئة',

      // Sections
      'section_trending': 'الأكثر رواجاً',
      'section_second_life': 'مجموعة الحياة الثانية',
      'second_life_desc':
          'امنح قطعاً مستعملة بداية جديدة. عناصر خمر منتقاة بعناية.',
      'section_about': 'من نحن',

      // About
      'about_mission_title': 'مهمتنا',
      'about_mission_body':
          'يهدف العمل إلى تقديم منتجات أزياء أنيقة وبأسعار معقولة ومستدامة للمستهلكين المهتمين بالبيئة.',
      'about_vision_title': 'رؤيتنا',
      'about_vision_body':
          'أن نصبح علامة تجارية دولية رائدة في مجال الأزياء المستدامة، تلهم الاستهلاك المسؤول.',
      'about_values_title': 'قيمنا',
      'value_sustainability': 'الاستدامة أولاً',
      'value_quality': 'جودة لا تُقايض',
      'value_integrity': 'النزاهة والشفافية',
      'value_customer': 'نهج يركّز على العميل',

      // Product detail
      'materials': 'المواد',
      'sizes': 'المقاسات',
      'colors': 'الألوان',
      'add_to_cart': 'أضف إلى السلة',
      'close': 'إغلاق',

      // Cart
      'cart_title': 'سلة التسوق',
      'cart_empty': 'سلة التسوق فارغة.',
      'cart_subtotal': 'المجموع الفرعي',
      'checkout': 'المتابعة للدفع',

      // Search
      'search_hint': 'ابحث عن منتجات...',
      'no_results': 'لا توجد منتجات تطابق بحثك.',

      // Header
      'change_language': 'تغيير اللغة',
      'toggle_theme': 'تبديل السمة',

      // Footer
      'footer_shop': 'تسوق',
      'footer_about': 'من نحن',
      'footer_contact': 'اتصل بنا',
      'footer_rights': '© 2025 RePact. جميع الحقوق محفوظة.',
      'footer_eco': 'معتمد بيئياً. منتج باستدامة.',
    },
  };
}

// =========================================================================
// INHERITED WIDGET - Access AppLanguage anywhere with context
// =========================================================================
class AppLanguageProvider extends InheritedNotifier<AppLanguage> {
  const AppLanguageProvider({
    super.key,
    required AppLanguage language,
    required super.child,
  }) : super(notifier: language);

  static AppLanguage of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppLanguageProvider>();
    assert(provider != null, 'No AppLanguageProvider found in context');
    return provider!.notifier!;
  }
}
