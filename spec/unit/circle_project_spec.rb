describe "CircleProject" do
  describe "#branch" do
    it "returns the value set for the branch" do
      project = CircleProject.new(
        name: "my-project",
        token: "abc123",
        branch: "dev",
      )
      expect(project.branch).to eq("dev")
    end

    it "returns 'master' if no value is set for the branch" do
      project = CircleProject.new(
        name: "my-project",
        token: "abc123",
      )
      expect(project.branch).to eq("master")
    end
  end

  describe "#rebuild" do
    it "sends a request to rebuild the branch" do
      circleci_project = double
      expect(circleci_project).to receive(:build_branch).with("dev")

      allow(CircleCi::Project).to receive(:new) do |org, repo, vcs, config|
        expect(org).to eq("18f")
        expect(repo).to eq("fake-repo")
        expect(vcs).to eq("github")
        expect(config.token).to eq("fake-token")
        circleci_project
      end

      CircleProject.new(
        name: "fake-repo",
        token: "fake-token",
        branch: "dev",
      ).rebuild
    end
  end
end
