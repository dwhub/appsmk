import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/model/expertise_competency.dart';

class ExpertiseCompetencyDropdown extends StatelessWidget {
  final ExpertiseBloc expertiseBloc;

  ExpertiseCompetencyDropdown(this.expertiseBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: expertiseBloc.exCompetencies,
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return _ECDropdown(expertiseBloc);
        } else {
          expertiseBloc.exCompetenciesData = snapshot.data;

          return StreamBuilder(
            stream: expertiseBloc.exCompetencyValueChanged,
            builder: (context, valueChanged) {
              return _ECDropdown(expertiseBloc);
            }
          );
        }
      },
    );
  }
}

class _ECDropdown extends StatelessWidget {
  final ExpertiseBloc expertiseBloc;

  _ECDropdown([this.expertiseBloc]);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<ExpertiseCompetency>(
          value: expertiseBloc.selectedExCompetency,
          hint: Text("Kompetensi"),
          items: expertiseBloc.exCompetenciesData.map((ExpertiseCompetency exComp) {
              return DropdownMenuItem<ExpertiseCompetency>(
                value: exComp,
                child: Text(
                  exComp.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          onChanged: (ExpertiseCompetency newValue) {
            expertiseBloc.exCompetencyChanged.add(newValue);
          },
        ),
      ),
    );
  }
}