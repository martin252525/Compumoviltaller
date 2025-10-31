// Login screen component
import { Button } from './ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Vote, LogIn } from 'lucide-react';

interface LoginScreenProps {
  onGoogleSignIn: () => void;
  loading: boolean;
  error?: string | null;
}

export function LoginScreen({ onGoogleSignIn, loading, error }: LoginScreenProps) {
  return (
    <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-primary/10 via-background to-secondary/10">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center space-y-4">
          <div className="mx-auto w-16 h-16 bg-primary rounded-full flex items-center justify-center">
            <Vote className="h-8 w-8 text-primary-foreground" />
          </div>
          <div>
            <CardTitle>Sistema de Votación</CardTitle>
            <CardDescription>
              Inicia sesión para participar en procesos de votación
            </CardDescription>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          {error && (
            <div className="p-3 bg-destructive/10 border border-destructive/20 rounded-lg">
              <p className="text-sm text-destructive">{error}</p>
            </div>
          )}
          
          <Button
            onClick={onGoogleSignIn}
            disabled={loading}
            className="w-full"
            size="lg"
          >
            <LogIn className="h-5 w-5 mr-2" />
            {loading ? 'Iniciando sesión...' : 'Continuar con Google'}
          </Button>

          <p className="text-xs text-center text-muted-foreground">
            Al iniciar sesión, aceptas participar en procesos de votación de manera segura y transparente.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
