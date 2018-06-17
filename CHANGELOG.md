## 2018-06-17 - Release 0.4.0
### Summary
 - Adding support for Ubuntu 16.04 and CentOS 7 / systemd (PR #15)
 - Adding support for setting `java_home` and `java_opts` (PR #15)

## 2017-12-16 - Release 0.3.1
### Summary
 - Make the service user's home directory customizable. (PR #14)

## 2017-02-04 - Release 0.3.0
### Summary
 - FISHEYE_INST should not be a literal path (Issue #9)
 - What License is governing this Module? (Issue #11)
 - Making the download URL customisable to allow using an alternate download URL. (PR #12)

#### Upgrading to 0.3.0
 - `FISHEYE_INST` (the location where the fisheye/crucible data is stored) default location has been moved from /opt/FISHEYE_INST to /opt/crucible-data. If you're upgrading from a version <= 0.2.1 you should do one of the following:

   1. Explicitly set your FISHEYE_INST to the old data directory:
   ```
   class { ::crucible
    fisheye_inst => '/opt/FISHEYE_INST'
   }
   ```
   1. Execute the new version of the `johnlawerance/crucible` puppet module and after it runs copy the contents of your old $FISHEYE_INST data directory to the newly laid down `/opt/crucible-data`.

## 2016-10-18 - Release 0.2.1
### Summary
 - Fixed the version regex validation (Issue #7)

## 2016-04-17 - Release 0.2.0
### Summary
 - Adding Ubuntu 12.04 and 14.04 support

## 2016-03-29 - Release 0.1.2
### Summary
 - Adding support for separate fisheye data dir. This will allow easier upgrades and a better separation of application and data.


## 2016-02-27 - Release 0.1.1
### Summary
- Fixed puppet-lint errors
- Fixed metadata java/stdlib dependency info
- Fixed install_java param not actually being used

## 2016-02-26 - Release 0.1.0
### Summary
 - Initial Release
