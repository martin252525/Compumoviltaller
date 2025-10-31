// Error display component with retry functionality
import { AlertCircle, WifiOff, ServerCrash, Clock, AlertTriangle } from 'lucide-react';
import { ErrorState } from '../types/vote.types';
import { Button } from './ui/button';
import { Alert, AlertDescription, AlertTitle } from './ui/alert';

interface ErrorDisplayProps {
  error: ErrorState;
  onRetry?: () => void;
}

export function ErrorDisplay({ error, onRetry }: ErrorDisplayProps) {
  const getErrorIcon = () => {
    switch (error.type) {
      case 'network':
        return <WifiOff className="h-5 w-5" />;
      case 'server':
        return <ServerCrash className="h-5 w-5" />;
      case 'timeout':
        return <Clock className="h-5 w-5" />;
      case 'client':
        return <AlertTriangle className="h-5 w-5" />;
      default:
        return <AlertCircle className="h-5 w-5" />;
    }
  };

  const getErrorTitle = () => {
    switch (error.type) {
      case 'network':
        return 'Error de Conexión';
      case 'server':
        return 'Error del Servidor';
      case 'timeout':
        return 'Tiempo de Espera Agotado';
      case 'client':
        return 'Error de Solicitud';
      default:
        return 'Error';
    }
  };

  const getErrorDescription = () => {
    let description = error.message;
    
    if (error.code) {
      description += ` (Código: ${error.code})`;
    }

    switch (error.type) {
      case 'network':
        description += '\nVerifica tu conexión a internet e intenta nuevamente.';
        break;
      case 'server':
        description += '\nEl servidor está experimentando problemas. Por favor, intenta más tarde.';
        break;
      case 'timeout':
        description += '\nLa solicitud tardó demasiado tiempo. Por favor, intenta nuevamente.';
        break;
    }

    return description;
  };

  return (
    <Alert variant="destructive" className="my-4">
      <div className="flex items-start gap-3">
        {getErrorIcon()}
        <div className="flex-1">
          <AlertTitle>{getErrorTitle()}</AlertTitle>
          <AlertDescription className="mt-2 whitespace-pre-line">
            {getErrorDescription()}
          </AlertDescription>
          {error.canRetry && onRetry && (
            <Button
              variant="outline"
              size="sm"
              onClick={onRetry}
              className="mt-3"
            >
              Reintentar
            </Button>
          )}
        </div>
      </div>
    </Alert>
  );
}
