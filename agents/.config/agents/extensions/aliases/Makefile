# Makefile for Aliases Extension
# Provides build and test targets for the Model Aliases extension

.PHONY: all build test clean help

# Default target
all: build

# Build the TypeScript files
build:
	@echo "Building TypeScript files..."
	npx tsc -p tsconfig.test.json
	@# Fix ESM imports in compiled JS (add .js extensions)
	@sed -i '' 's|from "./utils"|from "./utils.js"|g; s|from "./types"|from "./types.js"|g' dist/index.js 2>/dev/null || true
	@echo "Build complete."

# Run tests (builds first)
test: build
	@echo "Running tests..."
	@# Ensure dist/package.json exists for ESM
	@echo '{"type": "module"}' > dist/package.json
	node --test dist/index.test.js

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist
	@echo "Clean complete."

# Rebuild from scratch
rebuild: clean build

# Show help
help:
	@echo "Available targets:"
	@echo "  make build    - Compile TypeScript files"
	@echo "  make test     - Build and run tests"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make rebuild  - Clean and rebuild"
	@echo "  make help     - Show this help message"
