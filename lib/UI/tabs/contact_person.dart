import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/widgets/district_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/province_dropdown.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/contact_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/event/contact_event_args.dart';
import 'package:kurikulumsmk/model/contact.dart';
import 'package:kurikulumsmk/UI/tiles/contact_list_tile.dart';
import 'package:kurikulumsmk/utils/constants.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class ContactScreen extends StatefulWidget {
  @override
  ContactScreenState createState() {
    return new ContactScreenState();
  }
}

class ContactScreenState extends State<ContactScreen> {
  final contactBloc = kiwi.Container().resolve<ContactBloc>();
  final commonBloc = kiwi.Container().resolve<CommonBloc>();

  @override
  void initState() {
    super.initState();
    contactBloc.reset();
    commonBloc.reset();
  }

  @override
  Widget build(BuildContext context) {

    if (contactBloc.contactsData.length == 0) {
      contactBloc.loadContacts.add(ContactEventArgs(1, 20));
    }

    if (commonBloc.provincesData.length == 0) {
      commonBloc.loadProvinces.add(null);
      commonBloc.selectedProvince = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: FlatButton(
            onPressed: () {
              contactBloc.showFilter.add(!contactBloc.filterVisible);
            },
            color: Colors.blue,
            padding: EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: IconTheme(
                  data: IconThemeData(
                      color: Colors.white), 
                  child: Text('Filter', style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          ),
        ),
        StreamBuilder(
          stream: contactBloc.filterSelected,
          builder: (context, snapshot) {
            if (commonBloc.provincesData.length == 0 && contactBloc.filterVisible) {
              commonBloc.loadProvinces.add(null);
              commonBloc.selectedProvince = null;
            }

            return Visibility(
              child: Expanded(flex: 3, child: ListView(children: <Widget>[ ContactFilter(commonBloc, contactBloc) ])),
              visible: contactBloc.filterVisible,
            );
          }
        ),
        Divider(),
        Expanded(
          flex: 6,
          child: StreamBuilder(
            stream: contactBloc.contacts,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (snapshot.hasError)
                return PlaceHolderContent(
                  title: "Problem Occurred",
                  message: "Cannot connect to internet please try again",
                  tryAgainButton: (e) { contactBloc.loadContacts.add(ContactEventArgs(1, 20)); },
                );

              contactBloc.loadMoreStatus = LoadMoreStatus.STABLE;
              Contacts result = snapshot.data as Contacts;
              contactBloc.contactsData.addAll(result.contacts);
              return ContactTile(contacts: contactBloc.contactsData,
                                 currentPage: result.paging.page,
                                 totalPage: result.paging.total,
                                 contactBloc: contactBloc,
                                 commonBloc: commonBloc);
            },
          ),
        )
      ],
    );
  }
}

class ContactTile extends StatelessWidget {
  final List<Contact> contacts;
  final ContactBloc contactBloc;
  final int currentPage;
  final int totalPage;
  final CommonBloc commonBloc;

  ContactTile({Key key, this.contacts, this.contactBloc, this.commonBloc, this.currentPage, this.totalPage}) : super(key: key);

  final ScrollController scrollController = new ScrollController();

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
        if (contactBloc.loadMoreStatus != null &&
            contactBloc.loadMoreStatus == LoadMoreStatus.STABLE &&
            currentPage + 1 <= totalPage) {
          contactBloc.loadMoreStatus = LoadMoreStatus.LOADING;
          contactBloc.loadContacts.add(ContactEventArgs(currentPage + 1, 20, 
                  provinceId: commonBloc.selectedProvince == null ? 0 : commonBloc.selectedProvince.id,
                  districtId: commonBloc.selectedDistrict == null ? 0 : commonBloc.selectedDistrict.id));
        }
      }
    }
    return true;
  }
}

// high level Function
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';

class ContactFilter extends StatelessWidget {
  final ContactBloc contactBloc;
  final CommonBloc commonBloc;

  ContactFilter([this.commonBloc, this.contactBloc]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Province Dropdown
            ProvinceDropdown(commonBloc),
            // District Dropdown
            DistrictDropdown(commonBloc),
            // School type
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      contactBloc.resetContactData();
                      contactBloc.loadContacts.add(ContactEventArgs(1, 20, 
                                provinceId: commonBloc.selectedProvince == null ? 0 : commonBloc.selectedProvince.id,
                                districtId: commonBloc.selectedDistrict == null ? 0 : commonBloc.selectedDistrict.id));
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        IconTheme(
                            data: IconThemeData(
                                color: Colors.white), 
                            child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}