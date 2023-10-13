import 'package:ala_web/constants/app_styles.dart';
import 'package:ala_web/widgets/form_kezek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool formVisibility = false;

  void whenButtonPressed() {
    setState(() {
      formVisibility = !formVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLargeScreen = constraints.maxWidth > 600;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    width: isLargeScreen ? 1280 : MediaQuery.of(context).size.width,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 50),
                                child: Image.asset(
                                  'assets/img/logo.png',
                                  scale: 2,
                                ),
                              ),
                              const Text(
                                'Профессионалды Bi-LED орнату',
                                style: CustomTextStyles.s40w600cb,
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                'Сіздің фаралар премиум-класс көліктей жарқырайтын болады',
                                style: CustomTextStyles.s30w400cb,
                              ),
                              const SizedBox(height: 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 50),
                                    height: 60,
                                    width: 250,
                                    child: ElevatedButton(
                                      style: AppStyles.activeButton,
                                      onPressed: () {
                                        whenButtonPressed();
                                      },
                                      child: const Text(
                                        'Кезекке жазылу',
                                        style: CustomTextStyles.s20w400cw,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'немесе байланысу',
                                      style: CustomTextStyles.s16w400cb,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launch('tel:+77083444524');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          margin: const EdgeInsets.all(10),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: AppStyles.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String url =
                                              'https://www.instagram.com/auto_light_ozen/';
                                          if (!await launchUrl(Uri.parse(url))) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          margin: const EdgeInsets.all(10),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/insta.svg',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String url =
                                              'https://wa.me/77083444524';
                                          if (!await launchUrl(Uri.parse(url))) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          margin: const EdgeInsets.all(10),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/whatsapp.svg',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        isLargeScreen
                            ? Image.asset(
                                'assets/img/far.png',
                                scale: 0.8,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(50),
                    child: formVisibility
                        ? const KezekCarAddWidget(count: 5)
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
