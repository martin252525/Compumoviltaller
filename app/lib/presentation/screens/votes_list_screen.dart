import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../domain/providers/vote_providers.dart';
import '../../domain/states/vote_state.dart';
import '../widgets/vote_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_view.dart';
import 'vote_detail_screen.dart';
import 'profile_screen.dart';
import '../../screens/login_screen.dart';

class VotesListScreen extends ConsumerStatefulWidget {
  const VotesListScreen({super.key});

  @override
  ConsumerState<VotesListScreen> createState() => _VotesListScreenState();
}

class _VotesListScreenState extends ConsumerState<VotesListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    // Cargar votaciones iniciales
    Future.microtask(() {
      ref.read(voteListProvider.notifier).loadVotes();
    });

    // Configurar infinite scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(voteListProvider.notifier).loadMore();
    }
  }

  void _onSearch(String query) {
    ref.read(voteListProvider.notifier).loadVotes(
          search: query.isEmpty ? null : query,
          status: _selectedStatus,
        );
  }

  void _onFilterChanged(String? status) {
    setState(() {
      _selectedStatus = status;
    });
    ref.read(voteListProvider.notifier).loadVotes(
          search: _searchController.text.isEmpty ? null : _searchController.text,
          status: status,
        );
  }

  @override
  Widget build(BuildContext context) {
    final voteListState = ref.watch(voteListProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votaciones'),
        actions: [
          // Botón de perfil o login
          user.when(
            data: (user) {
              if (user != null) {
                return IconButton(
                  icon: CircleAvatar(
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                );
              } else {
                return TextButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Iniciar Sesión'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                );
              }
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda y filtros
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo de búsqueda
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar votaciones...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _onSearch('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: _onSearch,
                ),
                const SizedBox(height: 12),

                // Filtros de estado
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('Todas'),
                        selected: _selectedStatus == null,
                        onSelected: (selected) {
                          if (selected) _onFilterChanged(null);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Activas'),
                        selected: _selectedStatus == 'ACTIVE',
                        onSelected: (selected) {
                          _onFilterChanged(selected ? 'ACTIVE' : null);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Finalizadas'),
                        selected: _selectedStatus == 'FINISHED',
                        onSelected: (selected) {
                          _onFilterChanged(selected ? 'FINISHED' : null);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Próximas'),
                        selected: _selectedStatus == 'UPCOMING',
                        onSelected: (selected) {
                          _onFilterChanged(selected ? 'UPCOMING' : null);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Lista de votaciones
          Expanded(
            child: voteListState.when(
              initial: () => const Center(
                child: Text('Desliza hacia abajo para cargar'),
              ),
              loading: () => const LoadingIndicator(),
              loaded: (votes, hasMore, currentPage) {
                if (votes.isEmpty) {
                  return const EmptyView(
                    message: 'No se encontraron votaciones',
                    icon: Icons.inbox,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(voteListProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: votes.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= votes.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final vote = votes[index];
                      return VoteCard(
                        vote: vote,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  VoteDetailScreen(voteId: vote.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
              error: (message) => ErrorView(
                message: message,
                onRetry: () {
                  ref.read(voteListProvider.notifier).loadVotes();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

