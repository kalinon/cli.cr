require "../../spec_helper"

module CliHandlingExitFeatureDetail
  include Cli::Spec::Helper

  macro test(run, code = 0, sout = nil, err = nil)
    class Exit%x < Cli::Command
      class Help
        title "title"
      end
      def run
        {{run.id}}
      end
    end
    describe name do
      it {{run}} do
        Exit%x.run.should exit_command(code: {{code}}, output: {{sout}}, error: {{err}})
      end
    end
  end

  test %(exit!)
  test %(exit! "message"), sout: "message"
  test %(exit! "message", error: true), err: "message", code: 1
  test %(exit! "message", code: 22), err: "message", code: 22
  test %(error! "message"), err: "message", code: 1
  test %(error! "message", code: 22), err: "message", code: 22
  test %(help!), sout: "title"
  test %(help! "message"), err: "message\n\ntitle", code: 1
  test %(help! "message", code: 22), err: "message\n\ntitle", code: 22
  test %(help! "message", error: false), sout: "message\n\ntitle"
end
