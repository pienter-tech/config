#!/Users/korneel/.nodenv/versions/22.15.0/bin/node

// @raycast.schemaVersion 1
// @raycast.title sripts/obsidian/journal/daily-add-reflection-line
// @raycast.mode compact
// @raycast.argument1 { "type": "text", "placeholder": "Reflection" }
// @raycast.icon 📝
// @raycast.packageName Obsidian Journal: Add to daily reflect
// @raycast.author pienter-tech
// @raycast.authorURL https://github.com/pienter-tech

import { execSync } from 'child_process';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import path from 'path';

// Configuration - adjust these paths to match your setup
const VAULT_PATH = '/Users/korneel/Obsidian/two/journal/daily/';

function main() {
  try {
    const reflectEntry = process.argv[2];

    if (!reflectEntry) {
      console.warn('Please provide a reflection line');
      process.exit(1);
    }

    // Get current date and time
    const now = new Date();
    const dateStr = now.toISOString().split('T')[0]; // YYYY-MM-DD format

    // Construct file path
    const fileName = `${dateStr}.md`;
    const filePath = path.join(VAULT_PATH, fileName);

    // Check if file exists
    if (!existsSync(filePath)) {
      console.warn(`Journal file for ${dateStr} not found at ${filePath}`);
      process.exit(1);
    }

    // Read the file
    let content = readFileSync(filePath, 'utf8');

    const reflectSectionRegex = /## Reflect\n?\n([\s\S]*?)(?=\n\[<<<|$)/;
    const match = content.match(reflectSectionRegex);

    if (!match) {
      console.warn('Reflect section not found in the journal file');
      process.exit(1);
    }

    // Find the position to insert the new entry
    const reflectContent = match[1];
    const lines = reflectContent.split('\n');

    lines.push(reflectEntry);

    const updatedSectionContent = lines.join('\n') + '\n';

    // Replace the plan section in the content
    const updatedContent = content.replace(
      reflectSectionRegex,
      `## Reflect\n${updatedSectionContent}`,
    );

    // Write back to file
    writeFileSync(filePath, updatedContent, 'utf8');

    console.log(`Added reflect entry: ${reflectEntry}`);
  } catch (error) {
    console.warn(`Error: ${error.message}`);
    process.exit(1);
  }
}

main();
