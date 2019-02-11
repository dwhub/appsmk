import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/common_bloc.dart';
import 'package:kurikulumsmk/model/province.dart';

class ProvinceDropdown extends StatelessWidget {
  final CommonBloc commonBloc;

  ProvinceDropdown(this.commonBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: commonBloc.provinces,
      builder: (context, snapshot) {
        if (!snapshot.hasData && commonBloc.provincesData.length < 1)
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

        if (commonBloc.provincesData.length < 1) {
          commonBloc.provincesData = snapshot.data as List<Province>;
        }

        return StreamBuilder(
          stream: commonBloc.provinceValueChanged,
          builder: (context, valueChanged) {
            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Province>(
                  value: commonBloc.selectedProvince,
                  hint: Text("Provinsi", style: TextStyle(fontWeight: FontWeight.bold)),
                  items: commonBloc.provincesData.map((Province provinsi) {
                      return DropdownMenuItem<Province>(
                        value: provinsi,
                        child: Text(
                          provinsi.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  onChanged: (Province newValue) {
                    commonBloc.provinceChanged.add(newValue);
                  },
                ),
              ),
            );
          }
        );
      });
  }
}