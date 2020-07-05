
import 'package:coriander/main.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(//画面の見た目の部分
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("２ページ目"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name),
            Center(
              child: RaisedButton(//buttonの種類はたくさんあるのでいろいろなマテリアルを使ってみる
                child: Text('戻る'),
                onPressed: (){//ここに押したら反応するアクションを描く
                  Navigator.pop(
                    context,'帰ってきた値だよ');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}