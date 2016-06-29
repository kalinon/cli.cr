require "../spec_helper"

module Cli::Test::SubcommandFeature
  class Polygon < Cli::Supercommand
    command "triangle", default: true
    command "square"
    command "hexagon"

    module Commands
      class Triangle < Cli::Command
        def run
          puts 3
        end
      end

      class Square < Cli::Command
        def run
          puts 4
        end
      end

      class Hexagon < Cli::Command
        def run
          puts 6
        end
      end
    end
  end

  ::describe "Features" do
    it "Subcommand" do
      io, _ = ::Cli::Test::Stdio.capture do
        Polygon.run(%w(triangle))
        Polygon.run(%w(square))
        Polygon.run(%w(hexagon))
        Polygon.run(%w())
      end
      io.output.gets_to_end.should eq "3\n4\n6\n3\n"
    end
  end
end