module Heroku::Command

  class Clone < BaseWithApp

    def index
      old_app = app
      puts "Cloning #{old_app}"

      old_stack = heroku.info(old_app)[:stack]

      step "creating application"

      name = extract_option("--name")

      new_app = heroku.create(new_app, :stack => old_stack, :name => name)
      step "new app: #{new_app}", 2

      step "cloning addons"
      clone_addons(old_app, new_app)

      step "cloning configuration"
      clone_configuration(old_app, new_app)

      step "cloning repository"
      clone_repository(old_app, new_app)

      step "cloning collaborators"
      clone_collaborators(old_app, new_app)
    end

  private ######################################################################

    def clone_addons(old_app, new_app)
      old_addons = heroku.installed_addons(old_app).map { |a| a["name"] }
      current_addons = heroku.installed_addons(new_app).map { |a| a["name"] }

      (old_addons - current_addons).each do |addon|
        step "installing #{addon}", 2
        begin
          heroku.install_addon(new_app, addon)
        rescue Exception => e
          print "* could not install #{addon}: #{e.message}"
        end
      end
    end

    def clone_configuration(old_app, new_app)
      old_config = heroku.config_vars(old_app)
      heroku.add_config_vars(new_app, old_config)
      old_config.keys.sort.each { |key| step(key, 2) }
    end

    def clone_repository(old_app, new_app)
      tempfile = Tempfile.new("heroku-clone")
      tempdir = tempfile.path
      tempfile.delete
      FileUtils.mkdir_p(tempdir)
      Dir.chdir(tempdir) do
        %x{ git clone git@#{heroku.host}:#{old_app}.git . }
        %x{ git remote add clone git@#{heroku.host}:#{new_app}.git }
        %x{ git push clone master }
      end
     FileUtils.rm_rf(tempdir)
    end

    def clone_collaborators(old_app, new_app)
      old_collabs = heroku.list_collaborators(old_app).map { |c| c[:email] }
      new_collabs = heroku.list_collaborators(new_app).map { |c| c[:email] }
      (old_collabs - new_collabs).each do |collab|
        step "adding #{collab}", 2
        heroku.add_collaborator(new_app, collab)
      end
    end

    def step(message, indent=1)
      print "  " * indent
      print "* "
      puts message
    end

    def extract_option(options, default=true)
      values = options.is_a?(Array) ? options : [options]
      return unless opt_index = args.select { |a| values.include? a }.first
      opt_position = args.index(opt_index) + 1
      if args.size > opt_position && opt_value = args[opt_position]
        if opt_value.include?('--')
          opt_value = nil
        else
          args.delete_at(opt_position)
        end
      end
      opt_value ||= default
      args.delete(opt_index)
      block_given? ? yield(opt_value) : opt_value
    end   
  end
end
