# Logikcull
Logikcull assignment 

# LoadFile

## Overview

This assignment is intended to model a typical request to add new features to our document processing pipeline. As part of our team, you will be asked to work independently on such features, select a solution that can be completed in 4-6 hours but not more than 8, and submit that feature for collaborative review by one or more colleagues.

## Context

Logikcull customers can import pre-processed documents into Logikcull by providing an archive in either a ZIP or TAR format. The archive must contain a LoadFile and the actual documents to be imported. The LoadFile contains case-specific information about a document like 'control number' used to uniquely identify documents, a 'volume' to group documents into a collection, and a relative path to the actual document provided in the corresponding archive. When parsing a LoadFile we track 'control number', and 'volume' which are used elsewhere in Logikcull and also the 'image path' which tells us the location of the document in the archive.

## Build and Test

The LoadFile project requires Ruby 2.4 and bundler. It is up to you to decide how you want you to install Ruby. There is a `.ruby-version` for use with rbenv or rvm. You'll need to install bundler and the gem dependencies before we start.

``` shell
rvm install "ruby-2.4.1"
gem install bundler rake minitest nokogiri
bundle install --path .vendor --binstubs
```

With Ruby and the gems installed we can run our tests

``` shell
bundle exec rake test
``
I am using Ubuntu 18.04 and installed these to add Ruby
    sudo apt install git devtools sublime-text build-essential patch ruby-dev zlib1g-dev liblzma-dev
    sudo apt-add-repository -y ppa:rael-gc/rvm
    sudo apt-get update
    sudo apt-get install rvm

## Tasks

1. Added support for XLF and LFP formats
2. Added basic validation and invalidation to load_file_entry

## Load File Formats

LFP format

``` csv
IM,test-000001,S,0,@Import Test 01;IMAGES/001/;test-000001.tif;2,0
IM,test-000002,C,0,@Import Test 01;IMAGES/001/;test-000002.tif;2,0
IM,test-000003,D,0,@Import Test 01;IMAGES/001/;test-000003.tif;2,0
```

XLF load file:

``` xml
<loadfile>
  <entries>
    <entry control-number="test-000001">
        <volume>Import Test 01</volume>
        <image-path>IMAGES/001/</image-path>
        <image-name>test-000001.tif</image-name>
    </entry>
  </entries>
</loadfile>
```

All load file formats resolve to the following data:

| Control Number | Volume         | Path                       |
| -------------- | -------------- | -------------------------- |
| test-000001    | Import Test 01 | IMAGES/001/test-000001.tif |
| test-000002    | Import Test 01 | IMAGES/001/test-000002.tif |
| test-000003    | Import Test 01 | IMAGES/001/test-000003.tif |


