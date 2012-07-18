require 'socket'

@force = false

Mappings = {
  :global => {
    'bash_aliases'     =>  '~/.bash_aliases',
    'bash_profile'     =>  '~/.bash_profile',
    'bashrc'           =>  '~/.bashrc',
    'gemrc'            =>  '~/.gemrc',
    'gitconfig'        =>  '~/.gitconfig',
    'rake'             =>  '~/.rake',
    'rspec'            =>  '~/.rspec',
    'tmux.conf'        =>  '~/.tmux.conf',
    'vim'              =>  '~/.vim',
    'vim/vimrc'        =>  '~/.vimrc',
    'Xdefaults'        =>  '~/.Xdefaults',
    'zshrc'            =>  '~/.zshrc',
    'zsh'              =>  '~/.zsh'
  }
}

def link_file(src, tgt)
  src = "#{pwd}/files/#{src}"
  tgt = File.expand_path tgt
  rm_rf tgt if @force
  ln_s src, tgt
rescue
  STDERR.puts "Couldn't link #{src} to #{tgt}. Use `rake force` to overwrite."
end

def link_all_files
  Mappings[:global].each do |src,tgt|
    link_file src, tgt
  end
  host_mapping = Mappings[Socket.gethostname.to_sym]
  host_mapping.each do |src,tgt|
    link_file src, tgt
  end unless host_mapping.nil?
end

desc 'Same as install, but overwrites any existing files.'
task :force do
  @force = true
  Rake::Task[:install].invoke
end 

desc 'Symlink config files to appopriate locations.'
task :install do
  link_all_files
end

desc 'Pull the latest changes from Git and update all submodules'
task :update do
  `git submodule update --init --recursive`
  `git pull --recurse-submodules`
end

task :default do
  puts `rake --tasks`
end
