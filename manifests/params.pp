# Class: gitolite::params
#
class gitolite::params {
  $group_name      = 'git'
  $user_name       = 'git'
  $group_ensure    = true
  $user_ensure     = true
  $home_path       = "/home/${user_name}"
  $source_type     = 'git'
  $package_version = present
  $source_path     = 'git://github.com/sitaramc/gitolite'
  $key_user        = undef
  $pubkey          = undef
  $manage_perl     = false
  $umask           = '0077'

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '5': { $perl_package = 'perl-Time-modules' }
        '6': { $perl_package = 'perl-Time-HiRes' }
        default: {
          fail("Gitolite supports RedHat 5 and 6. Detected version is <${::operatingsystemmajrelease}>.")
        }
      }
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '6','7': {
            $perl_package = 'libtime-hires-perl'
            }
            default: {
              fail("Gitolite supports Debian 6 and 7. Detected version is <${::operatingsystemmajrelease}>.")
            }
          }
        }
        'Ubuntu': {
          case $::operatingsystemmajrelease {
            '12.04': {
            $perl_package = 'libtime-hires-perl'
            }
            default: {
              fail("Gitolite supports Ubuntu 12.04. Detected version is <${::operatingsystemmajrelease}>.")
            }
          }
        }
        default: {
          fail("Gitolite supports operatingsystems Debian and Ubuntu within the osfamily Debian. Detected operatingsystem is <${::operatingsystem}>.")
        }
      }
    }
    default: {
      fail("Gitolite supports osfamilies RedHat and Debian. Detected osfamily is <${::osfamily}>.")
    }
  }
}
