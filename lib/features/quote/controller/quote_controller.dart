import 'package:exam_mate/core/providers/quote__provider.dart';
import 'package:exam_mate/features/quote/repository/quote_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quoteControllerProvider = Provider<QuoteController>((ref) {
  return QuoteController(ref.read(quoteRepositoryProvider));
});

class QuoteController {
  final QuoteRepository repository;

  QuoteController(this.repository);

  fetchQuote(BuildContext context, WidgetRef ref) async {
    final data = await repository.fetchQuote();

    data.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message.toString(), style: TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.teal,
          ),
        );
      },
      (model) {
        ref.read(quoteProvider.notifier).update((state) => model);
      },
    );
  }
}
