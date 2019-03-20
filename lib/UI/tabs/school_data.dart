import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/widgets/district_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/excompetency_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/exfield_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/exprogram_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/province_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/school_tile.dart';
import 'package:kurikulumsmk/UI/widgets/sub_district_dropdown.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/bloc/school_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/event/school_event_args.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/utils/constants.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class DataSekolahScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataSekolahState();
}

class _DataSekolahState extends State<DataSekolahScreen> {
  final schoolBloc = kiwi.Container().resolve<SchoolBloc>();
  final commonBloc = kiwi.Container().resolve<CommonBloc>();
  final expertiseBloc = kiwi.Container().resolve<ExpertiseBloc>();

  @override
  void initState() {
    super.initState();
    schoolBloc.reset();
    commonBloc.reset();
    expertiseBloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (schoolBloc.schoolsData.length == 0) {
      schoolBloc.loadSchools.add(SchoolEventArgs(1, 20));
    }

    int flexFilter = 11;
    int flexContent = 5;

    if (MediaQuery.of(context).size.height <= 568) {
      flexFilter = 32;
      flexContent = 2;
    } else if (MediaQuery.of(context).size.height > 568 && MediaQuery.of(context).size.height <= 736) {
      flexFilter = 16;
      flexContent = 5;
    } else if (MediaQuery.of(context).size.height > 736 && MediaQuery.of(context).size.height < 1024) {
      flexFilter = 5;
      flexContent = 4;
    } else if (MediaQuery.of(context).size.height >= 1024 && MediaQuery.of(context).size.height < 1112) {
      flexFilter = 6;
      flexContent = 7;
    } else if (MediaQuery.of(context).size.height >= 1112 && MediaQuery.of(context).size.height < 1190) {
      flexFilter = 6;
      flexContent = 8;
    } else if (MediaQuery.of(context).size.height >= 1190 && MediaQuery.of(context).size.height < 1366) {
      flexFilter = 7;
      flexContent = 11;
    } else if (MediaQuery.of(context).size.height >= 1366) {
      flexFilter = 7;
      flexContent = 14;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Data Sekolah"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlatButton(
                onPressed: () {
                  schoolBloc.showFilter.add(!schoolBloc.filterVisible);
                },
                color: Color.fromRGBO(220, 53, 69, 1.0),
                padding: EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconTheme(
                      data: IconThemeData(
                          color: Colors.white), 
                      child: Text('Pencarian', style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              ),
            ),
            StreamBuilder(
              stream: schoolBloc.filterSelected,
              builder: (context, snapshot) {
                if (commonBloc.provincesData.length == 0 && schoolBloc.filterVisible) {
                  commonBloc.loadProvinces.add(null);
                  commonBloc.selectedProvince = null;
                }

                if (expertiseBloc.exFieldsData.length == 0 && schoolBloc.filterVisible) {
                  expertiseBloc.loadExFields.add(null);
                  expertiseBloc.selectedExField = null;
                }

                return Visibility(
                  child: Expanded(flex: flexFilter, child: ListView(children: <Widget>[ SchoolFilter(commonBloc, expertiseBloc, schoolBloc) ])),
                  visible: schoolBloc.filterVisible,
                );
              }
            ),
            Divider(),
            Expanded(
              flex: flexContent,
              child: StreamBuilder(
                stream: schoolBloc.schools,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasError)
                    return PlaceHolderContent(
                      title: "Problem Occurred",
                      message: "Cannot connect to internet please try again",
                      tryAgainButton: (e) { schoolBloc.loadSchools.add(SchoolEventArgs(1, 20)); },
                    );

                  schoolBloc.loadMoreStatus = LoadMoreStatus.STABLE;
                  Schools result = snapshot.data as Schools;
                  schoolBloc.schoolsData.addAll(result.schools);
                  return SchoolTile(schools: schoolBloc.schoolsData,
                                     currentPage: result.paging.page,
                                     totalPage: result.paging.total,
                                     commonBloc: commonBloc,
                                     schoolBloc: schoolBloc,
                                     expertiseBloc: expertiseBloc);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// high level Function
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';

class SchoolFilter extends StatelessWidget {
  final SchoolBloc schoolBloc;
  final CommonBloc commonBloc;
  final ExpertiseBloc expertiseBloc;

  SchoolFilter([this.commonBloc, this.expertiseBloc, this.schoolBloc]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Province Dropdown
            ProvinceDropdown(commonBloc),
            // District Dropdown
            DistrictDropdown(commonBloc),
            // SubDistrict Dropdown
            SubDistrictDropdown(commonBloc),
            // Expertise Fields Dropdown
            ExpertiseFieldDropdown(expertiseBloc),
            // Expertise Programs Dropdown
            ExpertiseProgramDropdown(expertiseBloc),
            // Expertise Competencies Dropdown
            ExpertiseCompetencyDropdown(expertiseBloc),
            // School type
            StreamBuilder(
              stream: schoolBloc.schoolTypeSelected,
              builder: (context, snapshot) { 
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: schoolBloc.selectedSchoolType,
                      onChanged: (Object e) { schoolBloc.schoolTypeChanged.add(0); },
                    ),
                    Text('Semua'),
                    Radio(
                      value: 1,
                      groupValue: schoolBloc.selectedSchoolType,
                      onChanged: (Object e) { 
                        schoolBloc.schoolTypeChanged.add(1); 
                      },
                    ),
                    Text('Negeri'),
                    Radio(
                      value: 2,
                      groupValue: schoolBloc.selectedSchoolType,
                      onChanged: (Object e) { schoolBloc.schoolTypeChanged.add(2); },
                    ),
                    Text('Swasta'),
                  ],
                );
              }
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (expertiseBloc.selectedExField != null && expertiseBloc.selectedExField.id > 0) {
                        if (expertiseBloc.selectedExProgram == null || expertiseBloc.selectedExCompetency == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Pencarian Gagal'),
                              content: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.error, color: Colors.red, size: 22),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text('Pilih Kompetensi keahlian terlebih dahulu', softWrap: true)
                                    )
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                )
                              ],
                            )
                          );
                          return;
                        }
                      }

                      schoolBloc.resetSchoolsData();
                      schoolBloc.loadSchools.add(SchoolEventArgs(1, 20,
                            provinceId: (commonBloc.selectedProvince == null || (commonBloc.selectedDistrict != null && commonBloc.selectedDistrict.id > 0)) ? 0 : commonBloc.selectedProvince.id,
                            districtId: (commonBloc.selectedDistrict == null || (commonBloc.selectedSubDistrict != null && commonBloc.selectedSubDistrict.districtId != "0")) ? 0 : commonBloc.selectedDistrict.id,
                            subDistrict: (commonBloc.selectedSubDistrict == null || (commonBloc.selectedSubDistrict != null && commonBloc.selectedSubDistrict.districtId == "0")) ? "" : commonBloc.selectedSubDistrict.name,
                            competencyId: expertiseBloc.selectedExCompetency == null ? 0 : expertiseBloc.selectedExCompetency.id,
                            schoolType: schoolBloc.selectedSchoolType));
                      schoolBloc.showFilter.add(false);
                    },
                    color: Color.fromRGBO(220, 53, 69, 1.0),
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
/*
class DisplayUtil {
  int GetFilterPanelFlex(BuildContext context, int panelHeight) {
    int _result;

    double displayHeight = MediaQuery.of(context).size.height;

    if (displayWidth > 375 && displayWidth <= 414) {
      // iPhone 5.5 inch - iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 28;
      iconSize = 50;
    } else if (displayWidth > 320 && displayWidth <= 375) {
      // iPhone 4.7 inch - iPhone 6, iPhone 6S, iPhone 7, iPhone 8
      paddingCard = EdgeInsets.all(15.0);
      iconBoxHeight = 25;
      iconSize = 50;
    } else if (displayWidth <= 320) {
      // iPhone 4-inch - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
      // iPhone 3.5-inch - iPhone 4, iPhone 4S
      paddingCard = EdgeInsets.all(10.0);
      iconBoxHeight = 20;
      iconSize = 40;
      titlePadding = EdgeInsets.only(left: 5.0, right: 5.0, bottom: 8.0);
    } else if (displayWidth > 414 && displayWidth <= 568) {
      // Landscape
      // iPhone 4-inch - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
      // iPhone 3.5-inch - iPhone 4, iPhone 4S
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 40;
      iconSize = 40;
    } else if (displayWidth > 568) {
      // Landscape - rest of iPhone
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 40;
      iconSize = 40;
    }

    return _result;
  }
}
*/