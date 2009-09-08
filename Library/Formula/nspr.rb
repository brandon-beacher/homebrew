require 'brewkit'

class Nspr <Formula
  @version='4.8'
  @url='ftp://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.8/src/nspr-4.8.tar.gz'
  @homepage='http://www.mozilla.org/projects/nspr'
  @md5='e0916a72bcc6c427551ea262183fdb26'
  @sha1='ac30ec18bf0d070a9663d1a8c2d258004f3f42ad'
  @workdir='mozilla/nsprpub'

  def install
    ENV.deparallelize
    system "./configure",
            "--prefix=#{prefix}",
            "--disable-debug",
            "--enable-optimize=-O2",
            "--enable-strip",
            "--enable-64bit"
    system "make"
    system "make install"
  end
end
