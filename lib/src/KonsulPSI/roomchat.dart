import 'dart:convert';

import 'package:esdm/src/Config/config_konsultasi.dart';
import 'package:esdm/src/Model/konsultasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pubnub/pubnub.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

const String defaultUserName = "Aldi Firmansyah";

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      title: "Pesan",
      theme:
          defaultTargetPlatform == TargetPlatform.iOS ? iOSTheme : androidTheme,
      home: new Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final PubNub _client = PubNub(PubNubConfig(ConfigKonsultasi.PublishKey, ConfigKonsultasi.SubscribeKey));
  Konsultasi _konsultasi = new Konsultasi();
  final List<Msg> _message = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    try{
      getChat();
    }catch (exception) {
    }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi Psikologi'),
        backgroundColor: Colors.green,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _message[index],
              itemCount: _message.length,
              reverse: true,
              padding: new EdgeInsets.all(6.0),
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            child: _buildComposer(),
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          )
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Ketik di sini"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 3.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: new Text('Submit'),
                        onPressed: _isWriting
                            ? () => _submitMsg(_textController.text)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isWriting
                            ? () => _submitMsg(_textController.text)
                            : null,
                      ),
              )
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(
                    top: new BorderSide(color: Colors.brown[200]),
                  ),
                )
              : null),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      sender:defaultUserName,
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    _client.publish(([ConfigKonsultasi.Channel]), {'sender':defaultUserName,'message': txt});
    setState(() {
      _message.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _message) {
      msg.animationController.dispose();
    }
    super.dispose();
  }

  void getChat(){
    _client.history(ConfigKonsultasi.Channel, 100).then((items) {
      if (items != null && items.isNotEmpty) {
        for(var data in items){
          print("LAST ITEM TOKEN : $data");
          _konsultasi = new Konsultasi.fromJson(json.decode(data));

          Msg msg = new Msg(
            sender:_konsultasi.message.sender,
            txt: _konsultasi.message.message,
            animationController: new AnimationController(
                vsync: this, duration: new Duration(milliseconds: 800)),
          );
          json.decode(data);
          setState(() {
            _message.insert(0, msg);
          });
          msg.animationController.forward();
        }
      } else {
        print('No items');
      }
    });
  }
}

class Msg extends StatelessWidget {
  Msg({this.sender,this.txt, this.animationController});
  final String sender;
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    if(this.sender != defaultUserName){
      return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 18.0),
                child: new CircleAvatar(child: new Text(this.sender[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(this.sender,
                        style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: new Text(txt),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }else{
      return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(this.sender,
                        style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.left,),
                    new Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: new Text(txt,textAlign: TextAlign.left),
                    )
                  ],
                ),
              ),

              new Container(
                margin: const EdgeInsets.only(left:  18.0),
                child: new CircleAvatar(child: new Text(this.sender[0])),
              ),
            ],
          ),
        ),
      );
    }
  }
}
