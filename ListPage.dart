import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Alarm{
  int id;
  String status;
  String title;
  Alarm({this.id, this.title, this.status,});
}

//=================リスト=====================
var listPageKey = GlobalKey<_ListPageState>();

class ListPage extends StatefulWidget{
  const ListPage({Key key}): super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>{
  bool _validate = false;

  //追加されるアラームはここに格納
  List<Alarm> alarms = [];

  //後で使うアラーム追加しますよマシーン
  final TextEditingController addAlm = TextEditingController();

  //ホームとリストのアクセス
  @override
  void initState(){
    super.initState();
  }

  //リストと追加マシーンとのアクセス
  //@override
  //void dissose(){
    //addAlm.dispose();
    //super.dispose();
  //}

  //追加マシーンの作成
  void addListItem(String text){
    _validate = false;
    final Alarm newItem = Alarm(
      title: text,
      status: 'false',
    );
    //0番目にアラームをあらかじめ追加
    alarms.insert(0,newItem);
    //追加マシーンの内容を消す
    addAlm.clear();
    //setStateでWidgetの内容更新
    setState(() {});
  }
//リスト更新マシーンの作成
  void upDatelist(Alarm alarm, int i){
    if(alarm.status == 'false'){
      final updateAlarm = Alarm(
          title: alarm.title,
          status: 'true'
      );
      alarms[i] = updateAlarm;
    }
    else if(alarm.status == 'true'){
      final updateAlarm = Alarm(
          title: alarm.title,
          status: 'false'
      );
      alarms[i] = updateAlarm;
    }
    setState(() {});
  }

  //アラームの削除
  void removeAlarm(Alarm alarm) async{
    setState(() => alarms.remove(alarm));
  }

  //リストの大枠
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('alarms'),
          centerTitle: true,
          actions: [],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                buildInputContainer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (BuildContext context,i){
                      return buildListItem(alarms,i);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Dismissible buildListItem(List<Alarm> alarms, int i){
    return Dismissible(
      key: ObjectKey(alarms[i]),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: Column(
          children: [
            ListTile(
              title: Text(
                alarms[i].title,
                style: TextStyle(
                    color: alarms[i].status == 'false'
                        ? Colors.black
                        : Colors.grey,
                    decoration: alarms[i].status == 'false'
                        ? TextDecoration.none
                        : TextDecoration.lineThrough
                ),

              ),
              leading: Icon(Icons.list),
              trailing: IconButton(
                icon: Icon(
                  alarms[i].status == 'false'
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: Colors.greenAccent,
                ),
                onPressed: (){
                  upDatelist(alarms[i], i);
                },
              ),

            ),
            Divider(height: 0)
          ],
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: (){
              removeAlarm(alarms[i]);
            },
          )
        ],
      ),
    );
  }
  Padding buildInputContainer(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0))
              ),
              child: TextField(
                controller: addAlm,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Empty your alarm!",
                  errorText: _validate
                      ?'the input is Empty'
                      :null,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onTap: () => setState(() => _validate = false),
                onSubmitted: (text){
                  if(text.isEmpty){
                    setState(() {
                      _validate = true;
                    });
                  }else{
                    addListItem(text);
                  }
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.1,
            child: RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white,),
              ),
              onPressed: (){
                if(addAlm.text.isEmpty){
                  setState(() => _validate = true);
                } else{
                  addListItem(addAlm.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
