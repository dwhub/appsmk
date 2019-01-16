import 'package:flutter/material.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/model/contact.dart';
import 'package:kurikulumsmk/model/district.dart';
import 'package:kurikulumsmk/model/province.dart';
import 'package:kurikulumsmk/repository/contact_repository.dart';
import 'package:kurikulumsmk/UI/tiles/contact_list_tile.dart';
import 'package:kurikulumsmk/repository/province_repository.dart';
import 'package:kurikulumsmk/utils/constants.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactState();
}

class _ContactState extends State<ContactScreen> {
  List<Contact> contact = Contact().getDummyData();

  Province selectedProvinsi;
  List<Province> provinsi = <Province>[const Province(id: 1, name: "Jawa Tengah"), const Province(id: 2, name: "D.I.Y")];

  District selectedKabupaten;
  List<District> kabupaten = <District>[const District(id: 1, name: "Sleman"), const District(id: 2, name: "Bantul")];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: new FutureBuilder<List<Province>>(
            future: ProvinceRepository().fetchProvinces(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 15.0,
                      width: 15.0,
                    ),
                  ),
                );

              return
                new DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<Province>(
                      value: selectedProvinsi,
                      hint: Text("Provinsi"),
                      items: snapshot.data.map((Province provinsi) {
                          return DropdownMenuItem<Province>(
                            value: provinsi,
                            child: Text(
                              provinsi.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      onChanged: (Province newValue) {
                        setState(() {
                          selectedProvinsi = newValue;
                        });
                      },
                    ),
                  ),
                );
            },
          ),
          /*DropdownButton<Province>(
            value: selectedProvinsi,
            hint: Text("Provinsi"),
            onChanged: (Province newValue) {
              setState(() {
                selectedProvinsi = newValue;
              });
            },
            items: provinsi.map((Province provinsi) {
              return DropdownMenuItem<Province>(
                value: provinsi,
                child: Text(
                  provinsi.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),*/
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: DropdownButton<District>(
            value: selectedKabupaten,
            hint: Text("Kabupaten"),
            onChanged: (District newValue) {
              setState(() {
                selectedKabupaten = newValue;
              });
            },
            items: kabupaten.map((District kabupaten) {
              return DropdownMenuItem<District>(
                value: kabupaten,
                child: Text(
                  kabupaten.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: FutureBuilder<Contacts>(
            future: ContactRepository().fetchContacts(1, 20),
            builder: (context, snapshots) {
              if (snapshots.hasError)
                return PlaceHolderContent(
                  title: "Problem Occurred",
                  message: "Cannot connect to internet please try again",
                  tryAgainButton: _tryAgainButtonClick,
                );
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return ContactTile(contacts: snapshots.data);
                default:
              }
            })
        )
      ],
    );
  }

  _tryAgainButtonClick(bool _) => setState(() {});
}

class ContactTile extends StatefulWidget {
  final Contacts contacts;

  ContactTile({Key key, this.contacts}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ContactTileState();
}

class ContactTileState extends State<ContactTile> {
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.STABLE;
  final ScrollController scrollController = new ScrollController();

  List<Contact> contacts;
  int currentPageNumber;

  @override
  void initState() {
    contacts = widget.contacts.contacts;
    currentPageNumber = widget.contacts.paging.page;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: onNotification,
        child: new ListView.builder(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            controller: scrollController,
            itemCount: contacts.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return ContactListTile(contact: contacts[index]);
            }));
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == LoadMoreStatus.STABLE) {
          loadMoreStatus = LoadMoreStatus.LOADING;
          ContactRepository()
              .fetchContacts(currentPageNumber + 1, 20)
              .then((contactsObject) {
            currentPageNumber = contactsObject.paging.page;
            loadMoreStatus = LoadMoreStatus.STABLE;
            setState(() => contacts.addAll(contactsObject.contacts));
          });
        }
      }
    }
    return true;
  }
}

// high level Function
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';