require 'brewkit'

class Icu4 <Formula
  @version="4.2.1"
  @url='http://download.icu-project.org/files/icu4c/4.2.1/icu4c-4_2_1-src.tgz'
  @homepage='http://icu-project.org/'
  @md5='e3738abd0d3ce1870dc1fd1f22bba5b1'
  @workdir='source'

  def install
    # Have to remove the -arch because ICU ./configure takes that as a sign
    # to use big endian for icudt42. I can't believe this took me as long as
    # it did to figure out. :/
    ENV['LDFLAGS'] = ENV['LDFLAGS'].gsub '-arch x86_64', ''

    system "chmod", "+x", "runConfigureICU configure install-sh"
    system "./runConfigureICU",
            "MacOSX",
            "--prefix=#{prefix}",
            "--with-library-bits=64",
            "--disable-samples"

    system "make install"
  end
end
