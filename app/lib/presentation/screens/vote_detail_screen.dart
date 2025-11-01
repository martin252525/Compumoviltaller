import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/vote_providers.dart';
import '../../domain/providers/auth_providers.dart';
import '../../domain/states/vote_state.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import 'package:intl/intl.dart';

class VoteDetailScreen extends ConsumerStatefulWidget {
  final String voteId;

  const VoteDetailScreen({super.key, required this.voteId});

  @override
  ConsumerState<VoteDetailScreen> createState() => _VoteDetailScreenState();
}

class _VoteDetailScreenState extends ConsumerState<VoteDetailScreen> {
  String? _selectedOptionId;
  bool _isSubmitting = false;

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return Colors.green;
      case 'FINISHED':
        return Colors.grey;
      case 'UPCOMING':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String _getStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return 'Activa';
      case 'FINISHED':
        return 'Finalizada';
      case 'UPCOMING':
        return 'Próxima';
      default:
        return status;
    }
  }

  Future<void> _handleVote() async {
    if (_selectedOptionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una opción'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final authService = ref.read(authServiceProvider);
    final token = await authService.getIdToken();

    if (token == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes iniciar sesión para votar'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repository = ref.read(voteRepositoryProvider);
      await repository.castVote(
        voteId: widget.voteId,
        optionId: _selectedOptionId!,
        token: token,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Voto registrado exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );

      // Refrescar datos
      ref.read(voteDetailProvider(widget.voteId).notifier).refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al votar: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final voteDetailState = ref.watch(voteDetailProvider(widget.voteId));
    final user = ref.watch(currentUserProvider);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Votación'),
      ),
      body: voteDetailState.when(
        initial: () => const Center(child: Text('Cargando...')),
        loading: () => const LoadingIndicator(message: 'Cargando votación...'),
        loaded: (vote) {
          final statusColor = _getStatusColor(vote.status);
          final isActive = vote.status.toUpperCase() == 'ACTIVE';
          final totalVotes =
              vote.options.fold<int>(0, (sum, option) => sum + option.votes);

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(voteDetailProvider(widget.voteId).notifier)
                  .refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Estado
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getStatusText(vote.status),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Título
                  Text(
                    vote.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descripción',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            vote.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Información de fechas
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Fecha de inicio'),
                            subtitle: Text(dateFormat.format(vote.startDate)),
                            contentPadding: EdgeInsets.zero,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.event),
                            title: const Text('Fecha de finalización'),
                            subtitle: Text(dateFormat.format(vote.endDate)),
                            contentPadding: EdgeInsets.zero,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.how_to_vote),
                            title: const Text('Total de votos'),
                            subtitle: Text('$totalVotes votos registrados'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Opciones de votación
                  Text(
                    'Opciones',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),

                  ...vote.options.map((option) {
                    final percentage = totalVotes > 0
                        ? (option.votes / totalVotes * 100)
                        : 0.0;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: isActive && user.value != null
                            ? () {
                                setState(() {
                                  _selectedOptionId = option.id;
                                });
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (isActive && user.value != null)
                                    Radio<String>(
                                      value: option.id,
                                      groupValue: _selectedOptionId,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedOptionId = value;
                                        });
                                      },
                                    ),
                                  Expanded(
                                    child: Text(
                                      option.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    '${option.votes} votos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              if (option.description != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  option.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: percentage / 100,
                                  minHeight: 8,
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${percentage.toStringAsFixed(1)}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // Botón para votar
                  if (isActive && user.value != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _handleVote,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Enviar Voto',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ] else if (isActive && user.value == null) ...[
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Inicia sesión para poder votar',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        error: (message) => ErrorView(
          message: message,
          onRetry: () {
            ref.read(voteDetailProvider(widget.voteId).notifier).refresh();
          },
        ),
      ),
    );
  }
}

