import 'package:firebase_admob/firebase_admob.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['brinquedos', 'jogos infantis'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[],
);

// ********************Banner
BannerAd myBanner;

void startBanner() {
  myBanner = BannerAd(
    adUnitId:  'ca-app-pub-8122823024752023/2182871675', //BannerAd.testAdUnitId,
    size: AdSize.fullBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.opened) {
        // MobileAdEvent.opened
        // MobileAdEvent.clicked
        // MobileAdEvent.closed
        // MobileAdEvent.failedToLoad
        // MobileAdEvent.impression
        // MobileAdEvent.leftApplication
      }
      print("BannerAd event is $event");
    },
  );
}

void displayBanner() {
  myBanner
    ..load()
    ..show(
      anchorOffset: 0.0,
      anchorType: AnchorType.bottom,
    );
}
// ********************Banner