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
          // Province dropdown
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ProvinceDropdown(commonBloc),
          ),
          // District Dropdown
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: DistrictDropdown(commonBloc),
          ),
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