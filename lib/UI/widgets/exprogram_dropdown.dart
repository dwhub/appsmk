import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/model/expertise_program.dart';

class ExpertiseProgramDropdown extends StatelessWidget {
  final ExpertiseBloc expertiseBloc;

  ExpertiseProgramDropdown(this.expertiseBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: expertiseBloc.exPrograms,
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return _EPDropdown(expertiseBloc);
        } else {
          expertiseBloc.exProgramsData = snapshot.data;

          return StreamBuilder(
            stream: expertiseBloc.exProgramValueChanged,
            builder: (context, valueChanged) {
              return _EPDropdown(expertiseBloc);
            }
          );
        }
      },
    );
  }
}

class _EPDropdown extends StatelessWidget {
  final ExpertiseBloc expertiseBloc;

  _EPDropdown([this.expertiseBloc]);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<ExpertiseProgram>(
          value: expertiseBloc.selectedExProgram,
          hint: Text("Program"),
          items: expertiseBloc.exProgramsData.map((ExpertiseProgram exProgram) {
              return DropdownMenuItem<ExpertiseProgram>(
                value: exProgram,
                child: Text(
                  exProgram.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          onChanged: (ExpertiseProgram newValue) {
            expertiseBloc.exProgramChanged.add(newValue);
          },
        ),
      ),
    );
  }
}