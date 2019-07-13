const usage = () => {
  console.log(`usage: 
megasena textfile \x1b[3m# process result\x1b[0m
megasena -make    \x1b[3m# create a result file\x1b[0m

ex.:
\x1b[92m$ megasena concuso-x\x1b[0m

Where:
\x1b[92m$ cat concuso-x\x1b[0m
\x1b[94mRESULT: 16 18 31 39 42 44

Jogo1
01.02.03.04.05.06
07.08.09.10.11.12

Jogo2
03 05 07 09 11 13
15 17 19 21 23 25\x1b[0m
`);
};

module.exports = { usage };
