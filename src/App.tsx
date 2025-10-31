import { useState, useEffect } from 'react';
import { VoteProcess } from './types/vote.types';
import { useAuth } from './hooks/useAuth';
import { useVoteProcesses } from './hooks/useVoteProcesses';
import { Header } from './components/Header';
import { LoginScreen } from './components/LoginScreen';
import { LoadingSpinner } from './components/LoadingSpinner';
import { ErrorDisplay } from './components/ErrorDisplay';
import { EmptyState } from './components/EmptyState';
import { SearchAndFilter } from './components/SearchAndFilter';
import { VoteProcessList } from './components/VoteProcessList';
import { VoteProcessDetail } from './components/VoteProcessDetail';
import { UserProfile } from './components/UserProfile';
import { VotingHistory } from './components/VotingHistory';
import { ApiHealthCheck } from './components/ApiHealthCheck';
import { MockModeNotice } from './components/MockModeNotice';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './components/ui/tabs';
import { Button } from './components/ui/button';
import { Toaster } from './components/ui/sonner';
import { ArrowLeft, Vote, Inbox } from 'lucide-react';
import { toast } from 'sonner@2.0.3';

type View = 'home' | 'profile';

export default function App() {
  const { user, loading: authLoading, error: authError, signInWithGoogle, signOut } = useAuth();
  const [currentView, setCurrentView] = useState<View>('home');
  const [selectedProcess, setSelectedProcess] = useState<VoteProcess | null>(null);
  const [search, setSearch] = useState('');
  const [statusFilter, setStatusFilter] = useState('');

  const {
    data,
    loadingState,
    error,
    loadMore,
    resetPage,
    retry,
    hasMore,
    isEmpty,
  } = useVoteProcesses({
    search,
    status: statusFilter === 'all' ? '' : statusFilter,
  });

  // Reset page when search or filter changes
  useEffect(() => {
    resetPage();
  }, [search, statusFilter, resetPage]);

  const handleSignOut = async () => {
    try {
      await signOut();
      setCurrentView('home');
      setSelectedProcess(null);
      toast.success('Sesión cerrada exitosamente');
    } catch (error) {
      toast.error('Error al cerrar sesión');
    }
  };

  const handleVoteSuccess = () => {
    setSelectedProcess(null);
    resetPage();
  };

  // Show loading screen while checking auth state
  if (authLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <LoadingSpinner message="Cargando..." />
      </div>
    );
  }

  // Show login screen if not authenticated (only for voting, browsing is public)
  const showLoginPrompt = !user && currentView === 'profile';

  if (showLoginPrompt) {
    return <LoginScreen onGoogleSignIn={signInWithGoogle} loading={authLoading} error={authError} />;
  }

  return (
    <div className="min-h-screen bg-background">
      <Header
        user={user}
        currentView={currentView}
        onNavigate={setCurrentView}
        onSignOut={handleSignOut}
      />

      <main className="container mx-auto px-4 py-8 max-w-6xl">
        {currentView === 'home' ? (
          <>
            {selectedProcess ? (
              <div>
                <Button
                  variant="ghost"
                  onClick={() => setSelectedProcess(null)}
                  className="mb-6"
                >
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Volver a la lista
                </Button>
                <VoteProcessDetail
                  voteProcess={selectedProcess}
                  isAuthenticated={!!user}
                  onVoteSuccess={handleVoteSuccess}
                />
              </div>
            ) : (
              <div>
                <div className="mb-8">
                  <h1 className="flex items-center gap-2 mb-2">
                    <Vote className="h-6 w-6" />
                    Procesos de Votación
                  </h1>
                  <p className="text-muted-foreground">
                    Explora y participa en procesos de votación activos
                  </p>
                </div>

                <MockModeNotice />

                <SearchAndFilter
                  onSearch={setSearch}
                  onFilterStatus={setStatusFilter}
                  initialSearch={search}
                  initialStatus={statusFilter}
                />

                {loadingState === 'loading' && !data ? (
                  <LoadingSpinner message="Cargando votaciones..." />
                ) : loadingState === 'error' && error ? (
                  <>
                    <ErrorDisplay error={error} onRetry={retry} />
                    {error.type === 'network' && (
                      <div className="mt-6">
                        <ApiHealthCheck />
                      </div>
                    )}
                  </>
                ) : isEmpty ? (
                  <EmptyState
                    icon={Inbox}
                    title="No se encontraron votaciones"
                    description={
                      search || statusFilter
                        ? 'Intenta ajustar los filtros de búsqueda'
                        : 'No hay procesos de votación disponibles en este momento'
                    }
                  />
                ) : (
                  <VoteProcessList
                    processes={data?.content || []}
                    loading={loadingState === 'loading'}
                    hasMore={hasMore}
                    onLoadMore={loadMore}
                    onSelectProcess={setSelectedProcess}
                  />
                )}
              </div>
            )}
          </>
        ) : (
          <div className="max-w-4xl mx-auto">
            {!user ? (
              <LoginScreen onGoogleSignIn={signInWithGoogle} loading={authLoading} error={authError} />
            ) : (
              <Tabs defaultValue="profile" className="w-full">
                <TabsList className="grid w-full grid-cols-2 mb-8">
                  <TabsTrigger value="profile">Perfil</TabsTrigger>
                  <TabsTrigger value="history">Historial</TabsTrigger>
                </TabsList>
                <TabsContent value="profile">
                  <UserProfile user={user} onSignOut={handleSignOut} />
                </TabsContent>
                <TabsContent value="history">
                  <VotingHistory />
                </TabsContent>
              </Tabs>
            )}
          </div>
        )}
      </main>

      <Toaster />
    </div>
  );
}