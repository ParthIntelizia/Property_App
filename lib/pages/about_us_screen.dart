import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "About Us",
          style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Buy or sell your house infew seconds with us.The Right Property Company is your local one stop shop for all your property needs.The Right Property Company has extensive experience and strict standards of quality and customer care to create a professional, yet personal residential lettings service that exceeded the expectations of landlords and tenants.Each of our branches are run by passionate, local property experts that operate out of eye-catching shopfronts on the high street. This means you’re getting the benefit of buying, selling and letting with a national brand, but you’re also benefiting from genuine local expertise and knowledge that cannot be learned through corporate training.",
                textScaleFactor: 1.1,
                style: TextStyle(height: 1.5),
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.",
              //   style: TextStyle(height: 1.5),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
