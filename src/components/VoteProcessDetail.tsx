// Vote process detail view with voting functionality
import { useState } from 'react';
import { VoteProcess, VoteOption } from '../types/vote.types';
import { Card, CardContent, CardDescription, CardHeader, CardTitle, CardFooter } from './ui/card';
import { Badge } from './ui/badge';
import { Button } from './ui/button';
import { RadioGroup, RadioGroupItem } from './ui/radio-group';
import { Label } from './ui/label';
import { Alert, AlertDescription } from './ui/alert';
import { Calendar, CheckCircle2, Clock, XCircle, FileText, Vote } from 'lucide-react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import { apiService } from '../services/api.service';
import { LoadingSpinner } from './LoadingSpinner';
import { toast } from 'sonner';

interface VoteProcessDetailProps {
  voteProcess: VoteProcess;
  isAuthenticated: boolean;
  onVoteSuccess?: () => void;
}

export function VoteProcessDetail({ voteProcess, isAuthenticated, onVoteSuccess }: VoteProcessDetailProps) {
  const [selectedOption, setSelectedOption] = useState<string>('');
  const [isVoting, setIsVoting] = useState(false);
  const [hasVoted, setHasVoted] = useState(false);

  const getStatusBadge = (status: VoteProcess['status']) => {
    const variants = {
      DRAFT: { variant: 'secondary' as const, label: 'Borrador', icon: FileText },
      ACTIVE: { variant: 'default' as const, label: 'Activo', icon: Clock },
      CLOSED: { variant: 'outline' as const, label: 'Cerrado', icon: CheckCircle2 },
      CANCELLED: { variant: 'destructive' as const, label: 'Cancelado', icon: XCircle },
    };

    const config = variants[status];
    
    // Safety check: if status is not recognized, use a default
    if (!config) {
      console.warn(`Unknown vote process status: ${status}`);
      const Icon = Clock;
      return (
        <Badge variant="secondary" className="flex items-center gap-1 w-fit">
          <Icon className="h-3 w-3" />
          {status}
        </Badge>
      );
    }
    
    const Icon = config.icon;

    return (
      <Badge variant={config.variant} className="flex items-center gap-1 w-fit">
        <Icon className="h-3 w-3" />
        {config.label}
      </Badge>
    );
  };

  const formatDate = (dateString: string) => {
    try {
      return format(new Date(dateString), "dd 'de' MMMM 'de' yyyy, HH:mm", { locale: es });
    } catch {
      return dateString;
    }
  };

  const canVote = () => {
    return isAuthenticated && voteProcess.status === 'ACTIVE' && !hasVoted;
  };

  const handleVote = async () => {
    if (!selectedOption) {
      toast.error('Por favor selecciona una opción');
      return;
    }

    setIsVoting(true);

    try {
      await apiService.submitVote({
        voteProcessId: voteProcess.id,
        optionId: selectedOption,
      });

      setHasVoted(true);
      toast.success('¡Voto registrado exitosamente!');
      onVoteSuccess?.();
    } catch (error: any) {
      toast.error(error.message || 'Error al registrar el voto');
    } finally {
      setIsVoting(false);
    }
  };

  const getTotalVotes = () => {
    return voteProcess.options.reduce((sum, option) => sum + option.votes, 0);
  };

  const getVotePercentage = (option: VoteOption) => {
    const total = getTotalVotes();
    if (total === 0) return 0;
    return Math.round((option.votes / total) * 100);
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <div className="flex items-start justify-between gap-2">
            <CardTitle>{voteProcess.title}</CardTitle>
            {getStatusBadge(voteProcess.status)}
          </div>
          <CardDescription>{voteProcess.description}</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
            <div>
              <div className="flex items-center gap-2 text-muted-foreground mb-1">
                <Calendar className="h-4 w-4" />
                <span>Inicio</span>
              </div>
              <p>{formatDate(voteProcess.startDate)}</p>
            </div>
            <div>
              <div className="flex items-center gap-2 text-muted-foreground mb-1">
                <Calendar className="h-4 w-4" />
                <span>Fin</span>
              </div>
              <p>{formatDate(voteProcess.endDate)}</p>
            </div>
          </div>

          {!isAuthenticated && voteProcess.status === 'ACTIVE' && (
            <Alert>
              <AlertDescription>
                Debes iniciar sesión para poder votar en este proceso.
              </AlertDescription>
            </Alert>
          )}

          {hasVoted && (
            <Alert>
              <CheckCircle2 className="h-4 w-4" />
              <AlertDescription>
                Ya has votado en este proceso. ¡Gracias por participar!
              </AlertDescription>
            </Alert>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Vote className="h-5 w-5" />
            Opciones de Votación
          </CardTitle>
        </CardHeader>
        <CardContent>
          {canVote() ? (
            <RadioGroup value={selectedOption} onValueChange={setSelectedOption}>
              <div className="space-y-3">
                {voteProcess.options.map((option) => (
                  <div key={option.id} className="flex items-center space-x-3 p-3 border rounded-lg hover:bg-muted/50 transition-colors">
                    <RadioGroupItem value={option.id} id={option.id} />
                    <Label htmlFor={option.id} className="flex-1 cursor-pointer">
                      {option.optionText}
                    </Label>
                  </div>
                ))}
              </div>
            </RadioGroup>
          ) : (
            <div className="space-y-3">
              {voteProcess.options.map((option) => (
                <div key={option.id} className="p-4 border rounded-lg">
                  <div className="flex items-center justify-between mb-2">
                    <span>{option.optionText}</span>
                    <span className="text-muted-foreground">
                      {option.votes} {option.votes === 1 ? 'voto' : 'votos'} ({getVotePercentage(option)}%)
                    </span>
                  </div>
                  <div className="w-full bg-muted rounded-full h-2">
                    <div
                      className="bg-primary h-2 rounded-full transition-all"
                      style={{ width: `${getVotePercentage(option)}%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
        {canVote() && (
          <CardFooter>
            <Button
              onClick={handleVote}
              disabled={!selectedOption || isVoting}
              className="w-full"
            >
              {isVoting ? (
                <>
                  <LoadingSpinner size="sm" />
                  <span className="ml-2">Enviando voto...</span>
                </>
              ) : (
                'Confirmar Voto'
              )}
            </Button>
          </CardFooter>
        )}
      </Card>
    </div>
  );
}