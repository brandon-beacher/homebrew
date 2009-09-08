require 'brewkit'

class Spidermonkey <Formula
  @version='1.7.0'
  @url='ftp://ftp.mozilla.org/pub/js/js-1.7.0.tar.gz'
  @homepage='https://developer.mozilla.org/en/SpiderMonkey'
  @md5='5571134c3863686b623ebe4e6b1f6fe6'
  @sha1='1a99e8e10cb6600a03ea98895583a8ed42136d1f'
  @workdir='src'

  def deps
      LibraryDep.new 'nspr'
  end

  def patches
    server = "http://trac.macports.org"
    dir = "export/57126/trunk/dports/lang/spidermonkey/files"
    [
        "#{server}/#{dir}/spidermonkey-1.5-build.patch",
        "#{server}/#{dir}/spidermonkey-1.5-threadsafe.diff",
        "#{server}/#{dir}/spidermonkey-1.5-header.diff",
        "#{server}/#{dir}/patch-config-Darwin.mk",
        "#{server}/#{dir}/patch-jsprf.c",
    ]
  end

  def install
    ENV.deparallelize
    
    # Fix up the MacPorts patches
    user = `whoami`.strip
    group = `groups`.split[0].strip
    safe_system "sed", "-i", "",
            "-e", "s|__PREFIX__|#{prefix}|g",
            "-e", "s|__USER__|#{user}|g",
            "-e", "s|__GROUP__|#{group}|g",
            "Makefile.ref"

    # Make Darwin build with readline
    safe_system "sed", "-i", "",
        "-e", "s|JS_EDITLINE|JS_READLINE|g",
        "config/Darwin.mk"

    # Build
    flags = [
      "-I#{HOMEBREW_PREFIX}/include",
      "-IDarwin_OPT.OBJ",
      "-DXP_UNIX",
      "-DJS_STRINGS_ARE_UTF8"
    ].join " "
    system "make",
            "-f", "Makefile.ref",
            "CFLAGS=\"#{flags}\"",
 	          "LIBDIR=\"/lib\"",
 	          "SO_SUFFIX=dylib",
 	          "JS_THREADSAFE=1",
 	          "DEFINES=\"-DJS_C_STRINGS_ARE_UTF8 -DXP_UNIX\""
    system "ranlib Darwin_OPT.OBJ/libjs.a"
    system "make",
            "-f", "Makefile.ref",
            "export",
            "JS_DIST=#{prefix}",
            "SO_SUFFIX=dylib",
            "LIBDIR=\"/lib\""

    # Cleanup the includes
    system "mkdir #{include}/js && mv #{include}/*.h #{include}/js/"
  end
  
end
