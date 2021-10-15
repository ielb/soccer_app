import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/notification_page.dart';
import 'package:soccer_app/services/services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {required this.username, required this.niveau, required this.points});
  final username;
  final niveau;
  final points;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundImage: AssetImage(Config.kidImage),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi ${username ?? ''}',
                style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Config.perpel),
              ).paddingOnly(bottom: 5),
              Text(
                'Niveau ${niveau ?? 1}',
                style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Config.yallow),
              ),
            ],
          ),
        ).paddingOnly(left: 10),
        Spacer(),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Punten',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Config.perpel),
                  ).paddingOnly(right: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${points ?? 0}',
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Config.yallow),
                          ).paddingOnly(right: 5),
                          Icon(Ionicons.football)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, NotificationPage.id);
                },
                child: Row(
                  children: [
                    Text(
                      'Notificatie',
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Config.perpel),
                    ).paddingOnly(right: 10),
                    Icon(
                      Ionicons.notifications,
                      size: 28,
                      color: Config.perpel,
                    )
                  ],
                ).align(alignment: Alignment.topRight),
              )
            ],
          ),
        ).paddingOnly(left: 10),
      ],
    ).paddingAll(10));
  }
}
