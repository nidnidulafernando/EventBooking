import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import '../event_model.dart';

Future<File> generatePdf(Event event) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Padding(
        padding: pw.EdgeInsets.all(20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Booking Confirmation', style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Thank you for booking with us!', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(height: 20),
            pw.Text('Event Details:', style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 14),
            pw.Text('Event: ${event.title}', style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 10),
            pw.Text('Date: ${event.date}', style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 10),
            pw.Text('Location: ${event.location}', style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 10),
            pw.Text('Price: \$${event.price.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 28),
            pw.Text('We look forward to seeing you at the event!', style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 36),
            pw.Text('If you have any questions, please contact us at support@therisevillage.com.', style: pw.TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/booking_confirmation.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}

Future<void> sharePdf(BuildContext context, Event event) async {
  try {
    final file = await generatePdf(event);

    if (!await file.exists()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: PDF file not found')),
      );
      return;
    }

    await Share.shareXFiles(
      // [file.path],
      [XFile(file.path)],
      text: 'Here is your booking confirmation for the event: ${event.title}',
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing PDF: $e')));
    print("error $e");
  }
}