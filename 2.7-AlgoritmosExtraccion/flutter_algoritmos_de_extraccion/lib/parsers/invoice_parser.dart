import '../utils/regex_utils.dart';

class InvoiceData {
  final String? date;
  final double? total;
  final String? invoiceCode;

  InvoiceData({this.date, this.total, this.invoiceCode});
}

class InvoiceParser {

  static InvoiceData parse(String rawText) {
    final lines = rawText.split('\n');

    final date = _extractDate(rawText);
    final total = _extractTotal(lines);
    final code = _extractInvoiceCode(rawText);

    return InvoiceData(
      date: date,
      total: total,
      invoiceCode: code,
    );
  }

  static String? _extractDate(String text) {
    final match = RegexUtils.dateRegex.firstMatch(text);
    return match?.group(0);
  }

  static String? _extractInvoiceCode(String text) {
    final match = RegexUtils.invoiceCodeRegex.firstMatch(text);
    return match?.group(0);
  }

  static double? _extractTotal(List<String> lines) {
    double? bestCandidate;

    for (final line in lines) {
      final hasTotalKeyword =
          RegexUtils.totalKeywordRegex.hasMatch(line);

      final matches =
          RegexUtils.amountRegex.allMatches(line);

      for (final match in matches) {
        final value = _normalizeAmount(match.group(0)!);

        if (value == null) continue;

        // Heurística fuerte:
        if (hasTotalKeyword) {
          return value;
        }

        // Heurística débil:
        if (bestCandidate == null || value > bestCandidate!) {
          bestCandidate = value;
        }
      }
    }

    return bestCandidate;
  }

  static double? _normalizeAmount(String raw) {
    final cleaned = raw
        .replaceAll(RegExp(r'[^\d,\.]'), '')
        .replaceAll(',', '.');

    return double.tryParse(cleaned);
  }
}
