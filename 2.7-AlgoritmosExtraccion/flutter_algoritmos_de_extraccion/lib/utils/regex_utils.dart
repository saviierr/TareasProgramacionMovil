class RegexUtils {

  /// Fechas: DD/MM/YYYY | DD-MM-YYYY | YYYY-MM-DD
  static final RegExp dateRegex = RegExp(
    r'(\b\d{2}[\/\-]\d{2}[\/\-]\d{4}\b)|(\b\d{4}[\/\-]\d{2}[\/\-]\d{2}\b)',
  );

  /// Montos con o sin símbolo $
  static final RegExp amountRegex = RegExp(
    r'(\$?\s?\d{1,3}(?:[\.,]\d{3})*(?:[\.,]\d{2}))',
  );

  /// Código de factura tipo 001-001-123456789
  static final RegExp invoiceCodeRegex = RegExp(
    r'\b\d{3}-\d{3}-\d{6,9}\b',
  );

  /// Palabras clave que indican TOTAL
  static final RegExp totalKeywordRegex = RegExp(
    r'\b(total|total a pagar|importe total)\b',
    caseSensitive: false,
  );
}
