---
description: Set of software development principles and best practices for writing clean code
metadata:
  inspiration: uncle Bob's Clean Code principles
---

# Clean Code Principles

> There is no good reason to not write 

When writing code, you should always strive to make it clean, readable, and maintainable. Clean code is not just about making your code look good; it's about making it easier for others (and yourself in the future) to understand and work with it. Follow these principles:

- **Meaningful Names**: Use descriptive and meaningful names for variables, functions, and classes. Avoid abbreviations and single-letter names unless they are widely understood (e.g., `i` for loop index, or `idx` for loop handler index parameters).
- **Small Functions**: Write small functions that do one thing and do it well. A function should ideally be less than 20 lines of code, preferably up to 9 lines. If a function is doing more than one thing, consider breaking it down into smaller functions.
- Prefer pure functions that have no side effects
- Use composition over inheritance
- **DRY (Don't Repeat Yourself)**: Avoid code duplication. If you find yourself writing the same code more than once, consider creating a reusable function or module.
- **YAGNI (You Aren't Gonna Need It)**: Don't add functionality until it's necessary. Avoid over-engineering your code with features that may never be used.
- **KISS (Keep It Simple, Stupid)**: Keep your code simple and straightforward. Avoid unnecessary complexity and overcomplication.
- **Error Handling**: Handle errors gracefully and consistently. Use exceptions for unexpected errors and guard clauses for preconditions.

## SOLID Principles
- **Single Responsibility Principle**: Each class or module should have only one reason to change. This means that a class should only have one job or responsibility.
- **Open/Closed Principle**: Software entities (classes, modules, functions, etc.) should be open for extension but closed for modification. This means that you should be able to add new functionality without changing existing code.
- **Liskov Substitution Principle**: Objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program. This means that subclasses should be able to be used in place of their parent class without causing errors or unexpected behavior.
- **Interface Segregation Principle**: Clients should not be forced to depend on interfaces they do not use. This means that you should create specific interfaces for different clients rather than a single, general-purpose interface.
- **Dependency Inversion Principle**: High-level modules should not depend on low-level modules. Both should depend on abstractions. This means that you should depend on interfaces or abstract classes rather than concrete implementations.

## Code Transformation list

When doing code changes, try to adhere to the transformations below from top to bottom:

- ({}–>nil) no code at all->code that employs nil
- (nil->constant)
- (constant->constant+) a simple constant to a more complex constant
- (constant->scalar) replacing a constant with a variable or an argument
- (statement->statements) adding more unconditional statements.
- (unconditional->if) splitting the execution path
- (scalar->array)
- (array->container)
- (statement->recursion)
- (if->while)
- (expression->function) replacing an expression with a function or algorithm
- (variable->assignment) replacing the value of a variable.
