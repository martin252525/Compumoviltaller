// User profile component
import { User } from 'firebase/auth';
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { LogOut, Mail, User as UserIcon } from 'lucide-react';

interface UserProfileProps {
  user: User;
  onSignOut: () => void;
}

export function UserProfile({ user, onSignOut }: UserProfileProps) {
  const getInitials = (name: string | null) => {
    if (!name) return '?';
    return name
      .split(' ')
      .map((n) => n[0])
      .slice(0, 2)
      .join('')
      .toUpperCase();
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>Mi Perfil</CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="flex items-center gap-4">
          <Avatar className="h-16 w-16">
            <AvatarImage src={user.photoURL || undefined} alt={user.displayName || 'Usuario'} />
            <AvatarFallback>{getInitials(user.displayName)}</AvatarFallback>
          </Avatar>
          <div className="flex-1">
            <p className="font-medium">{user.displayName || 'Usuario'}</p>
            <p className="text-sm text-muted-foreground">{user.email}</p>
          </div>
        </div>

        <div className="space-y-3">
          <div className="flex items-center gap-3 text-sm">
            <UserIcon className="h-4 w-4 text-muted-foreground" />
            <div>
              <p className="text-muted-foreground">Nombre</p>
              <p>{user.displayName || 'No disponible'}</p>
            </div>
          </div>

          <div className="flex items-center gap-3 text-sm">
            <Mail className="h-4 w-4 text-muted-foreground" />
            <div>
              <p className="text-muted-foreground">Correo electrónico</p>
              <p>{user.email}</p>
            </div>
          </div>
        </div>

        <Button variant="outline" onClick={onSignOut} className="w-full">
          <LogOut className="h-4 w-4 mr-2" />
          Cerrar Sesión
        </Button>
      </CardContent>
    </Card>
  );
}
