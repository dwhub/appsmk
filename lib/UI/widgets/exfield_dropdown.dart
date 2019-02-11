import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/expertise_bloc.dart';
import 'package:kurikulumsmk/model/expertise_field.dart';

class ExpertiseFieldDropdown extends StatelessWidget {
  final ExpertiseBloc expertiseBloc;

  ExpertiseFieldDropdown(this.expertiseBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: expertiseBloc.exFields,
      builder: (context, snapshot) {
        if (!snapshot.hasData && expertiseBloc.exFieldsData.length < 1)
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 15.0,
                width: 15.0,
              ),
            ),
          );

        if (expertiseBloc.exFieldsData.length < 1) {
          expertiseBloc.exFieldsData = snapshot.data as List<ExpertiseField>;
        }

        return StreamBuilder(
          stream: expertiseBloc.exFieldValueChanged,
          builder: (context, valueChanged) {
            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<ExpertiseField>(
                  value: expertiseBloc.selectedExField,
                  hint: Text("Bidang", style: TextStyle(fontWeight: FontWeight.bold)),
                  items: expertiseBloc.exFieldsData.map((ExpertiseField exField) {
                      return DropdownMenuItem<ExpertiseField>(
                        value: exField,
                        child: Text(
                          exField.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  onChanged: (ExpertiseField newValue) {
                    expertiseBloc.exFieldChanged.add(newValue);
                  },
                ),
              ),
            );
          }
        );
      });
  }
}