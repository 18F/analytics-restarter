require "json"
require "circleci"

module Restarter
  class CircleProject
    attr_reader :name, :token

    def initialize(name:, token:, branch: nil)
      @name = name
      @token = token
      @branch = branch
    end

    def branch
      @branch || "master"
    end

    def rebuild
      circle_config = CircleCi::Config.new(token: token)
      project = CircleCi::Project.new(
        "18f",
        name,
        "github",
        circle_config,
      )
      project.build_branch branch
    end
  end
end
