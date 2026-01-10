import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import '../database/app_database.dart';
import '../utils/helpers.dart';

class ExportService {
  // Export to PDF
  Future<String> exportToPDF({
    required List<Transaction> transactions,
    required DateTime month,
    required double totalIncome,
    required double totalExpense,
    required double balance,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          // Header
          pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue300,
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'LAPORAN KEUANGAN',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  Helpers.formatMonthYear(month),
                  style: const pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // Summary
          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300, width: 2),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              children: [
                _buildSummaryRow('Total Pemasukan', totalIncome, PdfColors.green),
                pw.SizedBox(height: 8),
                _buildSummaryRow('Total Pengeluaran', totalExpense, PdfColors.red),
                pw.SizedBox(height: 8),
                pw.Divider(),
                pw.SizedBox(height: 8),
                _buildSummaryRow('Saldo', balance, PdfColors.blue),
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          // Transactions Table
          pw.Text(
            'Detail Transaksi',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              // Header
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildTableCell('Tanggal', isHeader: true),
                  _buildTableCell('Kategori', isHeader: true),
                  _buildTableCell('Keterangan', isHeader: true),
                  _buildTableCell('Nominal', isHeader: true),
                ],
              ),
              // Rows
              ...transactions.map((t) {
                return pw.TableRow(
                  children: [
                    _buildTableCell(Helpers.formatDate(t.date)),
                    _buildTableCell(t.category),
                    _buildTableCell(t.description),
                    _buildTableCell(
                      '${t.type == 'income' ? '+' : '-'} ${Helpers.formatCurrency(t.amount)}',
                      color: t.type == 'income' ? PdfColors.green : PdfColors.red,
                    ),
                  ],
                );
              }),
            ],
          ),

          pw.SizedBox(height: 20),

          // Footer
          pw.Text(
            'Dicetak pada: ${Helpers.formatDate(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
          ),
        ],
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'laporan_${month.year}_${month.month}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  pw.Widget _buildSummaryRow(String label, double amount, PdfColor color) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          Helpers.formatCurrency(amount),
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTableCell(String text, {bool isHeader = false, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color,
        ),
      ),
    );
  }

  // Export to Excel
  Future<String> exportToExcel({
    required List<Transaction> transactions,
    required DateTime month,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Transaksi'];

    // Header
    sheet.appendRow([
      TextCellValue('Tanggal'),
      TextCellValue('Tipe'),
      TextCellValue('Kategori'),
      TextCellValue('Keterangan'),
      TextCellValue('Nominal'),
    ]);

    // Data rows
    for (var transaction in transactions) {
      sheet.appendRow([
        TextCellValue(Helpers.formatDate(transaction.date)),
        TextCellValue(transaction.type == 'income' ? 'Pemasukan' : 'Pengeluaran'),
        TextCellValue(transaction.category),
        TextCellValue(transaction.description),
        DoubleCellValue(transaction.amount),
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'transaksi_${month.year}_${month.month}.xlsx';
    final file = File('${directory.path}/$fileName');
    
    final bytes = excel.encode();
    if (bytes != null) {
      await file.writeAsBytes(bytes);
    }

    return file.path;
  }
}