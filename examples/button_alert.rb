Shoes.app(title: "Alerting Button", width: 250, height: 250, debug: true) do
  @push = button "Push me"
  @push.click {
    alert "Aha! Click!"
  }
end
