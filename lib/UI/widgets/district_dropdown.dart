import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/model/district.dart';

class DistrictDropdown extends StatelessWidget {
  final CommonBloc commonBloc;

  DistrictDropdown(this.commonBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: commonBloc.districts,
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return _DsDropdown(commonBloc);
        } else {
          commonBloc.districtsData = snapshot.data;

          return StreamBuilder(
            stream: commonBloc.districtValueChanged,
            builder: (context, valueChanged) {
              return _DsDropdown(commonBloc);
            }
          );
        }
      },
    );
  }
}

class _DsDropdown extends StatelessWidget {
  final CommonBloc commonBloc;

  _DsDropdown([this.commonBloc]);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<District>(
          value: commonBloc.selectedDistrict,
          hint: Text("Kabupaten"),
          items: commonBloc.districtsData.map((District district) {
              return DropdownMenuItem<District>(
                value: district,
                child: Text(
                  district.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          onChanged: (District newValue) {
            commonBloc.districtChanged.add(newValue);
          },
        ),
      ),
    );
  }
}