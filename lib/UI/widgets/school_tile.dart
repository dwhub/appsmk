import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/tiles/school_list_tile.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/bloc/school_bloc.dart';
import 'package:kurikulumsmk/event/school_event_args.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/utils/constants.dart';

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
                            competencyId: expertiseBloc.selectedExCompetency == null ? 0 : expertiseBloc.selectedExCompetency.id,
                            schoolType: schoolBloc.selectedSchoolType));
        }
      }
    }
    return true;
  }
}