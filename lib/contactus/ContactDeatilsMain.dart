import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ContactDeatilsMain extends StatefulWidget {
  ContactDeatilsMain(this._contact, {this.onContactDeviceSave});

  final Contact _contact;
  final Function(Contact) onContactDeviceSave;

  @override
  _ContactDeatilsMainState createState() => _ContactDeatilsMainState();
}

class _ContactDeatilsMainState extends State<ContactDeatilsMain> {
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
                  child: Text(widget._contact.displayName, textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold'),
                  ),
                ),
                _paddingPopup(context,widget._contact, widget.onContactDeviceSave),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: spacikoColor.Colorlihgt_green,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),

                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        title: Text("Name"),
                        trailing: Text(widget._contact.givenName ?? ""),
                      ),

                      ListTile(
                        title: Text("Family name"),
                        trailing: Text(widget._contact.familyName ?? ""),
                      ),

                      ListTile(
                        title: Text("Suffix"),
                        trailing: Text(widget._contact.suffix ?? ""),
                      ),

                      ListTile(
                        title: Text("Birthday"),
                        trailing: Text(widget._contact.birthday != null
                            ? DateFormat('dd-MM-yyyy').format(widget._contact.birthday)
                            : ""),
                      ),
                      ListTile(
                        title: Text("Company"),
                        trailing: Text(widget._contact.company ?? ""),
                      ),
                      ListTile(
                        title: Text("Job"),
                        trailing: Text(widget._contact.jobTitle ?? ""),
                      ),

                      ItemsTile("Phones", widget._contact.phones),
                      ItemsTile("Emails", widget._contact.emails)
                    ],
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


Widget _paddingPopup(BuildContext context, Contact contact, Function(Contact p1) onContactDeviceSave) => PopupMenuButton<int>(
  icon: Icon(Icons.more_vert, color: spacikoColor.Colorwhite),
  itemBuilder: (context) => [
    PopupMenuItem(
      value: 1,
      child: Row(
        children: [
          Icon(Icons.edit, size: 18,),
          SizedBox(width: 10),
          Text("Edit", style: TextStyle(color: spacikoColor.Colorblack)),
        ]
      ),
    ),
    PopupMenuItem(
      value: 2,
        child: Row(
            children: [
              Icon(Icons.delete, size: 18),
              SizedBox(width: 10),
              Text("Delete", style: TextStyle(color: spacikoColor.Colorblack)),
            ]
        ),
    ),
  ],

  elevation: 5,

  onSelected:(value){
    switch (value){
      case 1:
        _openExistingContactOnDevice(context, contact, onContactDeviceSave);
        break;

      case 2:
        show_dialog(context, contact);
        break;
    }
  },
);

void show_dialog(BuildContext context, Contact contact) {
  Widget cancelbutton = FlatButton(
    child: Text('No'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );

  Widget okaybutton = FlatButton(
    child: Text("Yes"),

    onPressed: () {
      ContactsService.deleteContact(contact);

      Navigator.of(context, rootNavigator: true).pop('dialog');
      Future.delayed(Duration(milliseconds: 200), () {
        Navigator.of(context).pop();
        Utility.showToast("Contact Delete successfully!");
      });
    },
  );


  AlertDialog alertDialog = AlertDialog(
    content: Text(
      "Are you sure you want to Delete this Contact ?",
      style: TextStyle(
          fontFamily: 'poppins_regular',
          fontSize: 14,
          color: spacikoColor.Colorblack),
    ),
    actions: [cancelbutton, okaybutton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}

_openExistingContactOnDevice(BuildContext context, Contact _contact, Function onContactDeviceSave) async {
  try {
    var contact = await ContactsService.openExistingContact(_contact, iOSLocalizedLabels: false);
    if (onContactDeviceSave != null) {
      onContactDeviceSave(contact);
    }
    Navigator.of(context).pop();

  } on FormOperationException catch (e) {
    print('catch::::${e.toString()}');
    switch (e.errorCode) {
      case FormOperationErrorCode.FORM_OPERATION_CANCELED:
      case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
      case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
      default:
        print(e.toString());
    }
  }
}


class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);

  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: _items.map((i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: ListTile(
                title: Text(i.label ?? ""),
                trailing: Text(i.value ?? ""),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }
}

