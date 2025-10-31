// Custom hook for single vote process details
import { useState, useEffect, useCallback } from 'react';
import { VoteProcess, LoadingState, ErrorState } from '../types/vote.types';
import { apiService } from '../services/api.service';

export function useVoteProcess(id: string | null) {
  const [data, setData] = useState<VoteProcess | null>(null);
  const [loadingState, setLoadingState] = useState<LoadingState>('idle');
  const [error, setError] = useState<ErrorState | null>(null);

  const fetchVoteProcess = useCallback(async () => {
    if (!id) return;

    try {
      setLoadingState('loading');
      setError(null);
      
      const result = await apiService.getVoteProcessById(id);
      
      setData(result);
      setLoadingState('success');
    } catch (err: any) {
      setError(err);
      setLoadingState('error');
    }
  }, [id]);

  useEffect(() => {
    if (id) {
      fetchVoteProcess();
    }
  }, [fetchVoteProcess, id]);

  const retry = useCallback(() => {
    fetchVoteProcess();
  }, [fetchVoteProcess]);

  return {
    data,
    loadingState,
    error,
    retry,
  };
}
