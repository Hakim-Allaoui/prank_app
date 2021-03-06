import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/strings.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/widgets/widgets.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_1);
    ads.loadAdmobInter(AdsHelper.admobInterId_1);
    customDrawer = new CustomDrawer(() => ads.showInter());
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      backgroundColor: MyColors.primary,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -200.0,
            top: -50.0,
            child: Opacity(
              child: SvgPicture.asset(
                'assets/icons/privacy_policy.svg',
                width: 500.0,
              ),
              opacity: 0.2,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar(
                  scaffoldKey: scaffoldKey,
                  title: Strings.privacy,
                  ads: ads.getFbNativeBanner(
                      AdsHelper.fbNativeBannerId, NativeBannerAdSize.HEIGHT_50),
                  onClicked: () => ads.showInter(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        Strings.privacyText,
                        textStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                MainButton(
                  title: Text(
                    'Return',
                    style: MyTextStyles.bigTitle
                        .apply(color: MyColors.white),
                  ),
                  svgIcon: 'assets/icons/back.svg',
                  bgColor: MyColors.black,
                  textColor: MyColors.white,
                  onClicked: () {
                    ads.showInter(probablity: 80);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
