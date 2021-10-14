import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/services/services.dart';

class DefaultInput extends StatelessWidget {
  DefaultInput(
      {required this.label,
      required this.icon,
      this.showPassword,
      this.isObsecure = false,
      this.isPassword = false});
  final String label;
  final IconData icon;
  final bool isObsecure;
  final bool isPassword;
  final Function()? showPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(label,
                  style: GoogleFonts.ubuntu(fontSize: 16, color: Config.yallow))
              .paddingOnly(left: 20, bottom: 5, top: 10),
        ),
        Container(
          width: screenSize(context).width * .9,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                if (!isPassword) {
                  return "Email is required";
                } else
                  return "password is required";
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.white),
            obscureText: isObsecure,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Config.yallow,
              ),
              suffixIcon: isPassword
                  ? InkWell(
                      onTap: showPassword,
                      child: Icon(
                        !isObsecure
                            ? Ionicons.eye_outline
                            : Ionicons.eye_off_outline,
                        color: Config.yallow,
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              hintText: label,
              hintStyle: GoogleFonts.ubuntu(fontSize: 14, color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Config.yallow),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Config.yallow),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Config.red),
              ),
            ),
          ),
        )..paddingOnly(
            left: 20,
          ),
      ],
    );
  }
}
