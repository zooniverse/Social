module ZooniverseSocial
  class TaskObserver
    def initialize(task, restart)
      @task = task
      @restart = restart
      @task.add_observer self
    end

    def update(time, result, error)
      if error.is_a?(Concurrent::TimeoutError)
        @task.shutdown
        @restart.call
      end
    end
  end
end
