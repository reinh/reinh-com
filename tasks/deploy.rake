
require 'rake/contrib/sshpublisher'

task :staging do
  SITE.remote_dir = "/var/www/beta.reinh.com"
end

task :production do
  SITE.remote_dir = "/var/www/reinh.com"
end

namespace :deploy do
  SITE.user       = "www"
  SITE.host       = "reinh.com"
  # SITE.remote_dir = "/var/www/beta.reinh.com"
  SITE.remote_dir = "/var/www/reinh.com"
  SITE.rsync_args = %w( -av --delete )

  desc 'Deploy to the server using rsync'
  task :rsync do
    cmd = "rsync #{SITE.rsync_args.join(' ')} "
    cmd << "#{SITE.output_dir}/ #{SITE.user}@#{SITE.host}:#{SITE.remote_dir}"
    sh cmd
  end

  desc 'Deploy to the server using ssh'
  task :ssh do
    Rake::SshDirPublisher.new(
        "#{SITE.user}@#{SITE.host}", SITE.remote_dir, SITE.output_dir
    ).upload
  end

end  # deploy

# EOF
