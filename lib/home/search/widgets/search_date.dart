import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:luxepass/constants/constant_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/search_screen_provider.dart';

class SearchDate extends StatefulWidget {
  const SearchDate({Key? key}) : super(key: key);

  @override
  State<SearchDate> createState() => _SearchDateState();
}

class _SearchDateState extends State<SearchDate> {
  @override
  void initState() {
    SearchScreenProvider _searchScreenProvider = Provider.of<SearchScreenProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  ConstWidgets constWidgets = ConstWidgets();
  @override
  Widget build(BuildContext context) {
    SearchScreenProvider _searchScreenProvider = Provider.of<SearchScreenProvider>(context);
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 1,
              shadowColor: ConstColors.widgetDividerColor,
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(248, 248, 248, 1),
                    borderRadius: BorderRadius.circular(50)),
                child: TextFormField(
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  controller: _searchScreenProvider.dateSelectedController,
                  cursorColor: const Color.fromRGBO(88, 165, 196, 1),
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: ConstColors.searchBoxTitleColor),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        String _selectedDate =
                            DateFormat.yMMMd().format(value!);

                        // personDOBcontroller.text = _selectedDate;
                        // dob = _selectedDate;
                        _searchScreenProvider.selectDate(_selectedDate);
                      });
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(248, 248, 248, 1),
                    filled: true,
                    counterText: '',
                    hintText: 'DD/MM/YYYY',
                    suffixIcon: const Icon(Icons.calendar_month,
                        color: Color.fromRGBO(0, 0, 0, 0.29)),
                    hintStyle: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color.fromRGBO(0, 0, 0, 0.29)),
                    alignLabelWithHint: false,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    errorStyle:
                        const TextStyle(color: Color.fromRGBO(240, 20, 41, 1)),
                    focusColor: const Color.fromRGBO(88, 165, 196, 1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(248, 248, 248, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(248, 248, 248, 1),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
