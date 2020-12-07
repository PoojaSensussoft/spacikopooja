import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class CustomBottomNav extends StatefulWidget {
  int defaultSelectedIndex;
  Function(int) onChange;

  CustomBottomNav({this.defaultSelectedIndex, @required this.onChange});

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.defaultSelectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: spacikoColor.Colorwhite,
        height: 55,
        child: Row(
          children: [
            NavBarItem(AssetImage('image/ic_campas.png'),AssetImage('image/ic_campas_themecolor.png'),0,true,30),
            NavBarItem(AssetImage('image/ic_calender.png'),AssetImage('image/ic_calender_green.png'),1,false,30),
            NavBarItem(AssetImage('image/ic_add.png'),AssetImage('image/ic_add.png'),2,false,45),
            NavBarItem(AssetImage('image/ic_comment.png'),AssetImage('image/ic_comment_themecolor.png'),3,false,30),
            NavBarItem(AssetImage('image/ic_user.png'),AssetImage('image/ic_user_themecolor.png'),4,false,30),
          ],
        ),
      ),
    );
  }

  Widget NavBarItem(AssetImage deActive,AssetImage activeAssetImage,int index,bool isActive,double height){
    return GestureDetector(
      onTap: (){
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: height,
            width: MediaQuery.of(context).size.width/5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: index == _selectedIndex ? activeAssetImage : deActive
                )
            ),
          ),
        ],
      ),
    );


  }
}
