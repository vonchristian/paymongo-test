module ApplicationHelper
  def time_elapsed(datetime)
    seconds = (Time.current - datetime).to_i

    days = seconds / (24 * 3600)
    hours = (seconds % (24 * 3600)) / 3600
    minutes = (seconds % 3600) / 60

    parts = []
    parts << "#{days}d" if days.positive?
    parts << "#{hours}h" if hours.positive?
    parts << "#{minutes}m" if minutes.positive? || parts.empty?

    parts.join(" ")
  end
end
