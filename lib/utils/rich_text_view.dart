import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () { 
                var cleanUrl = url.replaceAll("\n", "");
                launcher.launch(cleanUrl.trim());
              }
            );
}

class PhoneTextSpan extends TextSpan {
  PhoneTextSpan({TextStyle style, String phoneNumber, String text})
      : super(
            style: style,
            text: text ?? phoneNumber,
            recognizer: new TapGestureRecognizer()
              ..onTap = () => launcher.launch('tel:' + phoneNumber));
}

class RichTextView extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;
  // Color.fromRGBO(220, 53, 69, 1.0)
  RichTextView({@required this.text, @required this.textAlign, @required this.color});

  bool _isLink(String input) {
    final matcher = RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(input);
  }

  bool _isPhone(String input) {
    final matcher = RegExp(
        r"(^(^\+62\s?|^0)(\d{3,4}-?){2}\d{3,4}$)");
    return matcher.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.body1;
    final words = text.split(' ');
    List<TextSpan> span = [];
    words.forEach((word) {
      bool isLink = _isLink(word);
      bool isPhone = _isPhone(word);

      TextSpan tSpan;

      if (isLink) {
        tSpan = LinkTextSpan(
              text: '$word ',
              url: word,
              style: _style.copyWith(color: Color.fromRGBO(220, 53, 69, 1.0)));
      } else if (isPhone) {
        tSpan = PhoneTextSpan(
              text: '$word ',
              phoneNumber: word,
              style: _style.copyWith(color: Color.fromRGBO(220, 53, 69, 1.0)));
      } else {
        tSpan = TextSpan(text: '$word ', style: _style.copyWith(color: color));
      }
      span.add(tSpan);
    });
    if (span.length > 0) {
      return RichText(
        textAlign: textAlign,
        text: TextSpan(text: '', children: span),
      );
    } else {
      return Text(text);
    }
  }
}