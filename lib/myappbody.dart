import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'add.dart';
import 'package:http/http.dart' as http;
//-----------------------------------------------------------------------------

Future exportDB() async {
  //final response = await http.put(Uri.parse('https://storage.yandexcloud.net/gudflutter/Contacts.json'), body: jsonEncode(Contacts));
  final response = await http.put(Uri.parse('http://localhost:8080/'), body: jsonEncode(Contacts));
}
//-----------------------------------------------------------------------------


class MyAppBody extends StatefulWidget{
  const MyAppBody({super.key});

  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}


class _MyAppBodyState extends State<MyAppBody>{
  Timer? timer;

  Future<void> loadDataFromJsonFile() async{
    //final response = await http.get(Uri.parse('https://storage.yandexcloud.net/gudflutter/Contacts.json'));
    final response = await http.get(Uri.parse('http://localhost:8080/'));
    final jsonFile = utf8.decode(response.body.runes.toList());
    final jsonMap = await jsonDecode(jsonFile);
    setState(() {
      Contacts.clear();
      int i = 0;
      for (var c in jsonMap){
        Contact contact = Contact(c['username'], c['initials'], c['imgPath'], c['phoneNum']);
        if(Contacts.length < i + 1)
          Contacts.insert(i, contact);
        else
          Contacts[i] = contact;
        i+=1;
      }
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => loadDataFromJsonFile());
    super.initState();
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    'Контакты (${Contacts.length})',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Image(
                            image: AssetImage('assets/Images/filter.png'),
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/Images/search.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Contacts.length,
                itemBuilder: (context, index){
                  return Card(
                    shadowColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                    ),
                    key: ValueKey(Contacts[index]),
                    child: Container(
                      height: 84,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFF3F3F3),
                            foregroundImage: Contacts[index].imgPath == null ? null : AssetImage(Contacts[index].imgPath.toString()),
                            child: Stack(
                              children: [
                                Text(
                                  Contacts[index].imgPath == null ? Contacts[index].initials.toString() : "",
                                  style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width - 96,
                                  child: Text(
                                    Contacts[index].username == null ? "": Contacts[index].username.toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Color(0xFF0C0C0C),
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(
                                    Contacts[index].phoneNum == null ? "": Contacts[index].phoneNum.toString(),
                                    style: TextStyle(
                                      color: Color(0xFF7C7C7C),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2, color: Color(0xFFF3F3F3))
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
