// Mock API Service - Datos de prueba para desarrollo
import { 
  VoteProcess, 
  VoteRequest, 
  VoteResponse, 
  PaginatedResponse,
  UserVote,
  ErrorState
} from '../types/vote.types';

// Datos de ejemplo de procesos de votación
const mockVoteProcesses: VoteProcess[] = [
  {
    id: '1',
    title: 'Elección de Delegado de Curso 2025',
    description: 'Votación para elegir al representante del curso de Ingeniería de Software. El delegado será el enlace entre los estudiantes y la dirección del programa.',
    startDate: '2025-10-15T00:00:00Z',
    endDate: '2025-11-15T23:59:59Z',
    status: 'ACTIVE',
    createdAt: '2025-10-01T00:00:00Z',
    updatedAt: '2025-10-01T00:00:00Z',
    options: [
      {
        id: '1',
        voteProcessId: '1',
        optionText: 'María González - Lista A',
        votes: 45,
        createdAt: '2025-10-01T00:00:00Z',
      },
      {
        id: '2',
        voteProcessId: '1',
        optionText: 'Pedro Martínez - Lista B',
        votes: 38,
        createdAt: '2025-10-01T00:00:00Z',
      },
      {
        id: '3',
        voteProcessId: '1',
        optionText: 'Ana Silva - Independiente',
        votes: 27,
        createdAt: '2025-10-01T00:00:00Z',
      },
    ],
  },
  {
    id: '2',
    title: 'Mejora de Espacios Comunes',
    description: 'Decide qué área del campus debe ser renovada primero con el presupuesto estudiantil 2025.',
    startDate: '2025-10-01T00:00:00Z',
    endDate: '2025-10-30T23:59:59Z',
    status: 'ACTIVE',
    createdAt: '2025-09-25T00:00:00Z',
    updatedAt: '2025-09-25T00:00:00Z',
    options: [
      {
        id: '4',
        voteProcessId: '2',
        optionText: 'Biblioteca (más enchufes y mejor WiFi)',
        votes: 89,
        createdAt: '2025-09-25T00:00:00Z',
      },
      {
        id: '5',
        voteProcessId: '2',
        optionText: 'Cafetería (más mesas y microondas)',
        votes: 67,
        createdAt: '2025-09-25T00:00:00Z',
      },
      {
        id: '6',
        voteProcessId: '2',
        optionText: 'Zona de estudio exterior (techado)',
        votes: 54,
        createdAt: '2025-09-25T00:00:00Z',
      },
    ],
  },
  {
    id: '3',
    title: 'Horario de Exámenes Finales',
    description: 'Vota por el formato preferido para los exámenes finales del semestre.',
    startDate: '2025-09-01T00:00:00Z',
    endDate: '2025-09-30T23:59:59Z',
    status: 'CLOSED', // Changed from 'FINISHED' to 'CLOSED'
    createdAt: '2025-08-20T00:00:00Z',
    updatedAt: '2025-09-30T23:59:59Z',
    options: [
      {
        id: '7',
        voteProcessId: '3',
        optionText: 'Una semana concentrada',
        votes: 120,
        createdAt: '2025-08-20T00:00:00Z',
      },
      {
        id: '8',
        voteProcessId: '3',
        optionText: 'Dos semanas distribuidas',
        votes: 95,
        createdAt: '2025-08-20T00:00:00Z',
      },
    ],
  },
  {
    id: '4',
    title: 'Actividades Extracurriculares 2026',
    description: 'Selecciona qué talleres y actividades te gustaría que se ofrecieran el próximo año.',
    startDate: '2025-11-01T00:00:00Z',
    endDate: '2025-11-30T23:59:59Z',
    status: 'DRAFT', // Changed from 'PENDING' to 'DRAFT'
    createdAt: '2025-10-20T00:00:00Z',
    updatedAt: '2025-10-20T00:00:00Z',
    options: [
      {
        id: '9',
        voteProcessId: '4',
        optionText: 'Taller de Desarrollo Mobile',
        votes: 0,
        createdAt: '2025-10-20T00:00:00Z',
      },
      {
        id: '10',
        voteProcessId: '4',
        optionText: 'Club de Ciberseguridad',
        votes: 0,
        createdAt: '2025-10-20T00:00:00Z',
      },
      {
        id: '11',
        voteProcessId: '4',
        optionText: 'Equipo de Programación Competitiva',
        votes: 0,
        createdAt: '2025-10-20T00:00:00Z',
      },
      {
        id: '12',
        voteProcessId: '4',
        optionText: 'Grupo A',
        votes: 0,
        createdAt: '2025-10-20T00:00:00Z',
      },
    ],
  },
  {
    id: '5',
    title: 'Elección de Tema para Hackathon',
    description: 'Vota por el tema principal del hackathon universitario 2025.',
    startDate: '2025-10-20T00:00:00Z',
    endDate: '2025-11-05T23:59:59Z',
    status: 'ACTIVE',
    createdAt: '2025-10-15T00:00:00Z',
    updatedAt: '2025-10-15T00:00:00Z',
    options: [
      {
        id: '13',
        voteProcessId: '5',
        optionText: 'Sostenibilidad y Medio Ambiente',
        votes: 23,
        createdAt: '2025-10-15T00:00:00Z',
      },
      {
        id: '14',
        voteProcessId: '5',
        optionText: 'Educación y Tecnología',
        votes: 31,
        createdAt: '2025-10-15T00:00:00Z',
      },
      {
        id: '15',
        voteProcessId: '5',
        optionText: 'Salud y Bienestar',
        votes: 19,
        createdAt: '2025-10-15T00:00:00Z',
      },
    ],
  },
];

// Datos de ejemplo de votos del usuario
const mockUserVotes: UserVote[] = [
  {
    id: 'uv1',
    userId: 'mock-user-id',
    voteProcessId: '3',
    voteProcessTitle: 'Horario de Exámenes Finales',
    optionId: '7',
    optionText: 'Una semana concentrada',
    votedAt: '2025-09-28T14:30:00Z',
  },
];

// Simular delay de red para hacer más realista
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

class MockApiService {
  private userVotes: UserVote[] = [...mockUserVotes];

  async getVoteProcesses(
    page: number = 0,
    size: number = 10,
    search?: string,
    status?: string
  ): Promise<PaginatedResponse<VoteProcess>> {
    await delay(300); // Simular latencia de red

    console.log('[Mock API] Getting vote processes:', { page, size, search, status });

    let filtered = [...mockVoteProcesses];

    // Filtrar por búsqueda
    if (search) {
      const searchLower = search.toLowerCase();
      filtered = filtered.filter(vp => 
        vp.title.toLowerCase().includes(searchLower) ||
        vp.description.toLowerCase().includes(searchLower)
      );
    }

    // Filtrar por estado
    if (status && status !== 'ALL') {
      filtered = filtered.filter(vp => vp.status === status);
    }

    // Paginación
    const start = page * size;
    const end = start + size;
    const paginatedContent = filtered.slice(start, end);

    return {
      content: paginatedContent,
      totalElements: filtered.length,
      totalPages: Math.ceil(filtered.length / size),
      size: size,
      number: page,
      first: page === 0,
      last: end >= filtered.length,
    };
  }

  async getVoteProcessById(id: string): Promise<VoteProcess> {
    await delay(200);

    console.log('[Mock API] Getting vote process by id:', id);

    const voteProcess = mockVoteProcesses.find(vp => vp.id === id);
    
    if (!voteProcess) {
      throw {
        type: 'client',
        message: 'Proceso de votación no encontrado',
        code: 404,
        canRetry: false,
      } as ErrorState;
    }

    return voteProcess;
  }

  async submitVote(voteRequest: VoteRequest): Promise<VoteResponse> {
    await delay(400);

    console.log('[Mock API] Submitting vote:', voteRequest);

    const voteProcess = mockVoteProcesses.find(vp => vp.id === voteRequest.voteProcessId);
    const option = voteProcess?.options.find(opt => opt.id === voteRequest.optionId);

    if (!voteProcess || !option) {
      throw {
        type: 'client',
        message: 'Proceso de votación u opción no encontrada',
        code: 404,
        canRetry: false,
      } as ErrorState;
    }

    if (voteProcess.status !== 'ACTIVE') {
      throw {
        type: 'business',
        message: 'Este proceso de votación no está activo',
        code: 400,
        canRetry: false,
      } as ErrorState;
    }

    // Verificar si ya votó
    const existingVote = this.userVotes.find(v => v.voteProcessId === voteRequest.voteProcessId);
    if (existingVote) {
      throw {
        type: 'business',
        message: 'Ya has votado en este proceso',
        code: 400,
        canRetry: false,
      } as ErrorState;
    }

    // Incrementar votos
    option.votes += 1;

    // Crear registro de voto
    const userVote: UserVote = {
      id: `uv${Date.now()}`,
      userId: 'mock-user-id',
      voteProcessId: voteRequest.voteProcessId,
      voteProcessTitle: voteProcess.title,
      optionId: voteRequest.optionId,
      optionText: option.optionText,
      votedAt: new Date().toISOString(),
    };

    this.userVotes.push(userVote);

    return {
      id: userVote.id,
      voteProcessId: voteRequest.voteProcessId,
      optionId: voteRequest.optionId,
      userId: 'mock-user-id',
      votedAt: userVote.votedAt,
      confirmed: true,
    };
  }

  async getUserVotes(page: number = 0, size: number = 10): Promise<PaginatedResponse<UserVote>> {
    await delay(250);

    console.log('[Mock API] Getting user votes:', { page, size });

    const start = page * size;
    const end = start + size;
    const paginatedContent = this.userVotes.slice(start, end);

    return {
      content: paginatedContent,
      totalElements: this.userVotes.length,
      totalPages: Math.ceil(this.userVotes.length / size),
      size: size,
      number: page,
      first: page === 0,
      last: end >= this.userVotes.length,
    };
  }

  async checkUserVote(voteProcessId: string): Promise<VoteResponse | null> {
    await delay(150);

    console.log('[Mock API] Checking user vote for process:', voteProcessId);

    const userVote = this.userVotes.find(v => v.voteProcessId === voteProcessId);

    if (!userVote) {
      return null;
    }

    return {
      id: userVote.id,
      voteProcessId: userVote.voteProcessId,
      optionId: userVote.optionId,
      userId: 'mock-user-id',
      votedAt: userVote.votedAt,
      confirmed: true,
    };
  }
}

export const mockApiService = new MockApiService();