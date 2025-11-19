import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfInvoiceService {
  // Private constructor to prevent instantiation
  PdfInvoiceService._();

  static Future<String> generateInvoicePdf(Map<String, dynamic> order) async {
    final pdf = pw.Document();

    // Extract data
    final customer = order['customerId'] ?? {};
    final items = order['items'] as List<dynamic>;
    final payment = order['payment'] ?? {};
    final address = order['shippingAddress'] ?? {};

    final subtotal = _calculateSubtotal(items);
    final discount = order['discount'] ?? 0;
    final tax = order['tax'] ?? 0;
    final grandTotal = order['grandTotal'] ?? 0;
    final totalItems = _calculateTotalItems(items);

    final orderCode = order['orderCode'] ?? 'N/A';
    final invoiceNumber = order['InvoiceNumber'] ?? 'N/A';
    final createdDate = _formatDate(order['createdAt']);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(40),
        build: (context) => [
          // Header
          _buildHeader(orderCode),
          pw.SizedBox(height: 30),

          // Order & Invoice Info
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoBox('ORDER ID', '#$orderCode'),
              _buildInfoBox('INVOICE', invoiceNumber),
              _buildInfoBox('DATE', createdDate),
            ],
          ),
          pw.SizedBox(height: 30),

          // Customer & Shipping Info
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: _buildSection(
                  'BILL TO',
                  [
                    customer['customerName'] ?? 'N/A',
                    customer['contactPerson'] ?? 'N/A',
                    customer['emailAddress'] ?? 'N/A',
                  ],
                ),
              ),
              pw.SizedBox(width: 40),
              pw.Expanded(
                child: _buildSection(
                  'SHIP TO',
                  [
                    address['street'] ?? '',
                    address['line2'] ?? '',
                    '${address['city'] ?? ''}, ${address['state'] ?? ''}',
                    address['postalCode'] ?? '',
                    address['country'] ?? '',
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 30),

          // Items Table
          _buildItemsTable(items),
          pw.SizedBox(height: 20),

          // Summary
          _buildSummary(subtotal, discount, tax, grandTotal),
          pw.SizedBox(height: 30),

          // Payment Info
          _buildPaymentInfo(payment),
          pw.SizedBox(height: 40),

          // Footer
          _buildFooter(),
        ],
      ),
    );

    // Save PDF
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/Invoice_$orderCode.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  // Helper Methods
  static double _calculateSubtotal(List<dynamic> items) {
    return items.fold(0.0, (sum, item) => sum + (item['total'] ?? 0.0));
  }

  static int _calculateTotalItems(List<dynamic> items) {
    return items.fold<int>(0, (sum, item) {
      final q = item['quantity'];
      return sum +
          (q is num ? q.toInt() : int.tryParse(q?.toString() ?? '') ?? 0);
    });
  }

  static String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      return DateFormat('dd/MM/yyyy • HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }

  // Widget Builder Methods
  static pw.Widget _buildHeader(String orderCode) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '🛒 ORDER INVOICE',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Professional Invoice & Receipt',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.blue400, width: 2),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Order #$orderCode',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue400,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Valid Invoice',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Divider(
          color: PdfColors.grey300,
          thickness: 1.5,
        ),
      ],
    );
  }

  static pw.Widget _buildInfoBox(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue400,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSection(String title, List<String> content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey800,
            letterSpacing: 0.5,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: content
              .where((line) => line.isNotEmpty)
              .map((line) => pw.Text(
                    line,
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                      height: 1.6,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  static pw.Widget _buildItemsTable(List<dynamic> items) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          // Header
          pw.Container(
            color: PdfColors.blue50,
            padding: pw.EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    'PRODUCT',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue400,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'QTY',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue400,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'PRICE',
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue400,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'TOTAL',
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;

            return pw.Container(
              decoration: pw.BoxDecoration(
                border: isLast
                    ? null
                    : pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.grey200,
                          width: 0.5,
                        ),
                      ),
              ),
              padding: pw.EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Product ${(item['productId'] ?? 'N/A').toString().substring(0, 8)}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey800,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      '${item['quantity'] ?? 0}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '₹${(item['price'] ?? 0).toStringAsFixed(2)}',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '₹${(item['total'] ?? 0).toStringAsFixed(2)}',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  static pw.Widget _buildSummary(
    double subtotal,
    double discount,
    double tax,
    double grandTotal,
  ) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.SizedBox(
                width: 120,
                child: pw.Text(
                  'Subtotal:',
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
              pw.SizedBox(width: 20),
              pw.SizedBox(
                width: 100,
                child: pw.Text(
                  '₹${subtotal.toStringAsFixed(2)}',
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey800,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          if (discount > 0)
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 120,
                      child: pw.Text(
                        'Discount:',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text(
                        '-₹${discount.toStringAsFixed(2)}',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
              ],
            ),
          if (tax > 0)
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 120,
                      child: pw.Text(
                        'Tax:',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text(
                        '+₹${tax.toStringAsFixed(2)}',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey800,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
              ],
            ),
          pw.Divider(
            color: PdfColors.grey300,
            thickness: 1.5,
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.SizedBox(
                width: 120,
                child: pw.Text(
                  'GRAND TOTAL:',
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue400,
                  ),
                ),
              ),
              pw.SizedBox(width: 20),
              pw.SizedBox(
                width: 100,
                child: pw.Text(
                  '₹${grandTotal.toStringAsFixed(2)}',
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentInfo(Map<String, dynamic> payment) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'PAYMENT METHOD',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey700,
                  letterSpacing: 0.5,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300, width: 1),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  (payment['mode']?.toString() ?? 'N/A').toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue400,
                  ),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 40),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'PAYMENT STATUS',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey700,
                  letterSpacing: 0.5,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColors.orange50,
                  border: pw.Border.all(color: PdfColors.orange, width: 1),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  payment['status']?.toString().toUpperCase() ?? 'N/A',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300, thickness: 1),
        pw.SizedBox(height: 12),
        pw.Center(
          child: pw.Column(
            children: [
              pw.Text(
                '✓ Thank you for your order!',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                'This is an electronically generated invoice and is valid without a signature.',
                style: pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
