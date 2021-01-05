import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spacikopooja/contactus/ContactDeatilsMain.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<Contact> contacts = [];
  List<CustomContact> _uiCustomContacts = List<CustomContact>();
  List<CustomContact> contactsFiltered = [];

  Map<String, Color> contactsColorMap = new Map();
  TextEditingController _controller = new TextEditingController();
  var isLongActive = false;
  List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];


  @override
  void initState() {
    getPermission();
    super.initState();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          print('CALLED:::::::');
          getPermission();
        }))
    );
  }


  Future<void> getPermission() async {
    if (await Permission.contacts.request().isGranted) {
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          getAllContacts();
        });
      });

      _controller.addListener(() {
        filterContacts();
      });
    }
  }


  void filterContacts() {
    List<CustomContact> _contacts = [];
    _contacts.addAll(_uiCustomContacts);

    if(_controller.text.isNotEmpty){
      _contacts.retainWhere((element){

        String searchTerm = _controller.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = element.contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);

        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }
      });
    }

    setState(() {
      contactsFiltered = _contacts;
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }


  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();

    int colorIndex = 0;
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];

      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;

      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });

    setState(() {
      contacts = _contacts;
      _uiCustomContacts = contacts.map((e) => CustomContact(contact: e)).toList();
    });
  }


  Future<void> refreshContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];

    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false, iOSLocalizedLabels: false)).toList();

    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];

      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });

    setState(() {
      contacts = _contacts;
      _uiCustomContacts = contacts.map((e) => CustomContact(contact: e)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isSearching = _controller.text.isNotEmpty;

    return  Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

      body: Container(
        height: MediaQuery.of(context).size.height,
        color: spacikoColor.ColorPrimary,

        child: Column(
          children: [

            SizedBox(height: 10),

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorwhite), iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text('Contact Us', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold'),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 45,

              child: TextField(
                controller: _controller,
                style: TextStyle(color: spacikoColor.Colorwhite),
                cursorColor: spacikoColor.Colorwhite,

                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: spacikoColor.Colorwhite),

                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: new BorderSide(
                        color: spacikoColor.Colorwhite,
                      )
                  ),

                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: spacikoColor.Colorwhite)),
                  prefixIcon: Icon(Icons.search, color: spacikoColor.Colorwhite),
                ),
              ),
            ),

            SizedBox(height: 15),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: spacikoColor.Colorwhite,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),

                child: Padding(padding: EdgeInsets.only(top: 10),

                  child:_uiCustomContacts.length!=0?

                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: isSearching == true ? contactsFiltered.length : _uiCustomContacts.length,


                      itemBuilder: (context, index){
                        CustomContact contact = isSearching == true ? contactsFiltered[index] : _uiCustomContacts[index];

                        var baseColor = contactsColorMap[contact.contact.displayName] as dynamic;
                        Color color1 = baseColor[800];
                        Color color2 = baseColor[400];

                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              isLongActive = true;
                              contact.isChecked = !contact.isChecked;
                            });
                          },


                          onTap: (){
                            setState(() {
                              if(isLongActive){
                                contact.isChecked = !contact.isChecked;

                              }else{
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    ContactDeatilsMain(contact.contact, onContactDeviceSave: contactOnDeviceHasBeenUpdated)));
                              }
                            });
                          },

                          child: ListTile(
                              title: Text(contact.contact.displayName),
                              subtitle: Text(contact.contact.phones.length > 0 ? contact.contact.phones.elementAt(0).value : ''),

                              leading: (contact.contact.avatar != null && contact.contact.avatar.length > 0) ?

                              CircleAvatar(
                                backgroundImage: MemoryImage(contact.contact.avatar),
                              ) :

                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          colors: [
                                            color1,
                                            color2,
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight
                                      )
                                  ),

                                  child: CircleAvatar(
                                      child: Text(
                                          contact.contact.initials(),
                                          style: TextStyle(color: Colors.white)
                                      ),
                                      backgroundColor: Colors.transparent
                                  )
                              ),

                            trailing: Checkbox(
                              activeColor: spacikoColor.ColorPrimary,
                              value: contact.isChecked,
                              onChanged: (bool value){
                                setState(() {
                                  contact.isChecked = value;
                                });
                              },
                            ),
                          ),
                        );
                      }
                  )
                      : Center(child: CircularProgressIndicator())),
              ),
              ),
          ],
        ),
      ),
    );
  }

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = contacts.indexWhere((c) => c.identifier == contact.identifier);
      contacts[id] = contact;
      _uiCustomContacts = contacts.map((e) => CustomContact(contact: e)).toList();

      int colorIndex = 0;
      _uiCustomContacts.forEach((contact) {
        Color baseColor = colors[colorIndex];

        contactsColorMap[contact.contact.displayName] = baseColor;
        colorIndex++;

        if (colorIndex == colors.length) {
          colorIndex = 0;
        }
      });
    });
  }
}


class CustomContact {
  final Contact contact;
  bool isChecked;

  CustomContact({
    this.contact,
    this.isChecked = false,
  });
}
