import 'package:flutter/material.dart';

class BorderTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String placeholder;
  final int? minLine;
  final int? maxLines;
  final bool? isPassword;
  final Function onChangeText;
  final TextInputType? typeKey;
  final bool? validator;
  final bool? enabled;
  const BorderTextField({
    required this.controller,
    super.key,
    required this.title,
    required this.placeholder,
    this.minLine,
    this.maxLines,
    this.isPassword,
    required this.onChangeText,
    this.typeKey,
    this.validator,
    this.enabled,
  });

  @override
  State<BorderTextField> createState() => _BorderTextFieldState();
}

class _BorderTextFieldState extends State<BorderTextField> {
  bool showpass = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: (widget.validator == false) ? Colors.red : Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            enabled: widget.enabled,
            keyboardType: widget.typeKey ?? TextInputType.text,
            controller: widget.controller,
            obscureText: (widget.isPassword == true) ? showpass : false,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLine ?? 1,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 13),
              suffixIcon: (widget.isPassword == true)
                  ? IconButton(
                      icon: Icon(
                        showpass ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 22,
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
                      onPressed: () {
                        setState(() {
                          showpass = !showpass;
                        });
                      },
                    )
                  : const Text(""),
            ),
            onChanged: (text) {
              widget.onChangeText(text);
            },
          ),
        ),
      ],
    );
  }
}
