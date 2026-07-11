import 'dart:convert';

import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';

/// Persists the color/size a user picked on the Product Details screen,
/// keyed by productId — purely on-device.
///
/// This exists because the cart API only accepts a `productId` (see
/// `AddToCartUseCase.invoke(String productId)`) and the cart response
/// models (`AddCart` / `AddProduct` / `GetProducts`) carry no color/size
/// field at all. The backend has no concept of product variants, so this
/// is a local-only convenience for display purposes on the Cart screen —
/// it is NOT synced with the server and NOT authoritative.
///
/// Known limitation: since the server tracks one quantity per product (not
/// per variant), adding the same product again with a different size/color
/// will overwrite the previously remembered choice for that productId.
class CartVariantsStorage {
  CartVariantsStorage._();

  static const String _storageKey = 'cart_item_variants';

  static Future<void> saveVariant({
    required String productId,
    required int colorValue,
    required String size,
  }) async {
    if (productId.isEmpty) return;

    final Map<String, dynamic> all = _readAll();
    all[productId] = {'color': colorValue, 'size': size};

    // TODO: confirm the exact save-method name/signature on your
    // SharedPreferencesUtils — assumed `saveData({key, value})` to mirror
    // the `readData({key})` call already used in main.dart.
    await SharedPreferencesUtils.saveData(
      key: _storageKey,
      value: jsonEncode(all),
    );
  }

  /// Returns `{'color': int, 'size': String}` for [productId], or null if
  /// nothing has been saved for it yet.
  static Map<String, dynamic>? getVariant(String productId) {
    if (productId.isEmpty) return null;
    final all = _readAll();
    final entry = all[productId];
    if (entry == null) return null;
    return {'color': entry['color'] as int, 'size': entry['size'] as String};
  }

  static Map<String, dynamic> _readAll() {
    final raw = SharedPreferencesUtils.readData(key: _storageKey);
    if (raw == null || raw is! String || raw.isEmpty) return {};
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
