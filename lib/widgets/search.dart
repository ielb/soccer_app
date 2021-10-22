import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/services/services.dart';

class SearchInput extends StatelessWidget {
  const SearchInput(this._controller, this._hint, this._width, this._icon,
      {this.onChanged,
      this.onSubmit,
      this.onTap,
      this.searching = false,
      this.onClose,
      this.isEnabled = true,
      this.isHavingShadow = false});
  final TextEditingController _controller;
  final String _hint;
  final IconData _icon;
  final double _width;
  final bool isEnabled;
  final Function(String)? onChanged;
  final Function()? onClose;
  final Function()? onTap;
  final Function(String)? onSubmit;
  final searching;
  final bool isHavingShadow;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43,
        width: _width,
        child: TextFormField(
          enabled: isEnabled,
          controller: _controller,
          onChanged: onChanged,
          onTap: onTap,
          onFieldSubmitted: onSubmit,
          textInputAction: TextInputAction.search,
          style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            errorStyle: GoogleFonts.ubuntu(color: Colors.red, fontSize: 12),
            contentPadding: EdgeInsets.only(left: 20),
            filled: true,
            fillColor: Config.perpel,
            hintText: _hint,
            hintStyle:
                GoogleFonts.ubuntu(color: Colors.grey[400], fontSize: 16),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            suffixIcon: Icon(
              _icon,
              color: Colors.grey[350],
            ),
          ),
        ),
        decoration: isHavingShadow
            ? BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 16,
                  offset: Offset(0, 4),
                )
              ])
            : null,
      ),
    );
  }
}
