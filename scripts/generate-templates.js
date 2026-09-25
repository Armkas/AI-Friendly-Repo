#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const runtimes = ['claude-code', 'codex', 'gemini-cli', 'cursor'];
const tiers = ['light', 'standard', 'full'];

const srcDir = path.join(__dirname, '..', 'template-source');
// We generate them directly into the CLI package so it can be packed
const outDir = path.join(__dirname, '..', 'cli', 'templates');

function copyRecursive(src, dest) {
  if (!fs.existsSync(src)) {
    console.error(`❌ FATAL: Required template source missing: ${src}`);
    process.exit(1);
  }
  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest, { recursive: true });
  }
  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyRecursive(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

console.log("Generating 12 AI-Native Template combinations...");
fs.rmSync(outDir, { recursive: true, force: true });
fs.mkdirSync(outDir, { recursive: true });

for (const runtime of runtimes) {
  for (const tier of tiers) {
    const targetDir = path.join(outDir, runtime, tier);
    console.log(` -> ${runtime} / ${tier}`);
    fs.mkdirSync(targetDir, { recursive: true });
    
    // 1. Copy tier common files
    const tierSrc = path.join(srcDir, 'common', tier);
    copyRecursive(tierSrc, targetDir);

    // 2. Copy runtime specific files
    const runtimeSrc = path.join(srcDir, 'runtimes', runtime);
    copyRecursive(runtimeSrc, targetDir);
  }
}

console.log("Templates generated successfully in cli/templates/");
