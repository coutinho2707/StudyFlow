import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppTheme.accent, Color(0xFFB48BFF)],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          fontFamily: 'DMSerifDisplay',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Gabriel Couto',
                    style: TextStyle(
                      fontFamily: 'DMSerifDisplay',
                      fontSize: 22,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Estudante · Turma 2025',
                    style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: const [
                      _Badge(label: 'Flutter Dev', type: 'purple'),
                      _Badge(label: 'Sequência de 7 dias', type: 'green'),
                      _Badge(label: 'Top 10%', type: 'amber'),
                    ],
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildListDelegate([
                  _StatBox(value: '20h', label: 'Horas totais'),
                    _StatBox(value: '5', label: 'Matérias'),
                  _StatBox(value: '12', label: 'Concluídas'),
                  _StatBox(value: '7 🔥', label: 'Sequência', valueColor: AppTheme.amber),
                ]),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: const Text(
                  'Matérias ativas',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textSecondary),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _SubjectRow(color: AppTheme.accent, name: 'Flutter & Dart', sub: '6h estudadas esta semana', pct: '78%'),
                  _SubjectRow(color: AppTheme.amber, name: 'Matemática', sub: '3h estudadas esta semana', pct: '45%'),
                  _SubjectRow(color: AppTheme.green, name: 'Inglês', sub: '2h estudadas esta semana', pct: '60%'),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final String type;

  const _Badge({required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg, fg, border;
    switch (type) {
      case 'green':
        bg = AppTheme.greenDim;
        fg = AppTheme.green;
        border = AppTheme.green.withOpacity(0.25);
        break;
      case 'amber':
        bg = AppTheme.amber.withOpacity(0.1);
        fg = AppTheme.amber;
        border = AppTheme.amber.withOpacity(0.25);
        break;
      default:
        bg = AppTheme.accentGlow;
        fg = AppTheme.accent2;
        border = AppTheme.accent.withOpacity(0.25);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: border),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: fg)),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const _StatBox({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppTheme.textPrimary,
              )),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textTertiary,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class _SubjectRow extends StatelessWidget {
  final Color color;
  final String name;
  final String sub;
  final String pct;

  const _SubjectRow({required this.color, required this.name, required this.sub, required this.pct});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
                const SizedBox(height: 2),
                Text(sub, style: const TextStyle(fontSize: 11, color: AppTheme.textTertiary)),
              ],
            ),
          ),
          Text(pct, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
