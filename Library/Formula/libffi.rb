require 'brewkit'

class Libffi <Formula
  @version='3.0.8'
  @url='ftp://sourceware.org/pub/libffi/libffi-3.0.8.tar.gz'
  @homepage='http://sources.redhat.com/libffi/'
  @md5='188a4f79fdac2310044b44b7d3918ef9'
  @sha1='ce44d10c39d9a37479c8777e206cac0f36c48712'

  def patches
    host = "http://trac.macports.org"
    base = "export/57218/trunk/dports/devel/libffi/files"
    ["#{host}/#{base}/patch-includedir.diff"]
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make install"
  end
end
