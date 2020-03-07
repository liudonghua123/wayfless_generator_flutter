import 'package:flutter/material.dart';
// import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:styled_text/styled_text.dart';

import '../data.dart';
import 'dart:core';

class HomePageContent extends StatefulWidget {
  HomePageContent({Key key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

var heading = Text(
  'WAYFless',
  style: TextStyle(
    fontSize: 24,
    color: Colors.blue,
  ),
);
var style = {
  'heading': TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    shadows: [
      Shadow(
        color: Colors.blue,
        blurRadius: 5,
        offset: Offset(5.0, 5.0),
      ),
    ],
  ),
  'code': TextStyle(backgroundColor: Colors.yellow),
  'bold': TextStyle(fontWeight: FontWeight.bold),
};
var introduce = [
  StyledText(
    text:
        '''<heading>WAYFless</heading>是一种通过将<code>IDP</code>地址组合在<code>URL</code>中，避免用户在采用<code>Shibboleth</code>认证时必须先选择自己所在机构的方法，省去了不同<code>SP</code>界面各不相同的复杂认证步骤。''',
    styles: style,
  ),
  StyledText(
    text:
        '''请在下面输入框中输入您自己所在学校<code>idp</code>系统的域名，例如输入<code>idp.ynu.edu.cn</code>，列表中即可自动生成<code>idp.ynu.edu.cn</code>对应的各大数据库的<bold>WAYFless</bold>链接，可以点击其后的复制或打开进行后续操作。''',
    styles: style,
  ),
  StyledText(
    text: '''加入<code>CARSI</code>联盟的各个学校均可使用此方式，方便用户使用。''',
    styles: style,
  ),
  StyledText(
    text:
        '''本词条由深圳大学图书馆、香港中文大学(深圳)图书馆、清华大学图书馆共同维护。本列表内容较多，可以根据数据库名称输入过滤字词进行过滤筛选！''',
    styles: style,
  ),
];

var domainNameReg = new RegExp(r"^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$");

class _HomePageContentState extends State<HomePageContent> {
  String idp_domain_prefix = '', idp_domain_search = '';

  @override
  Widget build(BuildContext context) {
    var form = Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: '请输入域名'),
              onChanged: (text) {
                setState(() {
                  idp_domain_prefix = text;
                });
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: '请输入搜索关键词',
              ),
              onChanged: (text) {
                setState(() {
                  idp_domain_search = text;
                });
              },
            ),
          ),
        ],
      ),
    );
    var filteredData = data
        .where((item) =>
            item.title.toLowerCase().contains(idp_domain_search.toLowerCase()))
        .toList();
    var entries = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: filteredData.length,
          itemBuilder: (BuildContext context, int index) {
            var item = filteredData[index];
            var accessWidgets = item.accessURLs.map((accessURL) {
              var url = Uri.decodeComponent(
                  accessURL.replaceAll(r'{idp_domain}', idp_domain_prefix));
              var enable = accessURL.contains('{idp_domain}') &&
                  domainNameReg.hasMatch(idp_domain_prefix);
              return Container(
                margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: enable
                      ? Colors.greenAccent.withOpacity(0.5)
                      : Colors.redAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Tooltip(
                        message: url,
                        waitDuration: Duration(seconds: 1),
                        margin: EdgeInsets.all(24.0),
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          url,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        icon: Icon(Icons.insert_drive_file),
                        onPressed: enable
                            ? () async {
                                // https://api.flutter.dev/flutter/services/Clipboard-class.html
                                await Clipboard.setData(
                                    ClipboardData(text: url));
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Copied to Clipboard'),
                                ));
                              }
                            : null),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: enable
                            ? () async {
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Could not launch $url'),
                                ));
                              }
                            : null)
                  ],
                ),
              );
            }).toList();
            return Container(
              constraints: BoxConstraints(minHeight: 50),
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.blue,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(child: Text(item.title.substring(0, 2))),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  constraints: BoxConstraints(minHeight: 30),
                                  child: Column(
                                    children: accessWidgets,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            heading,
            SizedBox(
              height: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: introduce,
            ),
            SizedBox(
              height: 16,
            ),
            form,
            SizedBox(
              height: 16,
            ),
            entries,
          ],
        ));
  }
}
