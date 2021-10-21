import 'package:soccer_app/services/services.dart';

class Config {
  static String handsUpImage = "assets/images/Blije_Knorrie.png";
  static const thumbsUp = "assets/images/Duim_Omhoog.png";
  static const thumbsDown = "assets/images/Duim_Omlaag.png";
  static const love = "assets/images/Hartje_Van_Knorrie.png";
  static const eating = "assets/images/Knorrie_Eet_Gezond.png";
  static const good = "assets/images/Knorrie_Fietst.png";
  static const angry = "assets/images/Knorrie_Is_Boos.png";
  static const win = "assets/images/Knorrie_Is_Gewonnen.png";
  static const sad = "assets/images/Knorrie_Is_Verdrietig.png";
  static const sick = "assets/images/Knorrie_Is_Ziek.png";
  static const learning = "assets/images/Knorrie_Maakt_Huiswerk.png";
  static const showering = "assets/images/Knorrie_Neemt_Douche.png";
  static const corona = "assets/images/Knorrie_Ontsmet.png";
  static const brushing = "assets/images/Knorrie_Poetst_Zijn_Tanden.png";
  static const dreaming = "assets/images/Knorrie_Slaapt.png";
  static const doIt = "assets/images/Knorrie_Stipit.png";
  static const soccer = "assets/images/Knorrie_Voetbalt.png";
  static const kidImage = 'assets/images/kid.jpg';
  static const soccer_icon = 'assets/images/icon_soccer.png';

  //games images
  static const math_game = 'assets/images/games/blackboard.png';
  static const memory_game = 'assets/images/games/card-games.png';
  static const quiz_game = 'assets/images/games/choose.png';
  static const asign_game = 'assets/images/games/distribution.png';

  static const emaii_sent = 'assets/images/email_sent.png';

  static const error_image = 'assets/images/error.png';
  static const Color yallow = Color(0xffebd216);
  static const Color perpel = Color(0xff303289);
  static const Color blue = Color(0xff1877f2);
  static const Color red = Color(0xffF14336);
  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  static bool isPassword(String password) {
    bool isPass = password.length >= 8 ? true : false;

    return isPass;
  }
}
