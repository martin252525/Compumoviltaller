// Custom hook for vote processes data management
import { useState, useEffect, useCallback } from 'react';
import { VoteProcess, PaginatedResponse, LoadingState, ErrorState } from '../types/vote.types';
import { apiService } from '../services/api.service';

interface UseVoteProcessesOptions {
  page?: number;
  size?: number;
  search?: string;
  status?: string;
  autoFetch?: boolean;
}

export function useVoteProcesses(options: UseVoteProcessesOptions = {}) {
  const {
    page: initialPage = 0,
    size = 10,
    search = '',
    status = '',
    autoFetch = true
  } = options;

  const [data, setData] = useState<PaginatedResponse<VoteProcess> | null>(null);
  const [loadingState, setLoadingState] = useState<LoadingState>('idle');
  const [error, setError] = useState<ErrorState | null>(null);
  const [page, setPage] = useState(initialPage);

  const fetchVoteProcesses = useCallback(async () => {
    try {
      setLoadingState('loading');
      setError(null);
      
      const result = await apiService.getVoteProcesses(page, size, search || undefined, status || undefined);
      
      setData(result);
      setLoadingState('success');
    } catch (err: any) {
      setError(err);
      setLoadingState('error');
    }
  }, [page, size, search, status]);

  useEffect(() => {
    if (autoFetch) {
      fetchVoteProcesses();
    }
  }, [fetchVoteProcesses, autoFetch]);

  const loadMore = useCallback(() => {
    if (data && !data.last) {
  setPage((prev: number) => prev + 1);
    }
  }, [data]);

  const resetPage = useCallback(() => {
    setPage(0);
  }, []);

  const retry = useCallback(() => {
    fetchVoteProcesses();
  }, [fetchVoteProcesses]);

  return {
    data,
    loadingState,
    error,
    fetchVoteProcesses,
    loadMore,
    resetPage,
    retry,
    hasMore: data ? !data.last : false,
    isEmpty: data ? data.content.length === 0 : false,
  };
}
