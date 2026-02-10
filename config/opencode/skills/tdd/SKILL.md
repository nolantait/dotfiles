---
name: tdd
description: Apply Behavior-Driven Development workflow in Rails, focusing on testing interfaces not implementations.
---

# Rails BDD Protocol

## Core Principle

- **Behavior First**: Write tests that describe the desired behavior of the system from the outside in.
- **Sandi Metz Wisdom**: "Test messages, not state. Test interfaces, not implementations."
- **Goal**: Create well-designed, loosely coupled Rails applications where tests document behavior and drive design.

## Workflow

1. **Feature Specification**: Start with a clear description of the desired behavior in business terms (using Cucumber/Gherkin when appropriate).
2. **Outside-In Testing**: Begin with acceptance tests that define the external behavior, then write unit tests for the collaborating objects.
3. **Implementation**: Write only enough code to make the tests pass, focusing on clean object design.

## Mandatory Rules

- **Test Public Interfaces Only**: Only test what the object promises to the outside world, not its private implementation.
- **Message-Based Testing**: Verify that objects send the right messages to their collaborators, not that they implement specific algorithms.
- **No Test, No Feature**: Every new Rails feature must include behavior-driven tests at the appropriate level.
- **Merge Requirement**: All tests must pass and demonstrate the intended behavior before merging.

## Rails-Specific Practices

- **Model Tests**: Focus on business logic and validations, not ActiveRecord internals.
- **Controller Tests**: Test request/response behavior, not implementation details. Prefer request/integration tests over mocking-heavy controller specs.
- **View Tests**: Use system tests for critical user interactions; avoid testing HTML structure details.
- **Integration Tests**: For API endpoints and critical user journeys through the Rails stack.
- **Right-Sized Test Pyramid**:
  - **Many Unit Tests**: Fast, isolated tests for models, services, and value objects.
  - **Fewer Integration Tests**: For controller actions and component interactions.
  - **Very Few System Tests**: For complete user scenarios that require JavaScript and browser interaction.

## Sandi Metz's Testing Guidelines for Rails

1. **Test Incoming Messages**: Test that public methods return correct values (query methods).
2. **Test Outgoing Commands**: Verify that commands send the right messages to collaborators (use mocks sparingly and wisely).
3. **Test Outgoing Queries**: Don't test queries to collaborators; let them test themselves.
4. **Ignore Private Methods**: They are implementation details that may change without breaking behavior.
5. **Prefer Object Composition**: Test small, focused objects that collaborate rather than large, complex classes.

## Explicit Exceptions (Must be justified)

- **Pure Refactoring**: When behavior remains identical and existing tests already cover the functionality.
- **UI/Visual Changes**: Where behavior tests offer no value (CSS, layout tweaks).
- **Third-Party Integration**: When testing would require extensive, brittle mocking.
- **Emergency Hotfixes**: Must be followed immediately by a behavior test to prevent regression.
- **Performance Optimizations**: That don't change external behavior (requires performance tests instead).

## Quality Bar

- **Documentation Value**: Tests should read like a specification of what the system does.
- **Deterministic**: Tests must be reliable and not flaky; avoid testing time, randomness, or external services directly.
- **Fast**: Unit tests should run quickly to support the red-green-refactor cycle.
- **Loosely Coupled**: Tests should survive internal refactoring as long as public behavior remains unchanged.
- **Rails-Conventional**: Follow Rails testing conventions and use built-in testing frameworks effectively.

## Red-Green-Refactor in Rails Context

1. **Red**: Write a failing test that describes the desired behavior in the simplest possible terms.
2. **Green**: Write the minimal Rails code (model, controller, view, etc.) to make the test pass.
3. **Refactor**: Improve the design while keeping tests green, applying Rails best practices and object-oriented principles.

Remember: "Tests are the first and best client of your code." – Sandi Metz
