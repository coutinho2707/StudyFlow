import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/dictionary_service.dart';

void showWordLookupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const _WordLookupDialog(),
  );
}

class _WordLookupDialog extends StatefulWidget {
  const _WordLookupDialog();

  @override
  State<_WordLookupDialog> createState() => _WordLookupDialogState();
}

class _WordLookupDialogState extends State<_WordLookupDialog> {
  final _controller = TextEditingController();
  bool _isSearching = false;
  String? _error;
  WordDefinition? _result;

  Future<void> _search() async {
    final word = _controller.text.trim();
    if (word.isEmpty) return;

    setState(() {
      _isSearching = true;
      _error = null;
      _result = null;
    });

    try {
      final result = await DictionaryService.lookupWord(word);
      setState(() {
        if (result == null) {
          _error = "Palavra não encontrada no dicionário";
        } else {
          _result = result;
        }
      });
    } catch (_) {
      setState(() {
        _error = "Erro ao buscar definição. Verifique sua conexão.";
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.menu_book_rounded, color: AppTheme.accent2, size: 20),
          SizedBox(width: 8),
          Text("Caixa de dúvidas"),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ficou com dúvida sobre uma palavra? Digite abaixo e busque o significado.",
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      decoration: const InputDecoration(labelText: "Palavra"),
                      onSubmitted: (_) => _search(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _isSearching ? null : _search,
                    icon: _isSearching
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              if (_result != null) _buildResult(_result!),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Fechar"),
        ),
      ],
    );
  }

  Widget _buildResult(WordDefinition result) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                result.word,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              if (result.phonetic != null && result.phonetic!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  result.phonetic!,
                  style: const TextStyle(fontSize: 12, color: AppTheme.textTertiary),
                ),
              ],
              if (result.language == 'en') ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGlow,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    "via inglês",
                    style: TextStyle(
                      fontSize: 9,
                      color: AppTheme.accent2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          ...result.meanings.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.partOfSpeech,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accent2,
                    ),
                  ),
                  ...m.definitions.take(3).map(
                        (d) => Padding(
                          padding: const EdgeInsets.only(left: 4, top: 2),
                          child: Text(
                            "• $d",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
