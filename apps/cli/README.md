# CLI Application

This directory will contain the command-line application code.

## Structure
- `cmd/` - Application entry points
- `pkg/` - Shared packages
- `internal/` - Internal packages
- `Dockerfile` - Container build instructions

## Getting Started
```bash
# Build the application
go build -o bin/cli cmd/main.go

# Run the application
./bin/cli
```
