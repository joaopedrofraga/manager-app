class AppImages {
  static final AppImages _singleton = AppImages._internal();

  factory AppImages() {
    return _singleton;
  }

  AppImages._internal();

  static String get homePage => 'assets/images/home_page.svg';
}
