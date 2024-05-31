abstract class Assets {
  const Assets._();

  // ignore: library_private_types_in_public_api
  static _Icons get icons => const _Icons();

  // ignore: library_private_types_in_public_api
  static _Images get images => const _Images();

// ignore: library_private_types_in_public_api
  static _Lottie get lotties => const _Lottie();

  // ignore: library_private_types_in_public_api
  // static _ChannelsList get channelList => _ChannelsList();

  // ignore: library_private_types_in_public_api
  static _Videos get videos => const _Videos();
}

abstract class _AssetsHolder {
  final String basePath;

  const _AssetsHolder(this.basePath);
}

class _Icons extends _AssetsHolder {
  const _Icons() : super('assets/icons');

  // String get logo => "$basePath/logo.png";

  String get onboardingBg => "$basePath/omboarding_bg.png";

  String get addCircle => "$basePath/add_circle.svg";

  String get phone => "$basePath/phone.svg";

  String get clear => "$basePath/clear.svg";

  String get eyeClose => "$basePath/eye_close.svg";

  String get eyeOpen => "$basePath/eye_open.svg";

  String get favorite => "$basePath/favorite.svg";

  String get home => "$basePath/home.svg";

  String get search2 => "$basePath/search2.svg";

  String get heart => "$basePath/heart.svg";

  String get shoppingCard => "$basePath/shopping-cart.svg";

  String get user => "$basePath/user.svg";

  String get logout => "$basePath/logout.svg";

  String get language => "$basePath/language.svg";

  String get location => "$basePath/map-marker.svg";

  String get story => "$basePath/time.svg";

  String get edit => "$basePath/edit.svg";

  String get menu => "$basePath/menu.svg";

  String get profile => "$basePath/profile.svg";

  String get removeCircle => "$basePath/remove_circle.svg";

  String get search => "$basePath/search.svg";

  String get filter => "$basePath/filter.svg";

  String get newLogo => "$basePath/new_logo.jpg";

  String get logoB => "$basePath/b.svg";

  String get navHome => "$basePath/nav_bar/home.svg";

  String get navHomeFilled => "$basePath/nav_bar/home_filled.svg";

  String get navHeart => "$basePath/nav_bar/heart.svg";

  String get navHeartFilled => "$basePath/nav_bar/heart_filled.svg";

  String get navSearch => "$basePath/nav_bar/search.svg";

  String get navSearchFilled => "$basePath/nav_bar/search_filled.svg";

  String get navCart => "$basePath/nav_bar/shopping-cart.svg";

  String get navCartFilled => "$basePath/nav_bar/shopping-cart_filled.svg";

  String get navUser => "$basePath/nav_bar/user.svg";

  String get navUserFilled => "$basePath/nav_bar/user_filled.svg";
}

class _Images extends _AssetsHolder {
  const _Images() : super('assets/images');

  String get backgroudImage => "$basePath/background.png";

  String get backgroudDesctopImage => "$basePath/background_desctop.png";

  String get onlineBuy => "$basePath/onb3.jpg";

  String get onlineBuy2 => "$basePath/onb1.jpg";

  String get onlineBuy3 => "$basePath/onb2.png";

  String get successful => "$basePath/img_successful.svg";

  String get addToCart => "$basePath/add_to_cart.svg";

  String get shoppingCuate => "$basePath/shopping-cuate.png";

  String get register => "$basePath/register.jpg";

  String get profileAppBar => "$basePath/profile_appbar.png";

  String get confirm => "$basePath/confirm.png";
}

class _Lottie extends _AssetsHolder {
  const _Lottie() : super('assets/lottie');

  String get success => "$basePath/success.json";

  String get error => "$basePath/error.json";
}

class _Videos extends _AssetsHolder {
  const _Videos() : super('assets/videos');
}
