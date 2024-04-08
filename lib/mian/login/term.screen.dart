// ignore_for_file: unused_field

import 'package:film_film/constants/evi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import '../../constants/button.not.click.multi.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  InAppWebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.blue,
          leading: ButtonNotClickMulti(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          leadingWidth: 50,
          title: Text(
            "Terms",
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          centerTitle: true,
          actions: [
            const SizedBox(
              width: 44,
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/appbar.jpg"), fit: BoxFit.cover)),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InAppWebView(
            initialSettings: InAppWebViewSettings(),
            initialUrlRequest: URLRequest(url: WebUri(urlTerm)),
            onLoadStart: (controller, url) {
              print('start webview');

              print(url);
            },
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onReceivedError: (controller, request, error) {
              print('error webview');

              print(error);
            },
            onConsoleMessage: (controller, consoleMessage) {},
            onLoadStop: (controller, url) {
              print('onLoadStop webview');

              print(url);
            },
          ),
        ),
      ),
    );
  }
}
