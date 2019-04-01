import path from 'path';
const { spawn } = require('child_process'); // See https://github.com/calvinmetcalf/rollup-plugin-node-builtins/issues/50

/**
 * @public
 * Run test script from node
 * @param yarn
 * @param noSonar
 * @param cb
 */
export default function test({ yarn, noSonar }, cb) {
  const args = [];
  if (yarn) {
    args.push('--yarn');
  }
  if (noSonar) {
    args.push('--no-sonar');
  }
  const ls = spawn('bash', [path.join(__dirname, 'test.sh')].concat(args), { stdio: 'inherit' });
  ls.on('close', (code) => {
    if (cb) {
      cb(null, code);
    }
  });
}
