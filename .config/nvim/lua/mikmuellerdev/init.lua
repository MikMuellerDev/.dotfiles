_G.is_android = vim.fn.executable('uname') == 1 and vim.fn.system('uname -o') == 'Android\n'

require('mikmuellerdev.packer')
require('mikmuellerdev.mappings')
