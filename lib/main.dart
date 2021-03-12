import 'package:flutter/material.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';

import 'screens/news_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var urlList = [
      'https://www.marvel.com/articles/movies/falcon-and-winter-soldier-entertainment-weekly-odd-couple',
      'https://www.marvel.com/articles/movies/spider-man-no-way-home-tom-holland-title-reveal',
      'https://www.marvel.com/articles/comics/heroes-reborn-newly-revealed-covers-june',
      'https://www.marvel.com/articles/comics/white-vision-reprogrammed-disassembled-comics',
      'https://www.marvel.com/articles/comics/avengers-curse-of-the-man-thing-meet-the-harrower',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white12,
        child: ListView.builder(
          itemCount: urlList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewsDetails(urlList[index]))),
              child: FlutterLinkPreview(
                url: urlList[index],
                bodyStyle: TextStyle(fontSize: 18.0),
                titleStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                builder: (webInfo) {
                  if (webInfo is WebInfo) {
                    return SizedBox(
                      height: 350,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                webInfo.image == null
                                    ? 'https://via.placeholder.com/150'
                                    : webInfo.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                              child: Text(
                                webInfo.title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (webInfo.description != null)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(webInfo.description),
                              ),
                          ],
                        ),
                      ),
                    );
                  } else if (webInfo is WebImageInfo) {
                    return SizedBox(
                      height: 350,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                webInfo.image == null
                                    ? 'https://via.placeholder.com/150'
                                    : webInfo.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    var detected = webInfo as WebVideoInfo;
                    return detected != null
                        ? SizedBox(
                            height: 350,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      detected.image == null
                                          ? 'https://via.placeholder.com/150'
                                          : detected.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }
                },
              ),
            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
