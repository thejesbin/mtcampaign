import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamiclinkService {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  static Future<String> createDynamicLink(String referCode) async {
    String _linkMessage;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://mtcampaign.page.link',
      link: Uri.parse('https://mtcampaign.page.link/$referCode'),
      androidParameters: const AndroidParameters(
        packageName: 'com.mtcampaign.app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.mtcampaign.app',
        minimumVersion: '0',
      ),
    );
    Uri url;
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    url = shortLink.shortUrl;
    _linkMessage = url.toString();
    return _linkMessage;
  }
}
