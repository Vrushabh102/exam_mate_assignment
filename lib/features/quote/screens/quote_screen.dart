import 'package:exam_mate/core/models/quote_model.dart';
import 'package:exam_mate/core/providers/is_loading_state_provider.dart';
import 'package:exam_mate/core/providers/quote__provider.dart';
import 'package:exam_mate/features/quote/controller/quote_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuoteScreen extends ConsumerWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.read(isLoadingProvider);
    QuoteModel? model = ref.watch(quoteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Quote Generator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.tealAccent.shade100.withAlpha(60), Colors.teal.shade200.withAlpha(150)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // quote text box
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(41), blurRadius: 8, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model == null ? 'Quote will appear here...' : "“${model.content}”",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        model == null ? '' : "- ${model.author}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // button for getting new quote
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _fetchQuote(ref, context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                    shadowColor: Theme.of(context).primaryColor.withAlpha(56),
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                          : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'New Quote',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // funtion to and display quote in the ui
  void _fetchQuote(WidgetRef ref, BuildContext context) {
    ref.read(isLoadingProvider.notifier).state = true;
    
    final quoteController = ref.read(quoteControllerProvider);

    // extra 1 sec delay to show loading effect...
    Future.delayed(Duration(seconds: 1));
    ref.read(isLoadingProvider.notifier).state = false;
    quoteController.fetchQuote(context, ref);
  }
}
