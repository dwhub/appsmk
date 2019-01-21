import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/contact_bloc.dart';
import 'package:kurikulumsmk/bloc/course_duration_bloc.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/bloc/school_bloc.dart';
import 'package:kurikulumsmk/repository/contact_repository.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:kurikulumsmk/repository/district_repository.dart';
import 'package:kurikulumsmk/repository/excompetency_repository.dart';
import 'package:kurikulumsmk/repository/exfield_repository.dart';
import 'package:kurikulumsmk/repository/exprogram_repository.dart';
import 'package:kurikulumsmk/repository/province_repository.dart';
import 'package:kurikulumsmk/repository/school_repository.dart';
import 'package:kurikulumsmk/splash.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main(){
  var container = kiwi.Container();

  // Register repository instance
  container.registerInstance(ProvinceRepository());
  container.registerInstance(DistrictRepository());
  container.registerInstance(ContactRepository());
  container.registerInstance(SchoolRepository());
  container.registerInstance(CourseRepository());
  container.registerInstance(ExpertiseFieldRepository());
  container.registerInstance(ExpertiseProgramRepository());
  container.registerInstance(ExpertiseCompetencyRepository());

  // Register bloc instance
  container.registerInstance(ContactBloc(container.resolve<ContactRepository>()));
  container.registerInstance(SchoolBloc(container.resolve<SchoolRepository>()));
  container.registerInstance(CommonBloc(container.resolve<ProvinceRepository>(),
                                        container.resolve<DistrictRepository>()));
  container.registerInstance(ExpertiseBloc(container.resolve<ExpertiseFieldRepository>(),
                                        container.resolve<ExpertiseProgramRepository>(),
                                        container.resolve<ExpertiseCompetencyRepository>()));
  container.registerInstance(CourseDurationBloc(container.resolve<CourseRepository>()));

  runApp(new MaterialApp(
    home: new Splash(),
  ));
}



