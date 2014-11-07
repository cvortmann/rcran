## App Usage

To start the server:

    $ bundle install
    $ foreman start

The server runs at http://localhost:9292.
Another process runs a scheduled download of packages that happen every day at 12:00.

To download packages outside of the scheduled time:

    $ bundle exec rake packages:download

## Dependencies

* Ruby    (2.1.3)
* Mongo   (2.6.5)
* Bundler (1.7.4)

## Organization

Most of the code lives under /entities.
Every object tend to have a single responsibility and be very small.
This code would probably be moved around later.

There 2 classes under /jobs.
DownloadVersionsJob is the main job to download new versions and the one
that runs in a scheduled time. VersionSaverJob is a helper job (would be
eventually renamed to worker) that downloads a package's tar.gz and save
a new version from the DESCRIPTION file inside.

Configuration lives in /config.
Currently there's only development and test environments configurations for
Mongo.

Views live under /views.

Specs live under /spec. Test were written using RSpec and can be run by simply
entering in your prompt:

    $ rspec

Basic error treament was done around DESCRIPTION files that contain characters
that can't be automatically converted to UTF-8. Packages that contain those
DESCRIPTION files are not being saved, for now.

Packages that are already saved don't lead to creation of new VersionSaverJobs.

Currently all data is saved and presented as strings. First priority is
to parse the DESCRIPTION file fields to appropriate data types. Since there's
no pagination or search functionality yet, all results are presented in a single
page so the user can make use of the browser's built-in search functionality
to search for packages.

Some basic benchmarks (using Ruby's Benchmark: [http://www.ruby-doc.org/stdlib-2.1.3/libdoc/benchmark/rdoc/Benchmark.html](http://www.ruby-doc.org/stdlib-2.1.3/libdoc/benchmark/rdoc/Benchmark.html)) of DownloadVersionsJob total time:

<table>
    <tr>
        <td>Version</td>
        <td>Time (seconds)</td>
        <td>What?</td>
    </tr>
    <tr>
        <td>Plain Ruby</td>
        <td>2343.121483</td>
        <td>Download 5964 packages.</td>
    </tr>
    <tr>
        <td>Plain Ruby</td>
        <td>63.585663</td>
        <td>Download the PACKAGES file and try to download the packages that were not in db (roughly 70 packages).</td>
    </tr>
    <tr>
        <td>Celluloid</td>
        <td>843.966650</td>
        <td>Download 5964 packages.</td>
    </tr>
    <tr>
        <td>Celluloid</td>
        <td>54.220385</td>
        <td>Download the PACKAGES file and try to download the packages that were not in db (roughly 70 packages).</td>
    </tr>
</table>
