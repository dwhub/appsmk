import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/bloc/contact_bloc.dart';
import 'package:kurikulumsmk/bloc/course_allocation_bloc.dart';
import 'package:kurikulumsmk/bloc/course_book_bloc.dart';
import 'package:kurikulumsmk/bloc/course_duration_bloc.dart';
import 'package:kurikulumsmk/bloc/course_kikd_bloc.dart';
import 'package:kurikulumsmk/bloc/curriculum_bloc.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/bloc/school_bloc.dart';
import 'package:kurikulumsmk/bloc/nexam_bloc.dart';
import 'package:kurikulumsmk/bloc/nes_bloc.dart';
import 'package:kurikulumsmk/bloc/file_server_bloc.dart';
import 'package:kurikulumsmk/repository/contact_repository.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:kurikulumsmk/repository/district_repository.dart';
import 'package:kurikulumsmk/repository/excompetency_repository.dart';
import 'package:kurikulumsmk/repository/exfield_repository.dart';
import 'package:kurikulumsmk/repository/expertise_structure_repository.dart';
import 'package:kurikulumsmk/repository/exprogram_repository.dart';
import 'package:kurikulumsmk/repository/neducation_structure_repository.dart';
import 'package:kurikulumsmk/repository/province_repository.dart';
import 'package:kurikulumsmk/repository/school_repository.dart';
import 'package:kurikulumsmk/repository/nexam_structure_repository.dart';
import 'package:kurikulumsmk/repository/fs_repository.dart';
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
  container.registerInstance(ExpertiseStructureRepository());
  container.registerInstance(NationalExamStructureRepository());
  container.registerInstance(FileServerRepository());
  container.registerInstance(NationalEducationStructureRepository());

  // Register bloc instance
  container.registerInstance(ContactBloc(container.resolve<ContactRepository>()));
  container.registerInstance(SchoolBloc(container.resolve<SchoolRepository>()));
  container.registerInstance(CommonBloc(container.resolve<ProvinceRepository>(),
                                        container.resolve<DistrictRepository>()));
  container.registerInstance(ExpertiseBloc(container.resolve<ExpertiseFieldRepository>(),
                                        container.resolve<ExpertiseProgramRepository>(),
                                        container.resolve<ExpertiseCompetencyRepository>()));
  container.registerInstance(CourseDurationBloc(container.resolve<CourseRepository>()));
  container.registerInstance(CourseAllocationBloc(container.resolve<CourseRepository>()));
  container.registerInstance(CourseKIKDBloc(container.resolve<CourseRepository>()));
  container.registerInstance(CourseBookBloc(container.resolve<CourseRepository>()));
  container.registerInstance(CurriculumBloc(container.resolve<ExpertiseStructureRepository>()));
  container.registerInstance(NationalExamBloc(container.resolve<NationalExamStructureRepository>()));
  container.registerInstance(FileServerBloc(container.resolve<FileServerRepository>()));
  container.registerInstance(NationalEducationBloc(container.resolve<NationalEducationStructureRepository>()));

  runApp(new MaterialApp(
    theme: ThemeData(
      // Define the default Brightness and Colors
      brightness: Brightness.light,
      //backgroundColor: Color.fromRGBO(220, 53, 69, 1.0),
      primaryColor: Color.fromRGBO(220, 53, 69, 1.0),
      accentColor: Colors.red[600],
      
      // Define the default Font Family
      //ontFamily: 'Montserrat',
      
      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      //textTheme: TextTheme(
      //  headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //  body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      //),
      
    ),
    home: Splash(),
  ));
}



