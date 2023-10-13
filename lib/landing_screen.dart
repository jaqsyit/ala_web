import 'package:ala_web/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(50),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Профессионалды Bi-LED орнату',
                        style: CustomTextStyles.s40w600cb,
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Сіздің фаралар премиум көлік сияқты жарқырайды',
                        style: CustomTextStyles.s35w400cb,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 250,
                            child: ElevatedButton(
                              style: AppStyles.activeButton,
                              onPressed: () {},
                              child: const Text(
                                'Кезекке жазылу',
                                style: CustomTextStyles.s20w400cw,
                              ),
                            ),
                          ),
                          const Text('немесе байланысу'),
                          InkWell(
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                margin: const EdgeInsets.all(10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppStyles.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                )),
                          ),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/insta.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/whatsapp.svg',
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/img/far.png',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
