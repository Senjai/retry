require_relative '../automated_init'

context "Error Raised" do
  context "Error Does Not Recur" do
    context do
      count = 0

      Retry.() do |i|
        count += 1
        fail if i == 0
      end

      test "Action is retried" do
        assert(count == 2)
      end
    end

    context "Count of Retries" do
      retries = Retry.() do |i|
        fail if i == 0
      end

      test "1" do
        assert(retries == 1)
      end
    end
  end

  context "Error Recurs" do
    test "Error is raised" do
      assert proc { Retry.() { fail } } do
        raises_error? RuntimeError
      end
    end
  end
end
