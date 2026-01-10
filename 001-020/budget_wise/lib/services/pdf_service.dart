import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/transaction.dart';
import '../utils/helpers.dart';

class PdfService {
  static Future<void> generateMonthlyReport({
    required DateTime month,
    required List<Transaction> transactions,
    required double totalIncome,
    required double totalExpense,
    required double balance,
    required Map<String, double> expensesByCategory,
  }) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Laporan Bulanan BudgetWise',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Periode: ${Helpers.formatMonth(month)}',
            style: const pw.TextStyle(fontSize: 16),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Ringkasan Keuangan',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                _buildSummaryRow('Total Pemasukan', totalIncome, PdfColors.green),
                _buildSummaryRow('Total Pengeluaran', totalExpense, PdfColors.red),
                pw.Divider(),
                _buildSummaryRow('Saldo', balance, PdfColors.blue),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Pengeluaran Per Kategori',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          ...expensesByCategory.entries.map((entry) => 
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(entry.key),
                  pw.Text(
                    Helpers.formatCurrency(entry.value),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Rincian Transaksi',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildTableCell('Tanggal', isHeader: true),
                  _buildTableCell('Deskripsi', isHeader: true),
                  _buildTableCell('Tipe', isHeader: true),
                  _buildTableCell('Jumlah', isHeader: true),
                ],
              ),
              ...transactions.map((t) => pw.TableRow(
                children: [
                  _buildTableCell(Helpers.formatDate(t.date)),
                  _buildTableCell(t.title),
                  _buildTableCell(t.type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'),
                  _buildTableCell(Helpers.formatCurrency(t.amount)),
                ],
              )),
            ],
          ),
        ],
      ),
    );
    
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
  
  static pw.Widget _buildSummaryRow(String label, double amount, PdfColor color) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label),
          pw.Text(
            Helpers.formatCurrency(amount),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  static pw.Widget _buildTableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}