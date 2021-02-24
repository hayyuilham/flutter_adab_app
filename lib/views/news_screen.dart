import 'package:adab_app/models/adab_model.dart';
import 'package:adab_app/utils/shimmer_loader.dart';
import 'package:adab_app/utils/time_ago.dart';
import 'package:adab_app/views/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

class NewsList extends StatelessWidget {
  final List<NewsFeedResponseDatum> newsFeedList;

  const NewsList({Key key, this.newsFeedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newsFeedList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.all(8.0),
            padding: new EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 3.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          newsFeedList[index].accountOwner.avatar == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(80.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[300],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(80.0),
                                  child: Image.network(
                                    newsFeedList[index].accountOwner.avatar,
                                    height: 50.0,
                                    width: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 210,
                                  child: Text(
                                      newsFeedList[index].accountOwner.fullname,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15.0)),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      StringExtension
                                          .displayTimeAgoFromTimestamp(
                                              newsFeedList[index]
                                                  .createdAt
                                                  .toIso8601String()),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text('-'),
                                    SizedBox(width: 5.0),
                                    Text(newsFeedList[index]
                                        .permission
                                        .description),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.blue,
                        ),
                        iconSize: 20,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ParsedText(
                    text: newsFeedList[index].content,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    parse: <MatchText>[
                      MatchText(
                          pattern:
                              r"(@[^:]+)", //  pattern: r"\[(@[^:]+):([^\]]+)\]",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                          onTap: (url) async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        newsFeedList[index].taggedUser.length,
                                    itemBuilder: (context, idt) {
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Image.network(
                                              newsFeedList[index]
                                                  .taggedUser[idt]
                                                  .avatar,
                                              height: 30.0,
                                              width: 30.0,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    newsFeedList[index]
                                                        .taggedUser[idt]
                                                        .fullname,
                                                    style: TextStyle(
                                                        fontSize: 15.0)),
                                                Text(
                                                    '@${newsFeedList[index].taggedUser[idt].username}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0)),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                newsFeedList[index].media.isEmpty
                    ? Text('')
                    : Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: newsFeedList[index].media.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, idx) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        TutorialOverlay(
                                            newsMedia: newsFeedList[index]
                                                .media[idx])),
                                    child: newsFeedList[index].media.isEmpty
                                        ? ShimmerLoader(
                                            height: 15.0, width: 40.0)
                                        : Image.network(
                                            newsFeedList[index].media[idx].url,
                                            fit: BoxFit.fill,
                                          ),
                                  )));
                            },
                          ),
                        ],
                      ),
                newsFeedList[index].reaction.data == null
                    ? Text('')
                    : Column(
                        children: <Widget>[
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, idz) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RawMaterialButton(
                                          elevation: 1.0,
                                          fillColor: Colors.blue,
                                          child: Icon(
                                            Icons.thumb_up_alt_rounded,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                          shape: CircleBorder(),
                                        ),
                                        newsFeedList[index]
                                                    .reaction
                                                    .data
                                                    .like
                                                    .total >
                                                1
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(newsFeedList[index]
                                                        .reaction
                                                        .data
                                                        .like
                                                        .reaction[0]
                                                        .user
                                                        .fullname +
                                                    'and  ${newsFeedList[index].reaction.data.like.total} other'),
                                              )
                                            : SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(newsFeedList[index]
                                                    .reaction
                                                    .data
                                                    .like
                                                    .reaction[idz]
                                                    .user
                                                    .fullname),
                                              )
                                      ]),
                                );
                              }),
                        ],
                      ),
                Divider(
                  color: Colors.grey[300],
                  height: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.thumb_up_alt_rounded),
                            onPressed: null),
                        Text('Like', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.comment), onPressed: null),
                        newsFeedList[index].comment == null
                            ? Text('')
                            : Text(
                                newsFeedList[index]
                                    .comment
                                    .data
                                    .length
                                    .toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                        SizedBox(width: 3.0),
                        Text('Comment', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.rotate_right), onPressed: null),
                        Text('Share', style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                newsFeedList[index].comment == null
                    ? Text('')
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  newsFeedList[index].comment.data.length,
                              itemBuilder: (context, idy) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        newsFeedList[index].comment == null
                                            ? Container()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                                child: newsFeedList[index]
                                                            .comment
                                                            .data[idy]
                                                            .commentOwner
                                                            .avatar ==
                                                        null
                                                    ? Container(
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.grey[300],
                                                      )
                                                    : Image.network(
                                                        newsFeedList[index]
                                                            .comment
                                                            .data[idy]
                                                            .commentOwner
                                                            .avatar,
                                                        height: 30.0,
                                                        width: 30.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Card(
                                            elevation: 1.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Text(
                                                        newsFeedList[index]
                                                            .comment
                                                            .data[idy]
                                                            .commentOwner
                                                            .fullname,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 15.0)),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Text(
                                                        newsFeedList[index]
                                                            .comment
                                                            .data[idy]
                                                            .content,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                                Icons.thumb_up_alt_rounded),
                                            onPressed: null),
                                        Text('Like',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(' . Reply .',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          StringExtension
                                              .displayTimeAgoFromTimestamp(
                                                  newsFeedList[index]
                                                      .createdAt
                                                      .toIso8601String()),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
