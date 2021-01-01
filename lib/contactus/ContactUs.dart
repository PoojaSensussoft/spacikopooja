import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];

  Map<String, Color> contactsColorMap = new Map();
  TextEditingController _controller = new TextEditingController();


  @override
  void initState() {
    super.initState();
    getPermission();
  }


  Future<void> getPermission() async {
    if (await Permission.contacts.request().isGranted) {
      Future.delayed(Duration(milliseconds: 100), () {
        getAllContacts();
      });

      _controller.addListener(() {
        filterContacts();
      });
    }
  }


  void filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);

    if(_controller.text.isNotEmpty){
      _contacts.retainWhere((element){

      String searchTerm = _controller.text.toLowerCase();
      String searchTermFlatten = flattenPhoneNumber(searchTerm);
      String contactName = element.displayName.toLowerCase();
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
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];

    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();

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

                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                        itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                      itemBuilder: (context, index){
                        
                        Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];

                        var baseColor = contactsColorMap[contact.displayName] as dynamic;
                        Color color1 = baseColor[800];
                        Color color2 = baseColor[400];

                        return ListTile(
                            title: Text(contact.displayName),
                            subtitle: Text(contact.phones.length > 0 ? contact.phones.elementAt(0).value : ''),

                            leading: (contact.avatar != null && contact.avatar.length > 0) ?

                            CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar),
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
                                        contact.initials(),
                                        style: TextStyle(
                                            color: Colors.white
                                        )
                                    ),
                                    backgroundColor: Colors.transparent
                                )
                            )
                        );
                      }
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

}






