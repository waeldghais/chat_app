import 'package:chat_app/ui/Chat/showImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:video_player/video_player.dart';

import 'showVideo.dart';

class Message extends StatefulWidget {
  final String from;
  final String text;
  final bool me;
  final int type;
  final bool to;
  final bool toMe;
  final bool notMe;
  final bool isVideo;
  Message(
      {Key key,
      this.from,
      this.text,
      this.me,
      this.type,
      this.to,
      this.toMe,
      this.notMe,
      this.isVideo})
      : super(key: key);
  @override
  _Body createState() => _Body(
        from: from,
        text: text,
        me: me,
        type: type,
        to: to,
        toMe: toMe,
        notMe: notMe,
        isVideo: isVideo,
      );
}

class _Body extends State<Message> {
// Widget for Message
  _Body(
      {Key key,
      @required this.from,
      this.text,
      this.me,
      this.type,
      this.to,
      this.toMe,
      this.notMe,
      this.isVideo});

  final String from;
  final String text;
  final bool me;
  final int type;
  final bool to;
  final bool toMe;
  final bool notMe;
  final bool isVideo;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(text);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(10.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // My Alert Dialog for Delete Image
    Future<void> showMyDialogDeleteImage(int tr) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: tr == 1
                ? Text('Supprimer Image', style: TextStyle(color: Colors.red))
                : Text('Supprimer Video', style: TextStyle(color: Colors.red)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  tr == 1
                      ? Text(
                          'vous avez sur de Supprimer cette image!!',
                          style: TextStyle(color: Colors.black),
                        )
                      : Text(
                          'vous avez sur de Supprimer cette video!!',
                          style: TextStyle(color: Colors.black),
                        ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Non'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Oui'),
                onPressed: () {
                  deleteImage(context, text);
                },
              ),
            ],
          );
        },
      );
    }

    return to && me
        ? Container(
            child: Padding(
            padding: EdgeInsets.only(top: 10, right: 10, bottom: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //if type=1 ==> image
                type == 1
                    ? Padding(
                        padding: isVideo
                            ? EdgeInsets.only(left: 54)
                            : EdgeInsets.only(left: 102),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  color: Colors.blue,
                                  icon: Icon(Icons.cloud_download),
                                  onPressed: () => downloadImage(context, text),
                                ),
                                IconButton(
                                    color: Colors.blue,
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      isVideo
                                          ? showMyDialogDeleteImage(0)
                                          : showMyDialogDeleteImage(1);
                                    }),
                              ],
                            ),
                            isVideo
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: IconButton(
                                        color: Colors.blue,
                                        icon: Icon(_controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        onPressed: () {
                                          setState(() {
                                            if (_controller.value.isPlaying) {
                                              _controller.pause();
                                            } else {
                                              _controller.play();
                                            }
                                          });
                                        }),
                                  )
                                : Container(),
                            !isVideo
                                ? GestureDetector(
                                    child: Container(
                                      width: 200,
                                      child: Image(
                                        image: NetworkImage(text),
                                      ),
                                    ),
                                    onTap: () {
                                      print(text);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowImage(text: text)));
                                    },
                                  )
                                : GestureDetector(
                                    child: Container(
                                        width: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return AspectRatio(
                                                aspectRatio: _controller
                                                    .value.aspectRatio,
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        )),
                                    onTap: () {
                                      print(text);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowVideo(text: text)));
                                    },
                                  ),
                          ],
                        ),
                      )

                    //if type=0 ==> Simpel message
                    : Material(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 6.0,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: SelectableText(
                              text,
                            )),
                      )
              ],
            ),
          ))
        : toMe && notMe
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(from)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return Row(
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, bottom: 3),
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            snapshot.data.get('image')))),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 5, bottom: 3),
                                child:
                                    //if type=1 ==> image

                                    type == 1
                                        ? Row(
                                            children: [
                                              !isVideo
                                                  ? GestureDetector(
                                                      child: Container(
                                                        width: 200,
                                                        child: Image(
                                                          image: NetworkImage(
                                                              text),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ShowImage(
                                                                        text:
                                                                            text)));
                                                      },
                                                    )
                                                  : GestureDetector(
                                                      child: Container(
                                                          width: 200,
                                                          child: FutureBuilder(
                                                            future:
                                                                _initializeVideoPlayerFuture,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .done) {
                                                                return AspectRatio(
                                                                  aspectRatio:
                                                                      _controller
                                                                          .value
                                                                          .aspectRatio,
                                                                  child: VideoPlayer(
                                                                      _controller),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                            },
                                                          )),
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ShowVideo(
                                                                        text:
                                                                            text)));
                                                      },
                                                    ),
                                              isVideo
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  50),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  50),
                                                          topRight:
                                                              Radius.circular(
                                                                  50),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  50),
                                                        ),
                                                      ),
                                                      child: IconButton(
                                                          color: Colors.blue,
                                                          icon: Icon(_controller
                                                                  .value
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (_controller
                                                                  .value
                                                                  .isPlaying) {
                                                                _controller
                                                                    .pause();
                                                              } else {
                                                                _controller
                                                                    .play();
                                                              }
                                                            });
                                                          }),
                                                    )
                                                  : Container(),
                                              Column(children: [
                                                IconButton(
                                                  color: Colors.blue,
                                                  icon: Icon(
                                                      Icons.cloud_download),
                                                  onPressed: () =>
                                                      downloadImage(
                                                          context, text),
                                                ),
                                                IconButton(
                                                    color: Colors.blue,
                                                    icon: Icon(
                                                        Icons.delete_outline),
                                                    onPressed: () {
                                                      isVideo
                                                          ? showMyDialogDeleteImage(
                                                              0)
                                                          : showMyDialogDeleteImage(
                                                              1);
                                                    }),
                                              ]),
                                            ],
                                          )

                                        //if type=0 ==> Simpel message
                                        : Material(
                                            color: Colors.pink[300],
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            elevation: 6.0,
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 15.0),
                                                child: SelectableText(
                                                  text,
                                                )),
                                          ))
                          ],
                        ),
                      )
                    ],
                  );
                })
            : Container();
  }

  //Delete Image from chat
  Future deleteImage(context, text) async {
    await _firestore
        .collection('messages')
        .doc('${text.substring(68, 82)}')
        .delete();
    Navigator.of(context).pop();
  }
}

//download Image from chat
Future downloadImage(context, text) async {
  try {
    // Saved with this method.
    var imageId = await ImageDownloader.downloadImage(text);
    if (imageId == null) {
      return;
    }

    // Below is a method of obtaining saved image information.
    // ignore: unused_local_variable
    var fileName = await ImageDownloader.findName(imageId);

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Image $fileName telecharger'),
    ));
  } on PlatformException catch (error) {
    print(error);
  }
}
