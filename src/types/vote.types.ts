// Domain types based on OpenAPI specification

export interface VoteProcess {
  id: string;
  title: string;
  description: string;
  startDate: string;
  endDate: string;
  status: 'DRAFT' | 'ACTIVE' | 'CLOSED' | 'CANCELLED';
  createdAt: string;
  updatedAt: string;
  options: VoteOption[];
  totalVotes?: number;
}

export interface VoteOption {
  id: string;
  voteProcessId: string;
  optionText: string;
  votes: number;
  createdAt: string;
}

export interface VoteRequest {
  voteProcessId: string;
  optionId: string;
}

export interface VoteResponse {
  id: string;
  userId: string;
  voteProcessId: string;
  optionId: string;
  votedAt: string;
}

export interface UserVote {
  id: string;
  voteProcess: VoteProcess;
  selectedOption: VoteOption;
  votedAt: string;
}

export interface PaginatedResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
}

export interface ApiError {
  message: string;
  status: number;
  timestamp: string;
  path?: string;
}

export type LoadingState = 'idle' | 'loading' | 'success' | 'error';

export interface ErrorState {
  type: 'network' | 'client' | 'server' | 'timeout' | 'business';
  message: string;
  code?: number;
  canRetry: boolean;
}
