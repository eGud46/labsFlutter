import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'myappbody.dart';
import 'dart:io';
import 'dart:convert';

List<Contact> Contacts = [];
class Add extends StatefulWidget{
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add>{

  //Contact newContact = Contact('NewConTact','NC',null,'12345');


  String? _UserName;
  String? _UserPhone;
  String _UserInitials = '';

  @override
  Widget build(BuildContext context){
    return Material(
      child: Column(
        children: [
          Text(''),
          Text(''),
          Text('Имя:'),
          TextField(
            onChanged: (String value) {
              _UserName = value;
            },
            decoration: InputDecoration(
              hintText: 'Введите имя',
            ),
          ),
          Text(''),
          Text(''),
          Text('Номер телефона'),
          TextField(
            onChanged: (String value) {
              _UserPhone = value;
            },
            decoration: InputDecoration(
              hintText: 'Введите номер телефона',
            ),
          ),
          ElevatedButton(onPressed: () {
            _UserInitials = '';
            RegExp exp = RegExp(r'(^.| .{1})');
            Iterable<RegExpMatch> matches = exp.allMatches(_UserName.toString());
            int i = 0;
            for (final m in matches) {
              if (i != 2)
                _UserInitials += m[0]!;
              i += 1;
            }
            Contact newContact = Contact(_UserName, _UserInitials.replaceAll(' ', '').toUpperCase(), null, _UserPhone);
            //Contact newContact = Contact("Замдир по информационной безопасности - Хамид-оглы...", "ИП", "assets/Images/contact4.png", "8920250710");
            if(!jsonEncode(Contacts).contains(jsonEncode(newContact)))
              Contacts.add(newContact);
            Contacts.map((Contact) => Contact.toJson()).toList();
            exportDB();
            Navigator.pushNamed(context, '/');
          },
            child: Text('Добавить'),
          ),
          Text(''),
          ElevatedButton(onPressed: (){
            Contacts.remove(Contacts.last);
            Contacts.map((Contact) => Contact.toJson()).toList();
            exportDB();
            Navigator.pushNamed(context, '/');
          }, child: Text('Удалить последний'))
        ],
      ),
      color: Colors.white,
    );
  }
}

class Contact {
  late String? username;
  late String? initials;
  late String? imgPath;
  late String? phoneNum;

  Contact(
      this.username,
      this.initials,
      this.imgPath,
      this.phoneNum,
      );

  Contact.fromJson(Map<String, dynamic> json){
    username = json['username'];
    initials = json['initials'];
    imgPath = json['imgPath'];
    phoneNum = json['phoneNum'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['initials'] = initials;
    data['imgPath'] = imgPath;
    data['phoneNum'] = phoneNum;

    return data;
  }
}

