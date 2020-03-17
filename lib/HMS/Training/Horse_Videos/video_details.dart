import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class video_details extends StatefulWidget{
  String url;

  video_details(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _video_details_state(url);
  }

}
class _video_details_state extends State<video_details>{
  String url;

  _video_details_state(this.url);
  ProgressDialog pd;

  @override
  void initState() {
    super.initState();
    print(url);
    pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
  }

  @override
  Widget build(BuildContext context)
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child:  WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        ),
      )
    );
}
