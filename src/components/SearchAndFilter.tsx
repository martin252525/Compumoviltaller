// Search and filter component
import { useState } from 'react';
import { Input } from './ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { Button } from './ui/button';
import { Search, X } from 'lucide-react';

interface SearchAndFilterProps {
  onSearch: (search: string) => void;
  onFilterStatus: (status: string) => void;
  initialSearch?: string;
  initialStatus?: string;
}

export function SearchAndFilter({
  onSearch,
  onFilterStatus,
  initialSearch = '',
  initialStatus = '',
}: SearchAndFilterProps) {
  const [search, setSearch] = useState(initialSearch);
  const [status, setStatus] = useState(initialStatus);

  const handleSearchChange = (value: string) => {
    setSearch(value);
    onSearch(value);
  };

  const handleStatusChange = (value: string) => {
    setStatus(value);
    onFilterStatus(value);
  };

  const handleClearSearch = () => {
    setSearch('');
    onSearch('');
  };

  const handleClearStatus = () => {
    setStatus('');
    onFilterStatus('');
  };

  return (
    <div className="flex flex-col sm:flex-row gap-4 mb-6">
      <div className="relative flex-1">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          type="text"
          placeholder="Buscar votaciones..."
          value={search}
          onChange={(e) => handleSearchChange(e.target.value)}
          className="pl-10 pr-10"
        />
        {search && (
          <Button
            variant="ghost"
            size="sm"
            onClick={handleClearSearch}
            className="absolute right-1 top-1/2 -translate-y-1/2 h-7 w-7 p-0"
          >
            <X className="h-4 w-4" />
          </Button>
        )}
      </div>

      <div className="flex gap-2 items-center">
        <Select value={status} onValueChange={handleStatusChange}>
          <SelectTrigger className="w-full sm:w-[180px]">
            <SelectValue placeholder="Filtrar por estado" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todos los estados</SelectItem>
            <SelectItem value="ACTIVE">Activo</SelectItem>
            <SelectItem value="CLOSED">Cerrado</SelectItem>
            <SelectItem value="DRAFT">Borrador</SelectItem>
            <SelectItem value="CANCELLED">Cancelado</SelectItem>
          </SelectContent>
        </Select>
        {status && status !== 'all' && (
          <Button
            variant="ghost"
            size="sm"
            onClick={handleClearStatus}
            className="h-10 w-10 p-0"
          >
            <X className="h-4 w-4" />
          </Button>
        )}
      </div>
    </div>
  );
}
