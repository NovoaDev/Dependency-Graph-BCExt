# Instructions for Copilot
## Code Generation    
-   All code must be written in **English**.
-   Explicitly declare **access modifiers** for procedures (`local`, `internal`, `public`), prioritizing `local` or `internal` as appropriate.
-   When using `Insert`, `Modify`, `Delete` or `DeleteAll`, always pass `true` as a parameter to ensure full execution of business logic. Example: `Insert(true)`, `Modify(true)`.
-   When using `FindSet()`, specify the parameter according to the block’s intent. If the table will be modified, use `FindSet(true)`; otherwise, use `FindSet(false)`.
-   When assigning a value to a field, **do not assign it directly**; use `Validate` to ensure the correct execution of related logic.
-   Do not hardcode **text** in messages or user interaction elements. Use `Labels` to facilitate translation file generation.
-   Do not declare multiple variables of the same type in a single line. Incorrect example: `MyInt1, MyInt2, MyInt3: Integer;`.
-   Control all graphical interface elements (`Message`, `Confirm`, etc.) using `GuiAllowed()` to prevent errors in background processes.
-   Use the correct suffix in `Label`-type variables according to their purpose:
    -   `Msg` – Messages.
    -   `Tok` – Constants such as tokens, URLs, etc.
    -   `Err` – Errors.
    -   `Qst` – For `StrMenu` or `Confirm`.
    -   `Lbl` – Texts that require translation (`Label`, `Caption`).
-   Apply **SOLID** principles in code design:
    -   **SRP** – Single Responsibility Principle: Each module should have only one reason to change.
    -   **OCP** – Open/Closed Principle: Code should be open for extension (events, interfaces) but closed for direct modification.
    -   **LSP** – Liskov Substitution Principle: Use interfaces to ensure implementations can be interchanged without altering expected behavior.
    -   **ISP** – Interface Segregation Principle: Split large interfaces into several smaller, more specific ones.
    -   **DIP** – Dependency Inversion Principle: Modules should depend on abstractions (interfaces, events), not on concrete implementations.
-   Do not use `Find(-)`, `Find(+)`, `Find(=)`, etc. Use `FindFirst()`, `FindLast()` or `FindSet()` instead.
-   Always use the most appropriate data type: `primitive types`, `List`, `Dictionary`, `JsonObject`, `TextBuilder`, among others.
-   All objects and procedures must be properly documented using **XML comments**.
-   Do not use `//` or `/* */` comments; all documentation must be provided through XML blocks above procedures and objects.
-   Avoid adding redundant or unhelpful comments.
-   When adding elements to pages, prioritize `AddFirst` or `AddLast` over `AddAfter` or `AddBefore`.    
-   Ensure **referential integrity** when linking fields.
-   In event subscriptions, explicitly configure: `SkipOnMissingLicense = false` and `SkipOnMissingPermission = false`.
-   Remove unnecessary lines such as redundant calls to `Reset` or default initializations for newly created variables.
-   When a variable refers to an object, use the exact **same name** as the object, with no spaces, quotes, or special characters.
-   Consider the **cyclomatic complexity** of the code.
-   Simplify control structures and avoid unnecessary `begin/end` blocks.
-   If a function has more than six parameters, consider using structures like `Dictionary`, `Record`, or others to simplify the call.
-   Always declare the **exact length** for `Text` or `Code` type fields and variables.
-   If adding `FlowField` type fields in a table, make sure to set `Editable = false`.
-   Use **PascalCase** for naming objects, functions, and variables.
-   Do not use `Option`; create an `Enum` type instead.
-   When subscribing to an event that receives a table as a parameter, first check if it is **temporary**. If it is, use `exit;`.
-   Do not include code directly within **triggers**; create separate functions that can be called from the trigger.
-   In new tables, add the `DataClassification` property **only at the table level**, **never on individual fields**.
-   In table extensions, **do not add `DataClassification` at the table level**; this will cause an error. Add it only to specific fields.
-   Avoid **hardcoding** object IDs. Use the **object name** instead.
-   Structure the code according to its purpose. Prioritize in the following order:
    -   Use **codeunits** for general and reusable logic.
    -   Use **tables** for logic related to entities.
    -   Use **pages** exclusively for user interaction.
-   All variable names must be **clear and descriptive**. Avoid meaningless abbreviations or single letters.
-   When creating a table, define the `DrillDownPageId` and `LookupPageId` properties, referencing the corresponding list-type page.
-   Use the condition directly in validations. Avoid constructs like `if Condition = true` or `= false`.

## Code Review
-   Verify that all added procedures are documented with XML blocks.
-   Ensure the code complies with all established generation instructions.
-   Make code review comments in English and respectfully insulting the developer in Spanish as a loving reminder that they can do better.

## Commit Message Generation
-   The message must be written in English.
-   Use the following format:  
    `[Type] - [Branch Name] - [Brief Description]`  
    Example: `Bug - EV001 - Optimización del cálculo de impuestos`
-   Include a clear, precise, and concise description of the changes made.

## Pull Request Title and Description Generation Instructions
-   Titles: Use a clear format that includes the main purpose of the changes.  
    Example: `Fix: Error in discount calculation logic`
-   Descriptions: Include an overview of the changes made, explaining their impact and purpose.
