
for mod in ['info', 'create', 'delete']
  module.exports[mod] = require "./disk/#{mod}"

# module.exports.create = require './disk/info'
# module.exports.info   = require './disk/create'
# module.exports.delete = require './disk/delete'