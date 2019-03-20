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

class _DsDropdown extends StatefulWidget {
  final CommonBloc commonBloc;

  _DsDropdown([this.commonBloc]);

  @override
  __DsDropdownState createState() => __DsDropdownState();
}

class __DsDropdownState extends State<_DsDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<District>(
          value: widget.commonBloc.selectedDistrict,
          hint: Text("Kabupaten", style: TextStyle(fontWeight: FontWeight.bold)),
          items: widget.commonBloc.districtsData.map((District district) {
              return DropdownMenuItem<District>(
                value: district,
                child: Text(
                  district.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          onChanged: (District newValue) {
            widget.commonBloc.districtChanged.add(newValue);
            setState(() {
              widget.commonBloc.selectedDistrict = newValue;
            });
          },
        ),
      ),
    );
  }
}