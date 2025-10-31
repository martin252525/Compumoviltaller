// Vote process card component for list view
import { VoteProcess } from '../types/vote.types';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Badge } from './ui/badge';
import { Calendar, CheckCircle2, Clock, XCircle, FileText } from 'lucide-react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

interface VoteProcessCardProps {
  voteProcess: VoteProcess;
  onClick: () => void;
}

export function VoteProcessCard({ voteProcess, onClick }: VoteProcessCardProps) {
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
      return format(new Date(dateString), 'dd MMM yyyy', { locale: es });
    } catch {
      return dateString;
    }
  };

  return (
    <Card 
      className="cursor-pointer hover:shadow-lg transition-shadow"
      onClick={onClick}
    >
      <CardHeader>
        <div className="flex items-start justify-between gap-2">
          <CardTitle className="line-clamp-2">{voteProcess.title}</CardTitle>
          {getStatusBadge(voteProcess.status)}
        </div>
        <CardDescription className="line-clamp-2">
          {voteProcess.description}
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div className="flex flex-wrap gap-4 text-sm text-muted-foreground">
          <div className="flex items-center gap-1">
            <Calendar className="h-4 w-4" />
            <span>{formatDate(voteProcess.startDate)}</span>
          </div>
          <div className="flex items-center gap-1">
            <span>-</span>
            <span>{formatDate(voteProcess.endDate)}</span>
          </div>
          {voteProcess.totalVotes !== undefined && (
            <div className="ml-auto">
              {voteProcess.totalVotes} {voteProcess.totalVotes === 1 ? 'voto' : 'votos'}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}