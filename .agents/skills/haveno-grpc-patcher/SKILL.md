---
name: haveno-grpc-patcher
description: Audits and generates standard patch structures for the haveno_client_dart repository to match upstream Java gRPC core changes. Trigger this skill whenever resolving Code 16 UNAUTHENTICATED errors, gRPC header injection, or handling getEmptyFormField payment serialization mismatches.
---

# Haveno gRPC and Payment Method Patcher Skill

## Context & Role
You are executing inside a specialized development environment targeting the Haveno Decentralized Exchange (DEX) network. Your task is to act as a Compiler-Grade Code Auditor. You map Java-side gRPC backend behaviors to clean, strictly-typed, Null-Safe Dart clients.

## Operational Workflows

### 1. Verification of the Authentication Shield (gRPC Code 16)
- **Problem:** The upstream Java backend enforces a mandatory RPC password check via custom gRPC Interceptors, throwing an `UNAUTHENTICATED (code: 16)` error if missing.
- **Instruction:** Check `lib/haveno_client_dart.dart`. You must ensure the main client wrapper class injects `CallOptions(metadata: {'password': password})` directly into the generated Stub instance upon instantiation. Do not expose raw HTTP/2 channels to the endpoint execution blocks.

### 2. Form Field Factory Sync (`getEmptyFormField`)
- **Problem:** Upstream Pull Requests (such as PR #2030) implement new payment methods (Western Union, UPI, PAYTM, Pix, IMPS, NEFT, RTGS, Paysera, Bizum, etc.). These methods introduce specific localized label configurations in the backend's `getEmptyFormField` logic. If the Dart client serialization strings do not match, the system crashes with a runtime `Type 'Null' is not a subtype of 'String'`.
- **Instruction:** Analyze the upstream repository's `getEmptyFormField` strings. Audit the local Dart files to detect casing differences (e.g., camelCase vs snake_case) or missing enum/string fields. 

## Constraint Enforcement (Crucial)
- **NO DIRECT WRITES:** Do not modify any code in the active repository directly.
- **NO PULL REQUESTS:** Do not invoke any automated tools to push commits, open branches, or create pull requests.
- **OUTPUT EXECUTION:** Your only valid output format is a clean code block showing the refactored code and step-by-step UNIX `patch` or line-by-line file insertion instructions for execution via `nano`.

## Expected Output Delivery Format
Always structure your final analytical response using the following headers:
1. `### 🔍 Upstream Analysis Summary` (Detailing what you found in the Java PR or Issue)
2. `### 🪓 Refactored Source Code Patch` (The full block for `lib/haveno_client_dart.dart`)
3. `### 🧭 Nano Insertion Steps` (Clear manual execution steps for the terminal)
