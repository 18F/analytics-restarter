require "circleci"
require "logger"

module Restarter
  autoload :CircleProject, "./lib/restarter/circle_project"
  autoload :CircleProjectLoader, "./lib/restarter/circle_project_loader"
  autoload :IntervalCalculator, "./lib/restarter/interval_calculator"

  class << self
    def restart
      logger = Logger.new(STDERR)
      logger.level = Logger::INFO

      interval = IntervalCalculator.new.calculate_interval
      Thread.new do
        begin
          logger.info "Restarting in #{interval} seconds"
          sleep interval
          CircleProjectLoader.new.load_projects.each do |project|
            logger.info "Restarting #{project.name}"
            project.rebuild
          end
        rescue StandardError => e
          logger.error(e)
        end
        restart
      end
    end
  end
end
