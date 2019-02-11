import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/UI/widgets/district_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/province_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/school_tile.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/bloc/school_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/event/school_event_args.dart';
import 'package:kurikulumsmk/model/expertise_competency.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/utils/constants.dart';

class SchoolDetailScreen extends StatefulWidget {
  final int competencyId;
  
  const SchoolDetailScreen(this.competencyId);

  @override
  SchoolDetailScreenState createState() {
    return new SchoolDetailScreenState(competencyId);
  }
}

class SchoolDetailScreenState extends State<SchoolDetailScreen> {
  final schoolBloc = kiwi.Container().resolve<SchoolBloc>();
  final commonBloc = kiwi.Container().resolve<CommonBloc>();
  final expertiseBloc = kiwi.Container().resolve<ExpertiseBloc>();

  final int competencyId;

  SchoolDetailScreenState(this.competencyId);

  @override
  void initState() {
    super.initState();
    schoolBloc.reset();
    expertiseBloc.reset();
    commonBloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    expertiseBloc.selectedExCompetency = ExpertiseCompetency(id: this.competencyId);

    if (schoolBloc.schoolsData.length == 0) {
      schoolBloc.loadSchools.add(SchoolEventArgs(1, 20, competencyId: competencyId));
    }

    if (commonBloc.provincesData.length == 0) {
      commonBloc.loadProvinces.add(null);
      commonBloc.selectedProvince = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sekolah"),
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
          stream: schoolBloc.filterSelected,
          builder: (context, snapshot) {
            if (commonBloc.provincesData.length == 0 && schoolBloc.filterVisible) {
              commonBloc.loadProvinces.add(null);
              commonBloc.selectedProvince = null;
            }

            return Visibility(
              child: SchoolFilter(commonBloc, schoolBloc, expertiseBloc),
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
        ]
      ),
    );
  }
}

class SchoolFilter extends StatelessWidget {
  final SchoolBloc schoolBloc;
  final CommonBloc commonBloc;
  final ExpertiseBloc expertiseBloc;

  SchoolFilter([this.commonBloc, this.schoolBloc, this.expertiseBloc]);

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
                      schoolBloc.resetSchoolsData();
                      schoolBloc.loadSchools.add(SchoolEventArgs(1, 20,
                            provinceId: commonBloc.selectedProvince == null ? 0 : commonBloc.selectedProvince.id,
                            districtId: commonBloc.selectedDistrict == null ? 0 : commonBloc.selectedDistrict.id,
                            competencyId: expertiseBloc.selectedExCompetency == null ? 0 : expertiseBloc.selectedExCompetency.id,
                            schoolType: schoolBloc.selectedSchoolType));
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