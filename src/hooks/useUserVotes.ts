// Custom hook for user voting history
import { useState, useEffect, useCallback } from 'react';
import { UserVote, PaginatedResponse, LoadingState, ErrorState } from '../types/vote.types';
import { apiService } from '../services/api.service';

export function useUserVotes() {
  const [data, setData] = useState<PaginatedResponse<UserVote> | null>(null);
  const [loadingState, setLoadingState] = useState<LoadingState>('idle');
  const [error, setError] = useState<ErrorState | null>(null);
  const [page, setPage] = useState(0);

  const fetchUserVotes = useCallback(async () => {
    try {
      setLoadingState('loading');
      setError(null);
      
      const result = await apiService.getUserVotes(page, 10);
      
      setData(result);
      setLoadingState('success');
    } catch (err: any) {
      setError(err);
      setLoadingState('error');
    }
  }, [page]);

  useEffect(() => {
    fetchUserVotes();
  }, [fetchUserVotes]);

  const loadMore = useCallback(() => {
    if (data && !data.last) {
      setPage(prev => prev + 1);
    }
  }, [data]);

  const retry = useCallback(() => {
    fetchUserVotes();
  }, [fetchUserVotes]);

  return {
    data,
    loadingState,
    error,
    loadMore,
    retry,
    hasMore: data ? !data.last : false,
    isEmpty: data ? data.content.length === 0 : false,
  };
}
