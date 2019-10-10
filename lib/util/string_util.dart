import 'package:html_unescape/html_unescape.dart';

class StringUtil {
  static final HtmlUnescape _htmlUnescape = HtmlUnescape();
  static String htmlUnescape(String data) {
    return data == null ? null : _htmlUnescape.convert(data);
  }

  static String removeHtmlLabel(String data) {
    return data?.replaceAll(RegExp('<[^>]+>'), '');
  }
}
