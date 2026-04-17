import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final barHeights = [30.0, 55.0, 70.0, 40.0, 25.0, 50.0, 15.0];
    final barLabels = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    const activeIndex = 2;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'ANÁLISE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.accent2,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Detalhes',
                      style: TextStyle(
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 28,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Horas estudadas — esta semana',
                        style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(barLabels.length, (i) {
                            final isActive = i == activeIndex;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeOut,
                                      height: barHeights[i],
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        gradient: isActive
                                            ? const LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [AppTheme.accent, AppTheme.accent2],
                                              )
                                            : null,
                                        color: isActive ? null : AppTheme.surface3,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      barLabels[i],
                                      style: const TextStyle(fontSize: 10, color: AppTheme.textTertiary),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: const Text(
                  'Resumo geral',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textSecondary),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _DetailStatRow(icon: '⏱️', name: 'Tempo estudado', sub: 'Esta semana', value: '5h 20m'),
                  _DetailStatRow(icon: '✅', name: 'Tarefas concluídas', sub: 'Total acumulado', value: '12'),
                  _DetailStatRow(icon: '🔥', name: 'Sequência ativa', sub: 'Dias consecutivos', value: '7', valueColor: AppTheme.amber),
                  _DetailStatRow(icon: '📈', name: 'Eficiência', sub: 'Tarefas por hora', value: '2.4', valueColor: AppTheme.green),
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

class _DetailStatRow extends StatelessWidget {
  final String icon;
  final String name;
  final String sub;
  final String value;
  final Color? valueColor;

  const _DetailStatRow({
    required this.icon,
    required this.name,
    required this.sub,
    required this.value,
    this.valueColor,
  });

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
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.accentGlow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
                const SizedBox(height: 1),
                Text(sub, style: const TextStyle(fontSize: 11, color: AppTheme.textTertiary)),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppTheme.accent2,
            ),
          ),
        ],
      ),
    );
  }
}
