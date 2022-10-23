
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class ScheduleItemWidget extends StatefulWidget {

  const ScheduleItemWidget({Key? key}) : super(key: key);

  @override
  State<ScheduleItemWidget> createState() => _ScheduleItemWidgetState();
}

class _ScheduleItemWidgetState extends State<ScheduleItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: ConstColors.widgetDividerColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constWidgets.textWidget(
                "Schedule: ", FontWeight.w700, 20, Colors.black),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.pool,
                                  size: 16,
                                  color: ConstColors.lightColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    constWidgets.textWidget(
                                        "Pool",
                                        FontWeight.w700,
                                        12,
                                        Colors.black),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ConstColors.lightColor,
                                      size: 12,
                                    ),
                                  ]),
                                  constWidgets.textWidget(
                                      "08:00 To 09:30 AM",
                                      FontWeight.w100,
                                      12,
                                      Colors.black)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.spa,
                                  size: 16,
                                  color: ConstColors.lightColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    constWidgets.textWidget(
                                        "Spa",
                                        FontWeight.w700,
                                        12,
                                        Colors.black),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ConstColors.lightColor,
                                      size: 12,
                                    ),
                                  ]),
                                  constWidgets.textWidget(
                                      "10:30 To 11:15 AM",
                                      FontWeight.w100,
                                      12,
                                      Colors.black)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.free_breakfast_rounded,
                                  size: 16,
                                  color: ConstColors.lightColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    constWidgets.textWidget(
                                        "Breakfast",
                                        FontWeight.w700,
                                        12,
                                        Colors.black),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ConstColors.lightColor,
                                      size: 12,
                                    ),
                                  ]),
                                  constWidgets.textWidget(
                                      "09:45 To 10:15 AM",
                                      FontWeight.w100,
                                      12,
                                      Colors.black)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.lunch_dining,
                                  size: 16,
                                  color: ConstColors.lightColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    constWidgets.textWidget(
                                        "Lunch",
                                        FontWeight.w700,
                                        12,
                                        Colors.black),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ConstColors.lightColor,
                                      size: 12,
                                    ),
                                  ]),
                                  constWidgets.textWidget(
                                      "11:30 To 12:30 AM",
                                      FontWeight.w100,
                                      12,
                                      Colors.black)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
