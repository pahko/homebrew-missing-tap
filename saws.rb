class Saws < Formula
  desc "A Supercharged AWS Command Line Interface (CLI)"
  homepage "http://bit.ly/git-saws"
  url "https://pypi.python.org/packages/source/s/saws/saws-0.4.0.tar.gz"
  sha256 "3aefcab0b9a37bf030ef8bdd3b2726579b7e797b13aae437f8ef3ffaf28ed753"

  depends_on "awscli"
  depends_on "pahko/missing-tap/pygments"
  depends_on :python if MacOS.version <= :snow_leopard

  resource "awscli" do
    url "https://pypi.python.org/packages/source/a/awscli/awscli-1.9.20.tar.gz"
    sha256 "489e8cb1a8d8ba8bb46278b6d2aa7c17806ca5ec4b9a19517faebb3c479a3b38"
  end

  resource "botocore" do
    url "https://pypi.python.org/packages/source/b/botocore/botocore-1.3.20.tar.gz"
    sha256 "9760d883611110a05f5f8346c7b2198aef87be9117d4cbe1e4ee6608a560c4a2"
  end

  resource "click" do
    url "https://pypi.python.org/packages/source/c/click/click-6.2.tar.gz"
    sha256 "fba0ff70f5ebb4cebbf64c40a8fbc222fb7cf825237241e548354dabe3da6a82"
  end

  resource "colorama" do
    url "https://pypi.python.org/packages/source/c/colorama/colorama-0.3.3.tar.gz"
    sha256 "eb21f2ba718fbf357afdfdf6f641ab393901c7ca8d9f37edd0bee4806ffa269c"
  end

  resource "configobj" do
    url "https://pypi.python.org/packages/source/c/configobj/configobj-5.0.6.tar.gz"
    sha256 "a2f5650770e1c87fb335af19a9b7eb73fc05ccf22144eb68db7d00cd2bcb0902"
  end

  resource "docutils" do
    url "https://pypi.python.org/packages/source/d/docutils/docutils-0.12.tar.gz"
    sha256 "c7db717810ab6965f66c8cf0398a98c9d8df982da39b4cd7f162911eb89596fa"
  end

  resource "enum34" do
    url "https://pypi.python.org/packages/source/e/enum34/enum34-1.1.2.tar.gz"
    sha256 "2475d7fcddf5951e92ff546972758802de5260bf409319a9f1934e6bbc8b1dc7"
  end

  resource "jmespath" do
    url "https://pypi.python.org/packages/source/j/jmespath/jmespath-0.9.0.tar.gz"
    sha256 "08dfaa06d4397f283a01e57089f3360e3b52b5b9da91a70e1fd91e9f0cdd3d3d"
  end

  resource "prompt_toolkit" do
    url "https://pypi.python.org/packages/source/p/prompt_toolkit/prompt_toolkit-0.52.tar.gz"
    sha256 "35b8a34df8dea4cba92222dc1b8700c30ed7a8ba47cf3bc583768c5571a30902"
  end

  resource "pyasn1" do
    url "https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.9.tar.gz"
    sha256 "853cacd96d1f701ddd67aa03ecc05f51890135b7262e922710112f12a2ed2a7f"
  end

  resource "Pygments" do
    url "https://pypi.python.org/packages/source/P/Pygments/Pygments-2.1.tar.gz"
    sha256 "13a0ef5fafd7b16cf995bc28fe7aab0780dab1b2fda0fc89e033709af8b8a47b"
  end

  resource "python-dateutil" do
    url "https://pypi.python.org/packages/source/p/python-dateutil/python-dateutil-2.4.2.tar.gz"
    sha256 "3e95445c1db500a344079a47b171c45ef18f57d188dffdb0e4165c71bea8eb3d"
  end

  resource "rsa" do
    url "https://pypi.python.org/packages/source/r/rsa/rsa-3.3.tar.gz"
    sha256 "03f3d9bebad06681771016b8752a40b12f615ff32363c7aa19b3798e73ccd615"
  end

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "wcwidth" do
    url "https://pypi.python.org/packages/source/w/wcwidth/wcwidth-0.1.6.tar.gz"
    sha256 "dcb3ec4771066cc15cf6aab5d5c4a499a5f01c677ff5aeb46cf20500dccd920b"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[awscli botocore click colorama configobj docutils enum34 jmespath prompt_toolkit pyasn1 Pygments python-dateutil rsa six wcwidth].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
