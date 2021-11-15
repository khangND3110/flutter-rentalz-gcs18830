import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPasswordTextInput extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final String? hintText;
  final String? inputTitle;
  final bool? isErrorVisible;
  final VoidCallback? onShowPasswordClicked;
  final VoidCallback? onSubmitted;
  final String? defaultValue;
  final Widget? prefixIcon;
  final bool? initialized;
  final String? errorText;
  final TextInputAction? inputAction;
  final Function(bool)? onFocusChanged;
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry? margin;
  final TextInputType? textInputType;
  final bool isShowPassword;
  final double? borderRadius;

  CustomPasswordTextInput({
    Key? key,
    this.focusNode,
    required this.onChanged,
    this.hintText,
    this.inputTitle,
    this.isErrorVisible,
    this.onShowPasswordClicked,
    this.onSubmitted,
    this.defaultValue,
    this.prefixIcon,
    this.initialized,
    this.errorText,
    this.inputAction,
    this.onFocusChanged,
    this.margin,
    this.textEditingController,
    this.textInputType,
    this.isShowPassword = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? _textController = textEditingController;
    final cursorPos = _textController?.selection.base.offset ?? defaultValue?.length ?? 0;
    _textController ??= TextEditingController(text: defaultValue ?? '');

    ///Set cursor position
    _textController.selection = TextSelection.fromPosition(TextPosition(offset: cursorPos));

    FocusNode? _focusNode = focusNode;
    _focusNode ??= FocusNode();
    _focusNode.addListener(() {
      onFocusChanged?.call(_focusNode?.hasFocus ?? false);
    });
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.0),
              child: Text(
                inputTitle ?? '',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: margin ?? EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  obscureText: !isShowPassword,
                  controller: _textController,
                  keyboardType: textInputType ?? TextInputType.emailAddress,
                  focusNode: _focusNode,
                  textInputAction: inputAction ?? TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  onEditingComplete: onSubmitted,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: prefixIcon != null
                        ? Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: prefixIcon,
                          )
                        : SizedBox(),
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: 25.0,
                      maxHeight: 15.0,
                    ),
                    suffixIcon: (defaultValue?.isNotEmpty ?? false)
                        ? GestureDetector(
                            onTap: onShowPasswordClicked,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: Icon(
                                isShowPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : SizedBox(),
                    suffixIconConstraints: BoxConstraints(
                      maxWidth: 30.0,
                      maxHeight: 20.0,
                    ),
                    hintText: hintText ?? '',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ),
            ((isErrorVisible ?? false) && (initialized ?? false))
                ? Container(
                    height: 15.0,
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(
                      errorText ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
