// API Service Layer - Consumes https://api.sebastian.cl/vote
import { 
  VoteProcess, 
  VoteRequest, 
  VoteResponse, 
  PaginatedResponse,
  UserVote,
  ApiError,
  ErrorState
} from '../types/vote.types';
import { firebaseService } from './firebase.service';
import { mockApiService } from './mock-api.service';

const API_BASE_URL = 'https://api.sebastian.cl/vote';
const DEFAULT_TIMEOUT = 30000; // 30 seconds - increased timeout

// API Mode management - Start in MOCK mode by default to avoid fetch errors
// Users can switch to real API mode from the UI if needed
let useMockApi = true; // Changed from false to true

export const setApiMode = (useMock: boolean) => {
  useMockApi = useMock;
  console.log(`[API] Switched to ${useMock ? 'MOCK' : 'REAL'} API mode`);
  // Persist the preference
  localStorage.setItem('useMockApi', useMock.toString());
  // Dispatch event for UI updates
  window.dispatchEvent(new CustomEvent('apiModeChanged', { detail: { useMock } }));
};

// Initialize from localStorage if available
const storedMode = localStorage.getItem('useMockApi');
if (storedMode !== null) {
  useMockApi = storedMode === 'true';
}

console.log(`[API] Using API: ${useMockApi ? 'mock' : 'real'}`);

export const isUsingMockApi = () => useMockApi;

class ApiService {
  private async fetchWithTimeout(
    url: string,
    options: RequestInit = {},
    timeout: number = DEFAULT_TIMEOUT
  ): Promise<Response> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
      console.log('[API] Making request to:', url);
      const response = await fetch(url, {
        ...options,
        signal: controller.signal,
      });
      clearTimeout(timeoutId);
      console.log('[API] Response status:', response.status);
      return response;
    } catch (error: any) {
      clearTimeout(timeoutId);
      console.error('[API] Request failed:', error);
      
      if (error.name === 'AbortError') {
        throw this.createError('timeout', 'La solicitud tardó demasiado tiempo. Por favor, verifica tu conexión a internet.', 408);
      }
      
      // Provide more detailed error messages
      if (error.message.includes('Failed to fetch')) {
        throw this.createError('network', 'No se pudo conectar al servidor. Verifica tu conexión a internet o que la API esté disponible.', 0);
      }
      
      throw this.createError('network', `Error de red: ${error.message}`, 0);
    }
  }

  private async getHeaders(requiresAuth: boolean = false): Promise<HeadersInit> {
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
    };

    if (requiresAuth) {
      const token = await firebaseService.getIdToken();
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }
    }

    return headers;
  }

  private createError(type: ErrorState['type'], message: string, code: number): ErrorState {
    return {
      type,
      message,
      code,
      canRetry: type === 'network' || type === 'timeout' || code >= 500,
    };
  }

  private async handleResponse<T>(response: Response): Promise<T> {
    if (!response.ok) {
      let errorMessage = 'An error occurred';
      
      try {
        const errorData: ApiError = await response.json();
        errorMessage = errorData.message || errorMessage;
      } catch {
        errorMessage = response.statusText || errorMessage;
      }

      const status = response.status;
      
      if (status >= 400 && status < 500) {
        throw this.createError('client', errorMessage, status);
      } else if (status >= 500) {
        throw this.createError('server', errorMessage, status);
      }
      
      throw this.createError('business', errorMessage, status);
    }

    return response.json();
  }

  // GET /api/vote-processes - List all vote processes (public)
  async getVoteProcesses(
    page: number = 0,
    size: number = 10,
    search?: string,
    status?: string
  ): Promise<PaginatedResponse<VoteProcess>> {
    if (useMockApi) {
      return mockApiService.getVoteProcesses(page, size, search, status);
    }

    const params = new URLSearchParams({
      page: page.toString(),
      size: size.toString(),
    });

    if (search) params.append('search', search);
    if (status) params.append('status', status);

    const url = `${API_BASE_URL}/api/vote-processes?${params}`;
    const headers = await this.getHeaders(false);
    
    const response = await this.fetchWithTimeout(url, { headers });
    return this.handleResponse<PaginatedResponse<VoteProcess>>(response);
  }

  // GET /api/vote-processes/{id} - Get vote process details (public)
  async getVoteProcessById(id: string): Promise<VoteProcess> {
    if (useMockApi) {
      return mockApiService.getVoteProcessById(id);
    }

    const url = `${API_BASE_URL}/api/vote-processes/${id}`;
    const headers = await this.getHeaders(false);
    
    const response = await this.fetchWithTimeout(url, { headers });
    return this.handleResponse<VoteProcess>(response);
  }

  // POST /api/votes - Submit a vote (requires authentication)
  async submitVote(voteRequest: VoteRequest): Promise<VoteResponse> {
    if (useMockApi) {
      return mockApiService.submitVote(voteRequest);
    }

    const url = `${API_BASE_URL}/api/votes`;
    const headers = await this.getHeaders(true);
    
    const response = await this.fetchWithTimeout(url, {
      method: 'POST',
      headers,
      body: JSON.stringify(voteRequest),
    });
    
    return this.handleResponse<VoteResponse>(response);
  }

  // GET /api/votes/user - Get user's voting history (requires authentication)
  async getUserVotes(page: number = 0, size: number = 10): Promise<PaginatedResponse<UserVote>> {
    if (useMockApi) {
      return mockApiService.getUserVotes(page, size);
    }

    const params = new URLSearchParams({
      page: page.toString(),
      size: size.toString(),
    });

    const url = `${API_BASE_URL}/api/votes/user?${params}`;
    const headers = await this.getHeaders(true);
    
    const response = await this.fetchWithTimeout(url, { headers });
    return this.handleResponse<PaginatedResponse<UserVote>>(response);
  }

  // GET /api/votes/check/{voteProcessId} - Check if user has voted (requires authentication)
  async checkUserVote(voteProcessId: string): Promise<VoteResponse | null> {
    if (useMockApi) {
      return mockApiService.checkUserVote(voteProcessId);
    }

    const url = `${API_BASE_URL}/api/votes/check/${voteProcessId}`;
    const headers = await this.getHeaders(true);
    
    try {
      const response = await this.fetchWithTimeout(url, { headers });
      if (response.status === 204) {
        return null; // User hasn't voted
      }
      return this.handleResponse<VoteResponse>(response);
    } catch (error: any) {
      if (error.code === 404) {
        return null; // User hasn't voted
      }
      throw error;
    }
  }
}

export const apiService = new ApiService();