AdminUser.find_or_create_by!(email: ENV.fetch('ADMIN_EMAIL','admin@talaa.local')) do |a|
  a.password = ENV.fetch('ADMIN_PASSWORD','changeme123')
end
