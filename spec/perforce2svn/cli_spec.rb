require 'perforce2svn/cli'
require 'perforce2svn/errors'
require 'spec_helper'

module Perforce2Svn

  module CLIHelper
    def parse(*args)
      cli = CLI.new([])
      cli.parse_options(args)
      cli.options
    end
  end

  describe 'Command Line Interface' do
    include CLIHelper

    it "should be able to parse the debug flag correctly" do
      parse("--debug")[:debug].should be(true)
    end

    it "should be able to retrieve the repository path" do
      parse('-r', 'some/path')[:repository].should eql('some/path')
    end

    it "should be able to parse the live path" do
      parse('-l', 'live/path')[:live_path].should eql('live/path')
    end

    it "should be able to skip updates" do
      parse('--skip-updates')[:skip_updates].should be(true)
    end

    it "should be able to skip perforce" do
      parse('--skip-perforce')[:skip_perforce].should be(true)
    end

    it "should be able to run the analysis only" do
      parse('-a')[:analyze].should be(true)
    end

    describe "validation activity" do
      it "should fail when the start revision is less than 1" do
        attempting_to { parse('-c', '0-4') }.should raise_error(Perforce2Svn::ConfigurationError, /change/)
      end
    end

  end
end
