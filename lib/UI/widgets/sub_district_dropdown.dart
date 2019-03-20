import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/model/district.dart';

class SubDistrictDropdown extends StatelessWidget {
  final CommonBloc commonBloc;

  SubDistrictDropdown(this.commonBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: commonBloc.subDistricts,
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return _DsDropdown(commonBloc);
        } else {
          commonBloc.subDistrictsData = snapshot.data;

          return StreamBuilder(
            stream: commonBloc.subDistrictValueChanged,
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
        child: DropdownButton<SubDistrict>(
          value: widget.commonBloc.selectedSubDistrict,
          hint: Text("Kecamatan", style: TextStyle(fontWeight: FontWeight.bold)),
          items: widget.commonBloc.subDistrictsData.map((SubDistrict subDistrict) {
              return DropdownMenuItem<SubDistrict>(
                value: subDistrict,
                child: Text(
                  subDistrict.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          onChanged: (SubDistrict newValue) {
            widget.commonBloc.subDistrictChanged.add(newValue);
            setState(() {
              widget.commonBloc.selectedSubDistrict = newValue;
            });
          },
        ),
      ),
    );
  }
}