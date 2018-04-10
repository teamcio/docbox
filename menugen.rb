require 'yaml'
require 'erb'

config = YAML.load_file('./content/config.yaml')

content = ERB.new(<<-BLOCK).result(binding)
var fs = require('fs');

/**
 * This file exports the content of your website, as a bunch of concatenated
 * Markdown files. By doing this explicitly, you can control the order
 * of content without any level of abstraction.
 *
 * Using the brfs module, fs.readFileSync calls in this file are translated
 * into strings of those files' content before the file is delivered to a
 * browser: the content is read ahead-of-time and included in bundle.js.
 */
module.exports = <% config['menu'].map do |x| %>
'<%= x['section'] %>\\n' + fs.readFileSync('./content/<%= x['file'] %>', 'utf8') + '\\n'
<%= x.equal?(config['menu'].last) ? ';' : '+' %>
<% end %>
BLOCK

File.write('./src/custom/content.js', content)
