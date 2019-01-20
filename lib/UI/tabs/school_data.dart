import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/tiles/school_list_tile.dart';
import 'package:kurikulumsmk/UI/widgets/district_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/excompetency_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/exfield_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/exprogram_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/province_dropdown.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            schoolBloc.showFilter.add(!schoolBloc.filterVisible);
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
              child: SchoolFilter(commonBloc, expertiseBloc, schoolBloc),
              visible: schoolBloc.filterVisible,
            );
          }
        ),
        Divider(),
        Expanded(
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
    );
  }
}

class SchoolTile extends StatelessWidget {
  final List<School> schools;
  final SchoolBloc schoolBloc;
  final CommonBloc commonBloc;
  final ExpertiseBloc expertiseBloc;

  final int currentPage;
  final int totalPage;

  SchoolTile({Key key, this.schools, this.schoolBloc, this.commonBloc, this.expertiseBloc, this.currentPage, this.totalPage}) : super(key: key);

  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: onNotification,
        child: new ListView.builder(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            controller: scrollController,
            itemCount: schools.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return SchoolListTile(school: schools[index]);
            }));
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (schoolBloc.loadMoreStatus != null &&
            schoolBloc.loadMoreStatus == LoadMoreStatus.STABLE &&
            currentPage + 1 <= totalPage) {
          schoolBloc.loadMoreStatus = LoadMoreStatus.LOADING;
          schoolBloc.loadSchools.add(SchoolEventArgs(currentPage + 1, 20,
                            provinceId: commonBloc.selectedProvince == null ? 0 : commonBloc.selectedProvince.id,
                            districtId: commonBloc.selectedDistrict == null ? 0 : commonBloc.selectedDistrict.id,
                            competendyId: expertiseBloc.selectedExCompetency == null ? 0 : expertiseBloc.selectedExCompetency.id,
                            schoolType: schoolBloc.selectedSchoolType));
        }
      }
    }
    return true;
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
      height: 355,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Province Dropdown
            ProvinceDropdown(commonBloc),
            // District Dropdown
            DistrictDropdown(commonBloc),
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
                      if (expertiseBloc.selectedExField != null) {
                        if (expertiseBloc.selectedExProgram == null || expertiseBloc.selectedExCompetency == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Filter Gagal'),
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
                            provinceId: commonBloc.selectedProvince == null ? 0 : commonBloc.selectedProvince.id,
                            districtId: commonBloc.selectedDistrict == null ? 0 : commonBloc.selectedDistrict.id,
                            competendyId: expertiseBloc.selectedExCompetency == null ? 0 : expertiseBloc.selectedExCompetency.id,
                            schoolType: schoolBloc.selectedSchoolType));
                      schoolBloc.showFilter.add(false);
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