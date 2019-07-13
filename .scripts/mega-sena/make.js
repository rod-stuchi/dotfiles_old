const fs = require("fs");
const readline = require("readline");

const rc = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const make = async () => {
  console.log(process.cwd());
  const sampleFile = `
RESULT: 02-19-24-27-31-32

jogo 01
02 19 24 27 31 32
25+28+32+39+50+56
07.16.17.29.35.53

jogo 02
01-24-27-40-56-60
02_25_46_47_48_51
`;

  const resp = await new Promise((resolve, reject) => {
    rc.question("Mega-Sena número do concurso [xxxx]?\n", function(answer) {
      rc.close();
      resolve(answer);
    });
  });

  fs.writeFileSync(`${process.cwd()}/concurso-${resp}.txt`, sampleFile);
  process.exit(0);
}

module.exports = { make };
