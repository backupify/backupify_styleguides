module BackupifyStyleguides
  module Hooks
    class PreCommit
      class << self
        def file
          '.git/hooks/pre-commit'
        end

        def install_hook
          File.open(file, 'a') do |f|
            f.puts <<-EOF
#{sentinel}
require 'backupify_styleguides'
BackupifyStyleguides::Hooks::PreCommit.run
#{sentinel}
            EOF
          end
        end

        def remove_hook
          lines = File.read(file)
          out = lines.gsub(/#{sentinel}.*#{sentinel}\n/m, '')
          File.open(file, 'w') { |f| f.puts out }
        end

        def sentinel
          '# BACKUPIFY_STYLEGUIDES_SENTINEL'
        end
      end
    end
  end
end
