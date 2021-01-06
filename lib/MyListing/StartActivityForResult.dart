import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class StartActivityForResult extends StatelessWidget {
  List<String>list = ['hello','hello1','hello2','hello3'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: spacikoColor.ColorPrimary,



        child: Column(
          children: [
            SizedBox(height: 20),

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Text("List of Data", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold')),
                ),

                SizedBox(width: 15)
              ],
            ),

            SizedBox(height: 15),
            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: spacikoColor.Colorwhite,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                ),

                child: new ListView.builder(itemBuilder: (context, i){
                  return ListTile(title: new Text(list[i]),
                    onTap: (){
                      Navigator.of(context).pop({'item': list[i]});
                    },
                  );
                }, itemCount: list.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
