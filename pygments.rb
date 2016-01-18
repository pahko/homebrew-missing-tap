class Pygments < Formula
  desc "Pygments is a syntax highlighting package written in Python"
  homepage "http://pygments.org/"
  url "https://pypi.python.org/packages/source/P/Pygments/Pygments-2.1.tar.gz"
  sha256 "13a0ef5fafd7b16cf995bc28fe7aab0780dab1b2fda0fc89e033709af8b8a47b"

  depends_on :python if MacOS.version <= :snow_leopard

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
