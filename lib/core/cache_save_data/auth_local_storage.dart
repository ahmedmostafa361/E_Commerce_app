import 'dart:convert';

import '../../domain/entinties/response/user_response.dart';
import '../cache_save_data/shared_prefrence.dart';

/// Caches the logged-in [User] on-device so screens like `ProfileScreen`
/// can read "who's logged in" without hitting the network again — there is
/// currently no "get current user" endpoint being called separately, so
/// this is populated straight from the login/register response.
///
/// Also stores two local-only overrides: [address] and [phone]. IMPORTANT:
/// neither has any backing field in your actual `User` DTO — confirmed the
/// backend does not return either. `phone` IS sent by the user at
/// registration (`RegisterRequest.phone`), so it's genuinely captured then
/// and cached locally right after a successful register — but it's still
/// never synced back from the server, and login gives no phone at all.
/// `address` has no source anywhere. If you later add real fields for
/// these on the backend, replace this local cache with a proper
/// update-profile / get-profile API call instead.
///
/// TODO: confirm the exact save-method name/signature on your
/// SharedPreferencesUtils — assumed `saveData({key, value})` to mirror the
/// `readData({key})` / `removeData({key})` calls already used elsewhere.
class AuthLocalStorage {
  AuthLocalStorage._();

  static const String _userKey = 'current_user';

  static Future<void> saveUser(User user) async {
    final Map<String, dynamic> map = {
      'name': user.name,
      'email': user.email,
      'role': user.role,
      // Preserve any locally-saved overrides across a fresh login.
      'address': getAddress(),
      'phone': getPhone(),
    };
    await SharedPreferencesUtils.saveData(
      key: _userKey,
      value: jsonEncode(map),
    );
  }

  static User? getUser() {
    final map = _readMap();
    if (map == null) return null;
    return User(
      name: map['name'] as String?,
      email: map['email'] as String?,
      role: map['role'] as String?,
    );
  }

  static Future<void> saveAddress(String address) async {
    final map = _readMap() ?? <String, dynamic>{};
    map['address'] = address;
    await SharedPreferencesUtils.saveData(
      key: _userKey,
      value: jsonEncode(map),
    );
  }

  static String? getAddress() {
    final map = _readMap();
    return map?['address'] as String?;
  }

  /// Call this right after a successful registration with the phone the
  /// user actually typed into the `RegisterRequest` — it's real input, just
  /// not something the backend echoes back or lets you fetch later.
  static Future<void> savePhone(String phone) async {
    final map = _readMap() ?? <String, dynamic>{};
    map['phone'] = phone;
    await SharedPreferencesUtils.saveData(
      key: _userKey,
      value: jsonEncode(map),
    );
  }

  static String? getPhone() {
    final map = _readMap();
    return map?['phone'] as String?;
  }

  static Future<void> clear() async {
    await SharedPreferencesUtils.removeData(key: _userKey);
  }

  static Map<String, dynamic>? _readMap() {
    final raw = SharedPreferencesUtils.readData(key: _userKey);
    if (raw == null || raw is! String || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
