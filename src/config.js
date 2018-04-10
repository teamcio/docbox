var fs = require('fs'),
    yaml = require('js-yaml');

module.exports = yaml.safeLoad(fs.readFileSync('./content/config.yaml', 'utf8'));
