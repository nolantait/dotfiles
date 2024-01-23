home = ENV["HOME"]

unless File.exist?(path = "#{home}/.irb/history")
  FileUtils.mkdir_p "#{home}/.irb"
  FileUtils.touch "#{home}/.irb/history"
end

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{home}/.irb/history"
IRB.conf[:AUTO_INDENT]  = true

### Rails
# Some features that make using irb for rails much nicer.
if rails_env = ENV["RAILS_ENV"]
  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{rails_root}|> ",
    :PROMPT_S => "#{rails_root}|* ",
    :PROMPT_C => "#{rails_root}|? ",
    :RETURN   => "=> %s\n" 
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.instance_eval { alias :[] :find }
  end
end

begin
  require "amazing_print"
rescue LoadError => e
  warn "Could not load amazing_print: #{e}"
end
