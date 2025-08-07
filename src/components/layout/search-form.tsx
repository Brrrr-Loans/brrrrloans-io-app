import { Search } from "lucide-react";
import { Button } from "@/components/ui";

export function SearchForm({
  className,
  ...props
}: React.ComponentProps<"div">) {
  return (
    <div className={className} {...props}>
      <Button
        variant="outline"
        className="inline-flex items-center gap-2 whitespace-nowrap transition-colors focus-visible:outline-hidden focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0 border border-input hover:text-accent-foreground px-4 py-2 bg-muted/25 text-muted-foreground hover:bg-muted/50 relative h-8 w-full justify-start rounded-md text-sm font-normal shadow-none sm:pr-12 md:w-40 lg:w-56 xl:w-64"
      >
        <Search className="absolute top-1/2 left-1.5 -translate-y-1/2 size-4" />
        <span className="ml-3">Search</span>
        <kbd className="bg-muted pointer-events-none absolute top-[0.3rem] right-[0.3rem] hidden h-5 items-center gap-1 rounded border px-1.5 font-mono text-[10px] font-medium opacity-100 select-none sm:flex">
          <span className="text-xs">⌘</span>K
        </kbd>
      </Button>
    </div>
  );
}
