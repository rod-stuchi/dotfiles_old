#! /bin/node
const fs = require("fs");
const readline = require("readline");
const { usage } = require("./usage");
const { make } = require("./make");

(async () => {
  const help = process.argv[2];

  if (help === "--help" || help === "-h") {
    usage();
    process.exit(0);
  }

  if (help === "--make" || help === "-m") {
    await make();
    process.exit(0);
  }

  const file = (process.argv[2] || "");

  if (!file.length) {
    console.log("\x1b[91mInvalid arguments\x1b[0m");
    usage();
    process.exit(1);
  }

  console.log(`  📝 file: ${file}`);

  const read = readline.createInterface({
    input: fs.createReadStream(file)
  });

  let result = [];
  read.on("line", (line) => {
    // escape comment lines #
    if (/^#/.test(line)) return;

    // not a number 0-9
    if (/^\D+/.test(line)) {
      if (/^RESULT/.test(line)) {
        result = line
          .replace(/RESULT:\s*/g, "")
          .trim()
          .replace(/[\+\-\_ .,]/g, "#")
          .split("#")
          .sort((x, y) => x > y ? 1 : -1);

        console.log(
          `  ✅ result: ${result.map(x => `\x1b[32m${x}\x1b[0m`).join(" ")}`
        );
      } else {
        console.log(`\n\x1b[3;1;93m${line}\x1b[0m`);
      }
      // start with number 0-9
    } else if (/^\d+/.test(line)) {
      const arr = line
        .replace(/[\+\-\_ .,]/g, "#")
        .split("#")
        .sort((x, y) => (x > y ? 1 : -1));

      arrColor = arr.map(x => (result.includes(x) ? `\x1b[48;5;34;1;15m${x}\x1b[0m` : x));

      const count = arr.filter(x => result.includes(x)).length;
      const countColor = () => {
        switch(count) {
          case 6: 
            return `  \x1b[48;5;28;1;15m[ ${count} ]\x1b[0m 💰`;
          case 0:
            return `  \x1b[48;5;4;15m[ ${count} ]\x1b[0m`;
          default:
            return `  \x1b[48;5;19;15m[ ${count} ]\x1b[0m`;
        }
      }

      console.log("    ", arrColor.join(" "), countColor());
    }
  });

  read.on("close", () => {
    process.exit(0);
  });
})();
