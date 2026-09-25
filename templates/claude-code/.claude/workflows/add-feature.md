# 📱 SOP: Add Feature Workflow (add-feature.md)

[简体中文](add-feature.zh-CN.md)

> **Objective**: Standard operating procedure for adding or refactoring features, ensuring interface-first structure and adherence to the Golden Feature Template.

---

## Standard Execution Steps

### Step 1: Define Interfaces First
Strictly follow [docs/architecture/golden_feature_template.md](../../docs/architecture/golden_feature_template.md):
1. Create an `Interface/` directory in the feature module;
2. Define clear protocols/interfaces (e.g. `IFeatureService` or `<FeatureName>Protocol`);
3. Explicitly declare method signatures, input constraints, return types, and business errors.

### Step 2: Implement and Orchestrate
1. Implement business logic under `Implementation/` or `Services/`;
2. Separate state management from IO (network/database operations in Service, state in Store/ViewModel);
3. Keep the View layer purely presentational without embedding network requests or data conversion algorithms.

### Step 3: Verify Single Source of Truth
1. Ensure no magic numbers, URLs, or status strings are hardcoded;
2. Enums and constants must be sourced from central configurations or dictionaries.

### Step 4: Run Verification Commands
Execute the verification commands specified in `AGENTS.md`:
```bash
# Static type checking
<Typecheck Command>

# Compilation & build test
<Build Command>
```
Ensure zero errors; never declare completion based on assumption.

### Step 5: Update Map and Context Index (Doc-Sync)
- [ ] Register feature responsibility in [docs/PROJECT_MAP.md](../../docs/PROJECT_MAP.md);
- [ ] Register interface paths in [.agents/context-index.md](../context-index.md);
- [ ] Verify impact in [.agents/dependency-map.md](../dependency-map.md).
