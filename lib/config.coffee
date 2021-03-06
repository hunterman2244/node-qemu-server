fs         = require 'fs'

qmpPorts   = {}
vncPorts   = {}
spicePorts = {}

qmpPorts[Number port+15000]  = false for port in [1..255]
vncPorts[Number port]        = false for port in [1..255]
spicePorts[Number port+15300]= false for port in [1..255]

module.exports.setToUsed = (proto, port) ->
  switch proto
    when 'qmp'   then qmpPorts[Number port]   = true
    when 'vnc'   then vncPorts[Number port]   = true
    when 'spice' then spicePorts[Number port] = true

module.exports.getFreeQMPport = ->
  for port,used of qmpPorts
    if not used
      @setToUsed 'qmp', port
      return Number port

module.exports.getFreeVNCport = ->
  for port,used of vncPorts
    if not used
      @setToUsed 'vnc', port
      return Number port

module.exports.getFreeSPICEport = ->
  for port,used of spicePorts
    if not used
      @setToUsed 'spice', port
      return Number port


module.exports.getIsoFiles = ->
  isoFiles = fs.readdirSync "#{process.cwd()}/isos/"
  isos     = []
  for isoName in isoFiles
    if 0 < isoName.search /\.iso$/
      isos.push isoName
  return isos


module.exports.getDiskFiles = ->
  diskFiles = fs.readdirSync "#{process.cwd()}/disks/"
  disks     = []
  for diskName in diskFiles
    if 0 < diskName.search /\.img$/
      disks.push diskName
  return disks


module.exports.getVmConfigs = ->
  vmFiles = fs.readdirSync "#{process.cwd()}/vmConfigs"
  vms     = []
  for vmName in vmFiles
    if 0 < vmName.search /\.json$/
      vms.push vmName
  return vms


module.exports.getVmHandlerExtensions = ->
  filesIn = fs.readdirSync "#{process.cwd()}/lib/src/vmHandlerExtensions"
  files = {}
  for file in filesIn
    files[file.split('.')[0]] = true
  out = []
  
  for i of files
    out.push i
  
  return out


# ls #{process.cwd()}/isos/*.iso|sort -f