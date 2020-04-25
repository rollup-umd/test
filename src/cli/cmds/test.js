import test from '../..';

export const builder = (yargs) => yargs
  .option('yarn', {
    describe: 'Use yarn for install',
    type: 'boolean',
    default: false,
  })
  .option('no-sonar', {
    describe: 'Skip sonar scan',
    type: 'boolean',
    default: false,
  });
export const command = ['*', 'test'];
export const desc = 'Run test jobs';
export const handler = (argv) => {
  test(argv, (err, code) => {
    if (code !== 0) {
      console.log(`ps process exited with code ${code}`); // eslint-disable-line no-console
      process.exitCode = code;
    }
  });
};
