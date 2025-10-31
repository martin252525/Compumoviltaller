// Mock Mode Notice Component
import { useState } from 'react';
import { Alert, AlertDescription, AlertTitle } from './ui/alert';
import { Button } from './ui/button';
import { Database, X } from 'lucide-react';
import { isUsingMockApi, setApiMode } from '../services/api.service';

export function MockModeNotice() {
  const [visible, setVisible] = useState(true);
  const usingMock = isUsingMockApi();

  if (!usingMock || !visible) {
    return null;
  }

  const switchToReal = () => {
    if (confirm('¿Estás seguro de que quieres cambiar a la API real? Esto recargará la página.')) {
      setApiMode(false);
      window.location.reload();
    }
  };

  return (
    <Alert className="mb-6 bg-blue-50 border-blue-200">
      <Database className="h-4 w-4 text-blue-600" />
      <AlertTitle className="text-blue-900">Modo de Desarrollo (Datos de Prueba)</AlertTitle>
      <AlertDescription className="text-blue-800">
        <div className="flex items-start justify-between gap-4">
          <div className="flex-1">
            <p className="mb-2">
              Estás usando <strong>datos de prueba</strong>. La aplicación funciona con 12 procesos de votación de ejemplo.
            </p>
            <div className="flex gap-2">
              <Button 
                variant="outline" 
                size="sm" 
                onClick={switchToReal}
                className="text-blue-700 border-blue-300 hover:bg-blue-100"
              >
                Cambiar a API Real
              </Button>
              <Button 
                variant="ghost" 
                size="sm" 
                onClick={() => setVisible(false)}
                className="text-blue-700 hover:bg-blue-100"
              >
                <X className="h-4 w-4 mr-1" />
                Ocultar
              </Button>
            </div>
          </div>
        </div>
      </AlertDescription>
    </Alert>
  );
}
