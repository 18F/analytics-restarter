require "json"

module Restarter
  class CircleProjectLoader
    def load_projects
      circleci_service["credentials"].map do |_key, project_data_json|
        project_data = JSON.parse(project_data_json)
        CircleProject.new(
          name: project_data["NAME"],
          token: project_data["TOKEN"],
          branch: project_data["BRANCH"],
        )
      end
    end

    private

    def circleci_service
      uup_services = JSON.parse(ENV["VCAP_SERVICES"])["user-provided"]
      uup_services.detect do |service|
        service["name"] == "circleci"
      end
    end
  end
end
