import test from '../..';

export const builder = (yargs) => yargs
  .option('no-sonar', {
    describe: 'Skip sonar scan',
    type: 'boolean',
    default: false,
  });
export const command = ['*', 'test'];
export const desc = 'Run test jobs';
export const handler = (argv) => test(argv);
