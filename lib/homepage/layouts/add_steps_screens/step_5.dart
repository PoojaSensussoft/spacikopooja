import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:google_maps_webservice/places.dart';


class FifthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  FifthStep(this.currentpage,{this.onChangeFunction});

  @override
  _FifthStepState createState() => _FifthStepState();
}


class _FifthStepState extends State<FifthStep> {
  /*google map*/
  Set<Marker> _markers = {};
  LatLng _lng;
  Position _currentPosition;
  CameraPosition cameraPosition;
  Completer _controller = Completer();
  BitmapDescriptor pinLocationIcon;

  TextEditingController address = new TextEditingController();
  TextEditingController comment = new TextEditingController();

  /*google map places*/
  static const kGoogleApiKey = "AIzaSyA_Sso_0edwfC1dde6Xnx_JkTgjM2sDh7s";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];


  @override
  void initState() {
    super.initState();

    /*google map*/
    setCustomMapPin();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {

      setState(() {
        _currentPosition = position;
        print('LatLong 111::::$_currentPosition');
        _lng = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'image/ic_marker.png');
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(

        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text('Please provide the full physical address\nof your venued',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
            alignment: Alignment.center,
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text('My Listing Address',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
            alignment: Alignment.centerLeft,
          ),

          setCardciew(),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Text('Comment',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
            alignment: Alignment.centerLeft,
          ),

         Padding(
           padding: EdgeInsets.only(left: 20, right: 20, top: 10),
           child: Material(
             elevation: 2,
             borderRadius: BorderRadius.circular(15),

             child: Container(
               padding: EdgeInsets.only(left: 15, right: 15),
               height: 120,

               child: TextFormField(
                 controller: comment,
                 maxLines: null,
                 cursorColor: spacikoColor.ColorPrimary,
                 keyboardType: TextInputType.text,

                 decoration: InputDecoration(
                   hintStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
                   border: InputBorder.none,
                   focusedBorder: InputBorder.none,
                   enabledBorder: InputBorder.none,
                   labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                 ),

               ),
             ),
           ),
         ),


            Padding(
              padding: EdgeInsets.only(left: 22, right: 22, top: 15),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: spacikoColor.Colorwhite,

                child: _lng != null
                    ? GoogleMap(
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(target: _lng, zoom: 8),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _markers.add(Marker(markerId: MarkerId('SomeId'), position: _lng,
                            infoWindow: InfoWindow(
                                title: 'current location'
                            )
                        )
                    );
                  },

                ) : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),


          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                setState(() {
                  if(address.text.isEmpty){
                    Utility.showToast("Enter Address");

                  }else if(comment.text.isEmpty){
                    Utility.showToast("Enter Comment");

                  }else{
                    widget.onChangeFunction(widget.currentpage);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget setCardciew(){
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(30),

        child: Container(
          padding: EdgeInsets.only(left: 20, ),
          alignment: Alignment.center,
          height: 50,

          child: TextFormField(
            controller: address,
            cursorColor: spacikoColor.ColorPrimary,
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              hintText: 'Surat, Gujarat, India',
              hintStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

              suffixIcon: IconButton(
                onPressed: () async {
                  Prediction p = await PlacesAutocomplete.show(
                      context: context, apiKey: kGoogleApiKey,
                      mode: Mode.overlay, language: "en",
                      components: [new Component(Component.country, "en")]);
                  displayPrediction(p);
                },

                icon: Image(image: AssetImage('image/ic_pink_send.png'), height: 18, width: 18, alignment: Alignment.center,),
              ),
            ),

          ),
        ),
      ),
    );
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print('address:::$address');
      print('LAT:::$lat');
      print('LANG:::$lng');
    }
  }
}
