import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailCard extends StatefulWidget {
  final List<OcrText> OcrTextt;
  const DetailCard({Key? key,required this.OcrTextt}) : super(key: key);

  @override
  State<DetailCard> createState() => _DetailCardState(this.OcrTextt);
}

class _DetailCardState extends State<DetailCard> {
  List OcrTextt;
  String name = "";
  String Email = "";
  String WebAddress = "";
  String Number = "";

  _DetailCardState(this.OcrTextt);
  @override
  void initState()  {


  for(OcrText text in OcrTextt) {
    print("all ${text.value}");


    if (isValidPhoneNumber(text.value.toString())) {
      print("number ${text.value}");

        Number = text.value.toString();



    }
     if (validateEmail(text.value.toString())) {
      print("email ${text.value}");

        Email = text.value.toString();

    }
       if (Uri
        .tryParse(text.value.toString())
        ?.hasAbsolutePath ?? true) {
      print("Address${text.value}");

        WebAddress = text.value.toString();

    }
  }

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Card Detail"),),
      body: Center(
        child: Column(

          children: [
            buildRow("Name: ",name.toString()),
            buildRow("Email ", Email.toString()),
            buildRow("Contact Number ", Number.toString()),
            buildRow("Webside",WebAddress.toString()),

          ],
        ),
      )
    ));
  }
 FutureBuilder _Buildwidget(BuildContext context) {

    return FutureBuilder(
        //future: GetTextData(),
        builder: (context,snapchat) {
      if(snapchat.data == true){

     return Center(
       child: Column(

         children: [
           buildRow("Name: ",name.toString()),
           buildRow("Email ", Email.toString()),
           buildRow("Contact Number ", Number.toString()),
           buildRow("Webside",WebAddress.toString()),

         ],
       ),
     );
   }

      else{
        return Container();
      }
    });

}
// Future<bool> GetTextData() async{
//   for(OcrText text in OcrTextt){
//
//     print("bala${text.value}");
//     if(isValidPhoneNumber(text.value)){
//       print("names ${text.value}");
//
//         Number = text.value.toString();
//
//
//     }
//    else  if(validateEmail(text.value)){
//       print("email ${text.value}");
//
//         Email = text.value.toString();
//
//
//     }
//     // else  if( Uri.tryParse(text.value)?.hasAbsolutePath ?? true){
//     //   print("Address${text.value}");
//     //
//     //     WebAddress = text.value.toString();
//     //
//     // }
//
//   }
//
//     return true;
// }

  Row buildRow(String title,  String value) {
    print(value.toString());
    return Row(
      children: [Text(title), Text(value)],
    );
  }
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }
  bool checkIfUrlIsValid({required String url})   {

      return  RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
          .hasMatch(url);



  }

  bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');
}

