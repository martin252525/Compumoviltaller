// Voting history component
import { useUserVotes } from '../hooks/useUserVotes';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Badge } from './ui/badge';
import { LoadingSpinner } from './LoadingSpinner';
import { ErrorDisplay } from './ErrorDisplay';
import { EmptyState } from './EmptyState';
import { Button } from './ui/button';
import { History, Calendar, CheckCircle } from 'lucide-react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

export function VotingHistory() {
  const { data, loadingState, error, loadMore, retry, hasMore, isEmpty } = useUserVotes();

  const formatDate = (dateString: string) => {
    try {
      return format(new Date(dateString), "dd 'de' MMMM 'de' yyyy, HH:mm", { locale: es });
    } catch {
      return dateString;
    }
  };

  if (loadingState === 'loading' && !data) {
    return <LoadingSpinner message="Cargando historial..." />;
  }

  if (loadingState === 'error' && error) {
    return <ErrorDisplay error={error} onRetry={retry} />;
  }

  if (isEmpty) {
    return (
      <EmptyState
        icon={History}
        title="Sin votaciones"
        description="Aún no has participado en ninguna votación."
      />
    );
  }

  return (
    <div className="space-y-4">
      <h2 className="flex items-center gap-2">
        <History className="h-5 w-5" />
        Historial de Votaciones
      </h2>

      {data?.content.map((userVote) => (
        <Card key={userVote.id}>
          <CardHeader>
            <div className="flex items-start justify-between gap-2">
              <CardTitle className="line-clamp-1">{userVote.voteProcessTitle}</CardTitle>
              <Badge variant="outline" className="flex items-center gap-1 shrink-0">
                <CheckCircle className="h-3 w-3" />
                Votado
              </Badge>
            </div>
            <CardDescription className="line-clamp-2">
              {userVote.voteProcessTitle}
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex items-center gap-2 text-sm text-muted-foreground">
              <Calendar className="h-4 w-4" />
              <span>Votado el {formatDate(userVote.votedAt)}</span>
            </div>
            <div className="p-3 bg-muted rounded-lg">
              <p className="text-sm text-muted-foreground mb-1">Tu voto:</p>
              <p>{userVote.optionText}</p>
            </div>
          </CardContent>
        </Card>
      ))}

      {hasMore && (
        <div className="flex justify-center pt-4">
          <Button
            variant="outline"
            onClick={loadMore}
            disabled={loadingState === 'loading'}
          >
            {loadingState === 'loading' ? 'Cargando...' : 'Cargar más'}
          </Button>
        </div>
      )}
    </div>
  );
}
