"use client";

import React from "react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui";
import { AlertCircle } from "lucide-react";
import { Button } from "@/components/ui";

interface ErrorBoundaryState {
  hasError: boolean;
  error?: Error;
}

interface Props {
  children: React.ReactNode;
  fallback?: React.ReactNode;
}

export class PermissionErrorBoundary extends React.Component<
  Props,
  ErrorBoundaryState
> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    // You can log the error to an error reporting service here
    console.error("Permission Error:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      // Check if it's a permission-related error
      const isPermissionError =
        this.state.error?.message.toLowerCase().includes("permission") ||
        this.state.error?.message.toLowerCase().includes("access denied") ||
        this.state.error?.message.toLowerCase().includes("unauthorized");

      if (this.props.fallback) {
        return this.props.fallback;
      }

      return (
        <Alert variant={isPermissionError ? "destructive" : "default"}>
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>
            {isPermissionError ? "Access Denied" : "Something went wrong"}
          </AlertTitle>
          <AlertDescription className="flex flex-col gap-2">
            <p>
              {isPermissionError
                ? "You don't have permission to perform this action."
                : "An unexpected error occurred. Please try again later."}
            </p>
            <Button
              variant="outline"
              size="sm"
              onClick={() => this.setState({ hasError: false })}
            >
              Try again
            </Button>
          </AlertDescription>
        </Alert>
      );
    }

    return this.props.children;
  }
}
