// Header component with navigation
import { User } from 'firebase/auth';
import { useState, useEffect } from 'react';
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { Button } from './ui/button';
import { Badge } from './ui/badge';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from './ui/dropdown-menu';
import { Vote, User as UserIcon, History, LogOut, Database } from 'lucide-react';
import { isUsingMockApi } from '../services/api.service';

interface HeaderProps {
  user: User | null;
  currentView: 'home' | 'profile';
  onNavigate: (view: 'home' | 'profile') => void;
  onSignOut: () => void;
}

export function Header({ user, currentView, onNavigate, onSignOut }: HeaderProps) {
  const [usingMock, setUsingMock] = useState(isUsingMockApi());

  useEffect(() => {
    const handleApiModeChanged = (event: any) => {
      setUsingMock(event.detail.useMock);
    };
    
    window.addEventListener('apiModeChanged', handleApiModeChanged);
    return () => window.removeEventListener('apiModeChanged', handleApiModeChanged);
  }, []);

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
    <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-16 items-center justify-between px-4">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-primary rounded-full flex items-center justify-center">
            <Vote className="h-5 w-5 text-primary-foreground" />
          </div>
          <div>
            <div className="flex items-center gap-2">
              <h1 className="font-semibold">Sistema de Votación</h1>
              {usingMock && (
                <Badge variant="default" className="bg-blue-500 hidden sm:flex">
                  <Database className="h-3 w-3 mr-1" />
                  Mock
                </Badge>
              )}
            </div>
            <p className="text-xs text-muted-foreground hidden sm:block">
              Universidad Tecnológica Metropolitana
            </p>
          </div>
        </div>

        {user && (
          <div className="flex items-center gap-4">
            <nav className="hidden md:flex items-center gap-2">
              <Button
                variant={currentView === 'home' ? 'default' : 'ghost'}
                onClick={() => onNavigate('home')}
              >
                Votaciones
              </Button>
              <Button
                variant={currentView === 'profile' ? 'default' : 'ghost'}
                onClick={() => onNavigate('profile')}
              >
                Mi Perfil
              </Button>
            </nav>

            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="relative h-10 w-10 rounded-full">
                  <Avatar className="h-10 w-10">
                    <AvatarImage src={user.photoURL || undefined} alt={user.displayName || 'Usuario'} />
                    <AvatarFallback>{getInitials(user.displayName)}</AvatarFallback>
                  </Avatar>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent className="w-56" align="end">
                <DropdownMenuLabel>
                  <div className="flex flex-col space-y-1">
                    <p>{user.displayName || 'Usuario'}</p>
                    <p className="text-xs text-muted-foreground truncate">{user.email}</p>
                  </div>
                </DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem onClick={() => onNavigate('home')} className="md:hidden">
                  <Vote className="mr-2 h-4 w-4" />
                  Votaciones
                </DropdownMenuItem>
                <DropdownMenuItem onClick={() => onNavigate('profile')} className="md:hidden">
                  <UserIcon className="mr-2 h-4 w-4" />
                  Mi Perfil
                </DropdownMenuItem>
                <DropdownMenuSeparator className="md:hidden" />
                <DropdownMenuItem onClick={onSignOut}>
                  <LogOut className="mr-2 h-4 w-4" />
                  Cerrar Sesión
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        )}
      </div>
    </header>
  );
}