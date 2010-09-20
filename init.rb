require "heroku/command/app"

Heroku::Command::Help.group("Cloning") do |group|
  group.command "clone", "clone an app"
end
