import 'package:coriander/domain/book.dart';
import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:coriander/presentation/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map((book) => ListTile(
                      title: Text(book.title),
                      trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            //TODO 画面遷移
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBookPage(
                                  book: book,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                            model.fetchBooks();
                          }),
                      onLongPress: () {
                        //todo 削除
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('${book.title}を削除しますか？！'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    //TODO 削除のAPIを叩く
                                    await deleteBook(context, model, book);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              //TODO　登録機能つける
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }

  Future deleteBook(
      BuildContext context, BookListModel model, Book book) async {
    try {
//      await model.addBookToFirebase();
      await model.deleteBook(book);
      await model.fetchBooks();
      _showDialog(context, '削除しました');
    } catch (e) {
      _showDialog(context, e.toString());
    }
  }

  Future _showDialog(BuildContext context, String e) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e),
          actions: <Widget>[
            FlatButton(
              child: Text('閉じる'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
