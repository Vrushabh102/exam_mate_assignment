import 'dart:convert';
import 'dart:developer';
import 'package:exam_mate/core/errors/failure.dart';
import 'package:exam_mate/core/errors/type_defs.dart';
import 'package:exam_mate/core/models/quote_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  return QuoteRepository();
});

class QuoteRepository {
  FutureEither<QuoteModel> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // returning quote model if successfully api call is successfull
        return right(QuoteModel.fromJson(data));
      } else {
        return left(Failure('Server error: ${response.statusCode}'));
      }
    } catch (e) {
      log(e.toString());
      return left(Failure('Network error: $e'));
    }
  }
}
