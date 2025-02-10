%w{rubygems amazing_print irb/completion}.each do |lib|
  begin
    require lib
  rescue LoadError => err
    $stderr.puts "Couldn't load #{lib}: #{err}"
  end
end

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

ANSI_BOLD       = "\033[1m"
ANSI_RESET      = "\033[0m"
ANSI_LGRAY    = "\033[0;37m"
ANSI_GRAY     = "\033[1;30m"
ANSI_BLUE     = "\033[1;33m"
ANSI_RED     = "\033[1;32m"

Reline::Face.config :completion_dialog do |config|
  config.define :default, foreground: :white, background: :black
  config.define :enhanced, foreground: :black, background: :green
  config.define :scrollbar, foreground: :bright_white, background: :black
end

home = ENV["HOME"]
unless File.exist?(path = "#{home}/.irb/history")
  FileUtils.mkdir_p "#{home}/.irb"
  FileUtils.touch "#{home}/.irb/history"
end

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:COMPLETOR] = :type
IRB.conf[:EVAL_HISTORY] = 1_000
IRB.conf[:HISTORY_FILE] = "#{home}/.irb/history"
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:USE_PAGER] = false

IRB.conf[:COMMAND_ALIASES].merge!(
  b: :backtrace,
  c: :continue,
  e: :edit,
  h: :show_cmds,
  i: :info,
  l: :ls,
  n: :next,
  m: :measure,
  s: :step,
  w: :whereami
)

### Rails
# Some features that make using irb for rails much nicer.
if ENV["RAILS_ENV"]
  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT][:RAILS] = {
    PROMPT_I: "#{rails_root}|> ",
    PROMPT_S: "#{rails_root}|* ",
    PROMPT_C: "#{rails_root}|? ",
    RETURN: "==> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.instance_eval { alias :[] :find }
  end
else
  IRB.conf[:PROMPT][:SIMPLE] = {
    PROMPT_I: ">> ",
    PROMPT_S: ".. ",
    PROMPT_C: "?  ",
    RETURN: "     ==> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :SIMPLE
end
