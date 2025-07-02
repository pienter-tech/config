#!/Users/korneel/.nodenv/versions/22.15.0/bin/node

// @raycast.schemaVersion 1
// @raycast.title scripts/obsidian/journal/daily-add-plan-line
// @raycast.mode compact
// @raycast.argument1 { "type": "text", "placeholder": "Plan entry description" }
// @raycast.argument2 { "type": "text", "placeholder": "Time (HH:MM)", "optional": true }
// @raycast.icon 📝
// @raycast.packageName Obsidian Journal: Add to dail plan
// @raycast.author pienter-tech
// @raycast.authorURL https://github.com/pienter-tech

import { execSync } from 'child_process';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import path from 'path';

// Configuration - adjust these paths to match your setup
const VAULT_PATH = '/Users/korneel/Obsidian/two/journal/daily/';

function main() {
  try {
    const planEntry = process.argv[2];
    const timeArg = process.argv[3];

    if (!planEntry) {
      console.warn('Please provide a plan entry description');
      process.exit(1);
    }

    // Get current date and time
    const now = new Date();
    const dateStr = now.toISOString().split('T')[0]; // YYYY-MM-DD format

    let timeStr;
    if (timeArg) {
      // Validate HH:MM format
      const match = timeArg.match(/^([01]\d|2[0-3]):([0-5]\d)$/);
      if (!match) {
        console.warn('Invalid time format. Use HH:MM (24-hour).');
        process.exit(1);
      }
      timeStr = `${match[1]}:${match[2]}`;
    } else {
      const now = new Date();
      timeStr = now.toTimeString().slice(0, 5); // HH:MM
    }

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

    const planSectionRegex = /## Plan\n?\n([\s\S]*?)(?=\n## |$)/;
    const match = content.match(planSectionRegex);

    if (!match) {
      console.warn('Plan section not found in the journal file');
      process.exit(1);
    }

    // Create the new plan entry
    const newEntry = `- *${timeStr}* ${planEntry}`;

    // Find the position to insert the new entry
    const planContent = match[1];
    const lines = planContent.split('\n');

    // Find the right position to insert (chronologically)
    let insertIndex = lines.length;
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      if (line.startsWith('- *') && line.includes('*')) {
        const timeMatch = line.match(/\*(\d{2}:\d{2})\*/);
        if (timeMatch) {
          const lineTime = timeMatch[1];
          if (timeStr < lineTime) {
            insertIndex = i;
            break;
          }
        }
      }
    }

    // Insert the new entry
    lines.splice(insertIndex, 0, newEntry);
    const updatedPlanContent = lines.join('\n');

    // Replace the plan section in the content
    const updatedContent = content.replace(
      planSectionRegex,
      `## Plan\n${updatedPlanContent}`,
    );

    // Write back to file
    writeFileSync(filePath, updatedContent, 'utf8');

    console.log(`Added plan entry: ${newEntry}`);
  } catch (error) {
    console.warn(`Error: ${error.message}`);
    process.exit(1);
  }
}

main();
