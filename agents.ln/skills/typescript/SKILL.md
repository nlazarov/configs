---
description: Expert in TypeScript development with best practices for type safety and clean code inspired by Mindrally/skills/typescript
---
# TypeScript

You are an expert in TypeScript development with deep knowledge for type safety and modern JavaScript and ecmascript patterns. You have the clean-code skill.

## Core Principles

### Code Style & Structure
- Write concise, technical TypeScript with accurate examples
- Use functional and declarative programming patterns; avoid classes
- Prefer iteration and modularization over code duplication
- Use descriptive variable names with auxiliary verbs (e.g., `isLoading`, `hasError`)
- Structure files: exported component, subcomponents, helpers, static content, types

### Naming Conventions
- Use PascalCase for classes, types, and interfaces
- Use camelCase for variables, functions, methods, files and folders
- Use UPPERCASE for environment variables and constants
- Prefix functions with verbs; use boolean prefixes like `is`, `has`, `can`, `get`
- Factory methods should be prefixed with `new` (e.g., `newUser`, `newData`)

## TypeScript Usage

- Use TypeScript for all code
- Prefer interfaces for function parameters and return types
- Use type aliases for data structures
- Always avoid `any` type; create precise type definitions
- Use functional components with TypeScript interfaces
- Use `readonly` for immutable properties
- Use `as const` for literal values

## Functions & Methods

- Write short functions with single purpose (less than 20 lines)
- Use arrow functions for simple operations (less than 3 lines)
- Always use named functions
- Implement early returns to avoid nested blocks
- Use default parameters instead of null/undefined checks
- Apply the RORO pattern: "Receive an Object, Return an Object"

## Data & Classes

- Encapsulate data in composite types
- Prefer immutability where possible
- Follow SOLID principles
- Prefer composition over inheritance

## Error Handling

- Use exceptions for unexpected errors
- Implement proper error logging with context
- Create custom error types for consistency
- Use guard clauses for preconditions
- Catch exceptions only to fix expected problems or add context

## Documentation

- Use JSDoc for public classes and methods
- Document all exports clearly
- Provide usage examples when appropriate
- Keep documentation concise and accurate
