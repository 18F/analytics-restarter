require "json"

describe "CircleProjectLoader" do
  before do
    vcap_services = {
      "user-provided" => [
        "name" => "circleci",
        "credentials" =>  {
          "FIRST_APP" => {
            "NAME" => "first_app",
            "TOKEN" => "123abc",
          }.to_json,
          "SECOND_APP" => {
            "NAME" => "second_app",
            "TOKEN" => "456def",
            "BRANCH" => "dev",
          }.to_json,
        },
      ],
    }
    ENV["VCAP_SERVICES"] = vcap_services.to_json
  end

  after do
    ENV.delete("VCAP_SERVICES")
  end

  describe "#load_projects" do
    it "loads an array of circle projects from the user provided service" do
      projects = CircleProjectLoader.new.load_projects
      expect(projects.length).to eq(2)
      expect(projects[0].name).to eq("first_app")
      expect(projects[0].token).to eq("123abc")
      expect(projects[0].branch).to eq("master")
      expect(projects[1].name).to eq("second_app")
      expect(projects[1].token).to eq("456def")
      expect(projects[1].branch).to eq("dev")
    end
  end
end
