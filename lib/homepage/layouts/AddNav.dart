import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_2.dart';
import 'package:spacikopooja/model/CustomStep.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'add_steps_screens/step_1.dart';


class AddSpaces extends StatefulWidget {
  @override
  _AddSpacesState createState() => _AddSpacesState();
}

class _AddSpacesState extends State<AddSpaces> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AddNav(),
      ),
    );
  }
}

class AddNav extends StatefulWidget {
  @override
  _AddNavState createState() => _AddNavState();
}

class _AddNavState extends State<AddNav> {
  /*pooja*/
  ScrollController _scrollController = new ScrollController();
  static const double STEP_WIDTH = 32;
  PageController pageController = PageController();
  List<CustomStep> stepsList;
  int currentPage = 0;


  bool onWillPop() {
    if (pageController.page.round() == pageController.initialPage)
      return true;

    pageController.previousPage(
        duration: Duration(milliseconds: 30), curve: Curves.ease);
    pageController?.jumpToPage(pageController.initialPage);
    return false;
  }

  Future<bool> _onBackPressed() {
    print('ONBACKKK:::::$currentPage');
    return pageController.previousPage(
        duration: Duration(milliseconds: 30), curve: Curves.ease);
  }


  @override
  void initState() {
    super.initState();

    stepsList = [
      // CustomStep(
      // page: FirstStep(current = 1, onChangeFunction: (val) => currentPage = val)
      // ),

      // CustomStep(
      //     page: SecondStep(2, onChangeFunction: (val) => setState(() => currentPage = val),)
      // ),

      CustomStep(
          page: Container(
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              onPressed: () {
                setState(() {
                  pageController.nextPage(curve: Curves.easeInOutSine,
                      duration: Duration(milliseconds: 300));
                });
              },
              child: Text('Next 3',
                  style:
                  TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
            ),
          )),


      CustomStep(
          page: Container(
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              onPressed: () {
                setState(() {
                  pageController.nextPage(curve: Curves.easeInOutSine,
                      duration: Duration(milliseconds: 300));
                });
              },
              child: Text('Next 4',
                  style:
                  TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
            ),
          )),


      CustomStep(
          page: Container(
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              onPressed: () {
                setState(() {
                  pageController.nextPage(curve: Curves.easeInOutSine,
                      duration: Duration(milliseconds: 300));
                });
              },
              child: Text('Next 5',
                  style:
                  TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
            ),
          )
      ),


      CustomStep(
          page: Container(
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              onPressed: () {
                setState(() {
                  pageController.nextPage(curve: Curves.easeInOutSine,
                      duration: Duration(milliseconds: 300));
                });
              },
              child: Text('Next 6',
                  style:
                  TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
            ),
          )),
    ];
  }



  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  SizedBox buildStepDivider(int index) {
    return SizedBox(
      child: Container(width: 35, height: 2, color: spacikoColor.ColorPrimary,
      ),
    );
  }

  _buildStepper(int currentStep) {
    return Center(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: stepsList.length,
            itemBuilder: (ctx, index) =>
            index < stepsList.length - 1
                ? Row(children: <Widget>[
              buildStep(index),
              buildStepDivider(index)])
                : Row(children: <Widget>[buildStep(index)]
            )
        ),
      ),
    );
  }

  buildStep(int index) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: STEP_WIDTH,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentPage
                  ? spacikoColor.ColorPrimary
                  : spacikoColor.ColorOpacity,
            ),
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),

          // Expanded(
          //     child: Text(
          //   stepsList[index].title,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(color: Colors.black),
          // )
          // )
        ],
      ),
    );
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: spacikoColor.ColorPrimary,

          child: Expanded(

            /*white rouned bg*/
            child: Container(
              margin: EdgeInsets.only(top: 90),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: spacikoColor.Colorwhite),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildStepper(currentPage),

                  Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        physics: NeverScrollableScrollPhysics(),

                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemCount: stepsList.length,
                        itemBuilder: (ctx, index) => stepsList[index].page,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
