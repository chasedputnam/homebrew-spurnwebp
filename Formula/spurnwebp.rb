# Classname should match the name of the installed package.
class Spurnwebp < Formula
  desc "CLI for converting webp to png and jpg"
  homepage "https://github.com/chasedputnam/spurnwebp"

  # Source code archive. Each tagged release will have one
  url "https://github.com/chasedputnam/spurnwebp/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "e0260b062b0dd34e96bb07adecdcdc4feadb8331510967bcc880d3f79e7b51fc"
  head "https://github.com/chasedputnam/spurnwebp"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/chasedputnam/spurnwebp"
    # Copy all files from their current location (GOPATH root)
    # to $GOPATH/src/github.com/chasedputnam/spurnwebp
    bin_path.install Dir["*"]
    cd bin_path do
      # Install the compiled binary into Homebrew's `bin` - a pre-existing
      # global variable
      system "go", "build", "-o", bin/"spurnwebp", "."
    end
  end

  # Homebrew requires tests.
  test do
    assert_match "spurnwebp version 0.0.2", shell_output("echo 2", 2)
  end
end
