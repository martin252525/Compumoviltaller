// Vote process list component with infinite scroll
import { useEffect, useRef, useCallback } from 'react';
import { VoteProcess } from '../types/vote.types';
import { VoteProcessCard } from './VoteProcessCard';
import { LoadingSpinner } from './LoadingSpinner';
import { Button } from './ui/button';

interface VoteProcessListProps {
  processes: VoteProcess[];
  loading: boolean;
  hasMore: boolean;
  onLoadMore: () => void;
  onSelectProcess: (process: VoteProcess) => void;
}

export function VoteProcessList({
  processes,
  loading,
  hasMore,
  onLoadMore,
  onSelectProcess,
}: VoteProcessListProps) {
  const observerTarget = useRef<HTMLDivElement>(null);

  const handleObserver = useCallback(
    (entries: IntersectionObserverEntry[]) => {
      const [entry] = entries;
      if (entry.isIntersecting && hasMore && !loading) {
        onLoadMore();
      }
    },
    [hasMore, loading, onLoadMore]
  );

  useEffect(() => {
    const element = observerTarget.current;
    if (!element) return;

    const observer = new IntersectionObserver(handleObserver, {
      threshold: 0.1,
    });

    observer.observe(element);

    return () => {
      if (element) {
        observer.unobserve(element);
      }
    };
  }, [handleObserver]);

  return (
    <div className="space-y-4">
      {processes.map((process) => (
        <VoteProcessCard
          key={process.id}
          voteProcess={process}
          onClick={() => onSelectProcess(process)}
        />
      ))}

      {/* Infinite scroll trigger */}
      <div ref={observerTarget} className="h-4" />

      {loading && <LoadingSpinner message="Cargando más votaciones..." />}

      {!loading && hasMore && (
        <div className="flex justify-center pt-4">
          <Button variant="outline" onClick={onLoadMore}>
            Cargar más
          </Button>
        </div>
      )}
    </div>
  );
}
