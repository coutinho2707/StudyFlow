import 'dart:convert';
import 'package:http/http.dart' as http;

class WordMeaning {
  final String partOfSpeech;
  final List<String> definitions;

  WordMeaning({
    required this.partOfSpeech,
    required this.definitions,
  });
}

class WordDefinition {
  final String word;
  final String? phonetic;
  final List<WordMeaning> meanings;
  final String language;

  WordDefinition({
    required this.word,
    required this.meanings,
    required this.language,
    this.phonetic,
  });

  String toDescriptionText() {
    final buffer = StringBuffer();

    if (phonetic != null && phonetic!.isNotEmpty) {
      buffer.writeln('[$phonetic]');
      buffer.writeln();
    }

    for (final meaning in meanings) {
      buffer.writeln('${meaning.partOfSpeech}:');

      for (final definition in meaning.definitions) {
        buffer.writeln('• $definition');
      }

      buffer.writeln();
    }

    return buffer.toString().trim();
  }
}

class DictionaryService {
  static Future<WordDefinition?> lookupWord(String word) async {
    final trimmed = word.trim();

    if (trimmed.isEmpty) {
      return null;
    }

    try {
      return await _fetchFromWikipedia(trimmed);
    } catch (e) {
      print('Erro ao consultar definição: $e');
      return null;
    }
  }

  static Future<WordDefinition?> _fetchFromWikipedia(
      String word,
      ) async {
    final uri = Uri.parse(
      'https://pt.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(word)}',
    );

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> data =
    jsonDecode(response.body) as Map<String, dynamic>;

    final extract = data['extract']?.toString();

    if (extract == null || extract.trim().isEmpty) {
      return null;
    }

    return WordDefinition(
      word: data['title']?.toString() ?? word,
      phonetic: null,
      language: 'pt',
      meanings: [
        WordMeaning(
          partOfSpeech: 'Descrição',
          definitions: [extract],
        ),
      ],
    );
  }
}