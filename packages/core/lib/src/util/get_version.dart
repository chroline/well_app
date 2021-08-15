import 'package:package_info_plus/package_info_plus.dart';

Future<String> getVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();

  final version = packageInfo.version;
  final buildNumber = packageInfo.buildNumber;

  return version + '+' + buildNumber;
}
