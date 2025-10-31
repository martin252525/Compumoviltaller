// API Health Check Component for debugging
import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Badge } from './ui/badge';
import { Button } from './ui/button';
import { CheckCircle2, XCircle, Loader2, RefreshCw, Database } from 'lucide-react';
import { setApiMode, isUsingMockApi } from '../services/api.service';

export function ApiHealthCheck() {
  const [status, setStatus] = useState<'checking' | 'online' | 'offline'>('checking');
  const [details, setDetails] = useState<string>('');
  const [responseTime, setResponseTime] = useState<number>(0);
  const [usingMock, setUsingMock] = useState(isUsingMockApi());

  const checkApi = async () => {
    setStatus('checking');
    setDetails('');
    const startTime = Date.now();

    try {
      console.log('[Health Check] Testing API connection to:', 'https://api.sebastian.cl/vote');
      console.log('[Health Check] Testing endpoint: /api/vote-processes?page=0&size=1');
      
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 15000); // 15 second timeout
      
      const response = await fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        signal: controller.signal,
      });

      clearTimeout(timeoutId);
      const endTime = Date.now();
      setResponseTime(endTime - startTime);

      console.log('[Health Check] Response received');
      console.log('[Health Check] Status:', response.status);
      console.log('[Health Check] Status Text:', response.statusText);
      console.log('[Health Check] Response time:', endTime - startTime, 'ms');
      
      if (response.ok) {
        setStatus('online');
        const data = await response.json();
        console.log('[Health Check] Response data:', data);
        setDetails(`✅ API respondiendo correctamente\n` +
                   `📊 Total de procesos: ${data.totalElements || 0}\n` +
                   `📄 Páginas disponibles: ${data.totalPages || 0}\n` +
                   `⚡ Tiempo de respuesta: ${endTime - startTime}ms`);
      } else {
        setStatus('offline');
        console.error('[Health Check] API responded with error status:', response.status);
        setDetails(`❌ API respondió con código de error: ${response.status} ${response.statusText}\n\n` +
                   `Esto significa que la API está en línea pero rechazó la petición.\n` +
                   `Verifica la documentación en Swagger.`);
      }
    } catch (error: any) {
      console.error('[Health Check] Request failed');
      console.error('[Health Check] Error type:', error.name);
      console.error('[Health Check] Error message:', error.message);
      console.error('[Health Check] Full error:', error);
      
      setStatus('offline');
      
      if (error.name === 'AbortError') {
        setDetails('⏱️ La petición tardó más de 15 segundos\n\n' +
                   'Posibles causas:\n' +
                   '• Conexión a internet muy lenta\n' +
                   '• El servidor está sobrecargado\n' +
                   '• Problemas de red');
      } else if (error.message.includes('Failed to fetch')) {
        setDetails('🔌 No se pudo conectar a la API\n\n' +
                   'Posibles causas:\n' +
                   '1. ❌ La API está caída o en mantenimiento\n' +
                   '2. 🌐 Sin conexión a internet\n' +
                   '3. 🚫 Problema de CORS (el servidor no permite peticiones desde este origen)\n' +
                   '4. 🔥 Firewall o antivirus bloqueando la conexión\n' +
                   '5. 🔒 Proxy corporativo/universitario bloqueando el acceso\n\n' +
                   '💡 Prueba abrir el Swagger en otra pestaña para verificar si la API está funcionando.');
      } else {
        setDetails(`❌ Error inesperado: ${error.message}\n\n` +
                   `Tipo de error: ${error.name}`);
      }
      
      setResponseTime(0);
    }
  };

  const toggleMockMode = () => {
    const newMockMode = !usingMock;
    setApiMode(newMockMode);
    setUsingMock(newMockMode);
    
    // Reload the page to apply changes
    window.location.reload();
  };

  useEffect(() => {
    // Only check API automatically if not using mock
    if (!usingMock) {
      checkApi();
    }
  }, []);

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle>Estado de la API</CardTitle>
            <CardDescription>
              {usingMock ? 'Usando datos de prueba (MOCK)' : 'https://api.sebastian.cl/vote'}
            </CardDescription>
          </div>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={checkApi} disabled={status === 'checking' || usingMock}>
              <RefreshCw className={`h-4 w-4 mr-2 ${status === 'checking' ? 'animate-spin' : ''}`} />
              Verificar
            </Button>
          </div>
        </div>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex items-center gap-2">
          {usingMock ? (
            <>
              <Database className="h-5 w-5 text-blue-500" />
              <Badge variant="default" className="bg-blue-500">Modo Desarrollo (Mock)</Badge>
            </>
          ) : (
            <>
              {status === 'checking' && (
                <>
                  <Loader2 className="h-5 w-5 animate-spin text-blue-500" />
                  <span>Verificando conexión...</span>
                </>
              )}
              {status === 'online' && (
                <>
                  <CheckCircle2 className="h-5 w-5 text-green-500" />
                  <Badge variant="default" className="bg-green-500">API en línea</Badge>
                  {responseTime > 0 && (
                    <span className="text-sm text-muted-foreground">
                      ({responseTime}ms)
                    </span>
                  )}
                </>
              )}
              {status === 'offline' && (
                <>
                  <XCircle className="h-5 w-5 text-destructive" />
                  <Badge variant="destructive">API no disponible</Badge>
                </>
              )}
            </>
          )}
        </div>

        {details && !usingMock && (
          <div className="p-3 bg-muted rounded-lg">
            <p className="text-sm whitespace-pre-line">{details}</p>
          </div>
        )}

        {usingMock && (
          <div className="p-3 bg-blue-50 border border-blue-200 rounded-lg">
            <p className="text-sm font-medium mb-2">✅ Usando datos de prueba</p>
            <p className="text-sm mb-2">
              La aplicación está funcionando con datos de ejemplo para que puedas probarla sin necesidad de que la API externa esté disponible.
            </p>
            <p className="text-sm text-muted-foreground">
              Los datos incluyen: 5 procesos de votación de ejemplo, con diferentes estados (activos, finalizados, pendientes).
            </p>
          </div>
        )}

        {status === 'offline' && !usingMock && (
          <div className="p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
            <p className="text-sm font-medium mb-2">💡 Solución Rápida:</p>
            <p className="text-sm mb-3">
              Si la API no está disponible, puedes usar <strong>datos de prueba</strong> para explorar la aplicación.
            </p>
            <Button 
              variant="default" 
              size="sm" 
              onClick={toggleMockMode}
              className="w-full"
            >
              <Database className="h-4 w-4 mr-2" />
              Usar Datos de Prueba (Mock)
            </Button>
          </div>
        )}

        {usingMock && (
          <div className="p-3 bg-gray-50 border border-gray-200 rounded-lg">
            <p className="text-sm mb-3">
              Cuando la API esté disponible, puedes volver a conectarla:
            </p>
            <Button 
              variant="outline" 
              size="sm" 
              onClick={toggleMockMode}
              className="w-full"
            >
              <RefreshCw className="h-4 w-4 mr-2" />
              Volver a API Real
            </Button>
          </div>
        )}

        {status === 'offline' && !usingMock && (
          <div className="p-3 bg-gray-50 border border-gray-200 rounded-lg">
            <p className="text-sm font-medium mb-2">Otras sugerencias:</p>
            <ul className="text-sm space-y-1 list-disc list-inside">
              <li>Verifica tu conexión a internet</li>
              <li>Intenta acceder a <a href="https://api.sebastian.cl/vote/swagger-ui/index.html" target="_blank" rel="noopener noreferrer" className="text-primary underline">Swagger UI</a></li>
              <li>Verifica si tu antivirus/firewall está bloqueando</li>
              <li>Prueba desde otro navegador</li>
              <li>Consulta el archivo TROUBLESHOOTING_API.md</li>
            </ul>
          </div>
        )}
      </CardContent>
    </Card>
  );
}