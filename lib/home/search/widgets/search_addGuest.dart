import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant_widgets.dart';
import '../../../providers/search_screen_provider.dart';

class SearchAddGuestWidget extends StatefulWidget {
  const SearchAddGuestWidget({Key? key}) : super(key: key);

  @override
  State<SearchAddGuestWidget> createState() => _SearchAddGuestWidgetState();
}

class _SearchAddGuestWidgetState extends State<SearchAddGuestWidget> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  void initState() {
    SearchScreenProvider _searchScreenProvider =
        Provider.of<SearchScreenProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SearchScreenProvider _searchScreenProvider = Provider.of<SearchScreenProvider>(context);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          adultDropDown(_searchScreenProvider),
          childrenDropDown(_searchScreenProvider),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              constWidgets.textWidget("Total", FontWeight.w600, 14,
                  const Color.fromRGBO(0, 0, 0, 1)),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color.fromRGBO(248, 248, 248, 1)),
                child: Center(
                  child: constWidgets.textWidget(
                      (int.parse(_searchScreenProvider.selectedAdults) +
                              int.parse(_searchScreenProvider.selectedChildren))
                          .toString(),
                      FontWeight.w700,
                      16,
                      const Color.fromRGBO(0, 0, 0, 1)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  adultDropDown(SearchScreenProvider _searchScreenProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        constWidgets.textWidget(
            "Adults", FontWeight.w600, 14, const Color.fromRGBO(0, 0, 0, 1)),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 30,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromRGBO(248, 248, 248, 1)),
          child: DropdownButton<String>(
            value: _searchScreenProvider.selectedAdults,
            alignment: AlignmentDirectional.center,
            borderRadius: BorderRadius.circular(3),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: ConstColors.darkColor,
            ),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _searchScreenProvider.selectAdults(newValue!);
              });
            },
            items: <String>[
              '00',
              '01',
              '02',
              '03',
              '04',
              '05',
              '06',
              '07',
              '08',
              '09',
              '10'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  childrenDropDown(SearchScreenProvider _searchScreenProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        constWidgets.textWidget(
            "Children", FontWeight.w600, 14, const Color.fromRGBO(0, 0, 0, 1)),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 30,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromRGBO(248, 248, 248, 1)),
          child: DropdownButton<String>(
            value: _searchScreenProvider.selectedChildren,
            alignment: AlignmentDirectional.center,
            borderRadius: BorderRadius.circular(3),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: ConstColors.darkColor,
            ),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _searchScreenProvider.selectChildren(newValue!);
              });
            },
            items: <String>[
              '00',
              '01',
              '02',
              '03',
              '04',
              '05',
              '06',
              '07',
              '08',
              '09',
              '10'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
