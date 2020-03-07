const ghpages = require('gh-pages');

ghpages.publish('build/web', { branch: 'gh-pages' }, err => {
  console.error(err);
});
