const fs = require('fs');
const path = require('path');
const readline = require('readline');

const RUNTIMES = ['claude-code', 'codex', 'gemini-cli', 'cursor'];
const TIERS = ['light', 'standard', 'full'];
const CLI_VERSION = require('../package.json').version;

// A simple CLI prompt helper
function prompt(question) {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  return new Promise(resolve => {
    rl.question(question, answer => {
      rl.close();
      resolve(answer.trim());
    });
  });
}

function versionCommand() {
  console.log(`AI-Native Repository CLI version ${CLI_VERSION}`);
  console.log(`Standard Version: 2.0`);
}

function listCommand() {
  console.log("Available Agent Runtimes:");
  RUNTIMES.forEach((r, i) => console.log(`  ${i + 1}. ${r}`));
  console.log("\nAvailable Tiers (Complexity Profiles):");
  TIERS.forEach((t, i) => console.log(`  ${i + 1}. ${t}`));
}

function doctorCommand() {
  const cwd = process.cwd();
  console.log("Running AI-Native Repository Doctor on:", cwd);
  const hasMap = fs.existsSync(path.join(cwd, 'docs', 'PROJECT_MAP.md'));
  const hasManifest = fs.existsSync(path.join(cwd, 'anr.yaml'));
  const hasClaude = fs.existsSync(path.join(cwd, 'CLAUDE.md'));
  const hasCursor = fs.existsSync(path.join(cwd, '.cursor', 'rules'));
  const hasGemini = fs.existsSync(path.join(cwd, 'GEMINI.md'));
  const hasCodex = fs.existsSync(path.join(cwd, 'AGENTS.md'));

  if (!hasMap && !hasManifest && !hasClaude && !hasCursor && !hasGemini && !hasCodex) {
    console.log("❌ No AI-Native Repository infrastructure detected.");
    console.log("   Suggestion: run `anr init .` to get started.");
  } else {
    console.log("✅ Basic AI-Native structures detected.");
    if (hasManifest) console.log("   - Found anr.yaml manifest");
    if (hasMap) console.log("   - Found docs/PROJECT_MAP.md");
    if (hasClaude || hasCursor || hasGemini || hasCodex) {
      console.log("   - Found Agent Runtime entrypoints");
    }
  }
}

function validateCommand(args) {
  const isCI = args.includes('--ci');
  const cwd = process.cwd();
  
  // 1. If we are in the Reference Repository, call the canonical bash validator
  const canonicalScript = path.join(cwd, 'scripts', 'validate.sh');
  if (fs.existsSync(canonicalScript)) {
    if (!isCI) console.log("Running canonical validator (scripts/validate.sh)...");
    try {
      const { execSync } = require('child_process');
      execSync(`bash "${canonicalScript}"`, { stdio: 'inherit' });
      if (!isCI) console.log("\n🎉 VALIDATION PASSED!");
      process.exit(0);
    } catch (err) {
      if (!isCI) console.log(`\n❌ VALIDATION FAILED.`);
      process.exit(1);
    }
  }

  // 2. Otherwise (Consumer Repository), do standard manifest checks
  let fails = 0;
  const manifestPath = path.join(cwd, 'anr.yaml');
  if (!fs.existsSync(manifestPath)) {
    console.error("❌ FAIL: anr.yaml missing.");
    fails++;
  } else {
    if (!isCI) console.log("✅ PASS: anr.yaml exists.");
  }

  if (fails > 0) {
    if (!isCI) console.log(`\n❌ VALIDATION FAILED with ${fails} errors.`);
    process.exit(1);
  } else {
    if (!isCI) console.log("\n🎉 VALIDATION PASSED!");
    process.exit(0);
  }
}

async function initCommand(args) {
  let target = '.';
  let runtime = '';
  let tier = '';
  let isDryRun = false;

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--runtime') runtime = args[++i];
    else if (args[i] === '--tier') tier = args[++i];
    else if (args[i] === '--dry-run') isDryRun = true;
    else if (!args[i].startsWith('-')) target = args[i];
  }

  const targetDir = path.resolve(process.cwd(), target);

  while (!runtime || !RUNTIMES.includes(runtime)) {
    console.log("Available Runtimes:");
    RUNTIMES.forEach((r, i) => console.log(`  ${i + 1}. ${r}`));
    let ans = await prompt("Select Runtime (1-4): ");
    runtime = RUNTIMES[parseInt(ans) - 1];
    if (!runtime) {
      console.log("❌ Invalid choice. Please select a number between 1 and 4.\n");
    }
  }

  while (!tier || !TIERS.includes(tier)) {
    console.log("Available Tiers:");
    TIERS.forEach((r, i) => console.log(`  ${i + 1}. ${r}`));
    let ans = await prompt("Select Tier (1-3): ");
    tier = TIERS[parseInt(ans) - 1];
    if (!tier) {
      console.log("❌ Invalid choice. Please select a number between 1 and 3.\n");
    }
  }

  console.log(`\nInitializing AI-Native Repository...`);
  console.log(`Target : ${targetDir}`);
  console.log(`Runtime: ${runtime}`);
  console.log(`Tier   : ${tier}`);
  if (isDryRun) console.log(`[DRY RUN] No files will be written.\n`);

  const templateDir = path.join(__dirname, '..', 'templates', runtime, tier);
  
  if (!fs.existsSync(templateDir)) {
    console.error(`❌ Error: Template not found at ${templateDir}. This CLI distribution might be incomplete.`);
    process.exit(1);
  }

  let hasConflict = false;

  // Recursive copy with conflict detection
  function copyDir(src, dest) {
    if (!fs.existsSync(dest)) {
      if (!isDryRun) fs.mkdirSync(dest, { recursive: true });
    }
    const entries = fs.readdirSync(src, { withFileTypes: true });
    for (const entry of entries) {
      const srcPath = path.join(src, entry.name);
      const destPath = path.join(dest, entry.name);
      
      if (entry.isDirectory()) {
        copyDir(srcPath, destPath);
      } else {
        if (fs.existsSync(destPath)) {
          const srcContent = fs.readFileSync(srcPath, 'utf8');
          const destContent = fs.readFileSync(destPath, 'utf8');
          if (srcContent === destContent) {
            console.log(`  Skip     : ${path.relative(targetDir, destPath)} (identical)`);
          } else {
            console.log(`  Conflict : ${path.relative(targetDir, destPath)} already exists! Skipping...`);
            hasConflict = true;
          }
        } else {
          console.log(`  Create   : ${path.relative(targetDir, destPath)}`);
          if (!isDryRun) fs.copyFileSync(srcPath, destPath);
        }
      }
    }
  }

  copyDir(templateDir, targetDir);
  
  // Write the manifest
  const manifestPath = path.join(targetDir, 'anr.yaml');
  const manifestContent = [
    `schema_version: "2.0"`,
    `repository:`,
    `  kind: "consumer-repository"`,
    `  standard: "AI-Native Repository Standard"`,
    `runtime:`,
    `  name: "${runtime}"`,
    `tier: "${tier}"`,
    `template:`,
    `  version: "${CLI_VERSION}"`
  ].join('\n') + '\n';

  if (fs.existsSync(manifestPath)) {
     console.log(`  Conflict : anr.yaml already exists! Skipping...`);
     hasConflict = true;
  } else {
     console.log(`  Create   : anr.yaml (Machine-readable manifest)`);
     if (!isDryRun) fs.writeFileSync(manifestPath, manifestContent);
  }

  if (!isDryRun) console.log(`\n✅ Success! Your repository is now an AI-Native workspace.`);
  
  if (hasConflict) {
    console.log(`\n⚠️ Note: Some files were skipped due to conflicts. Please review them manually.`);
    process.exit(2);
  }
}

module.exports = {
  versionCommand,
  listCommand,
  doctorCommand,
  validateCommand,
  initCommand
};
