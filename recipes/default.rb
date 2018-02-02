package 'apache2'
service 'apache2' do
  action :nothing
end

bash 'overrride install php7.2' do
  code <<-EOH
    apt install python-software-properties
    add-apt-repository ppa:ondrej/php

    apt update
    apt-get purge php5-fpm 
    apt-get --purge autoremove

    apt install php7.2-fpm php7.2-mysql php7.2 php7.2-json php7.2-curl libapache2-mod-php7.2 php7.2-opcache php7.2-xml php7.2-gd php7.2-bz2 php7.2-mbstring libpcre3
    service apache2 restart
  EOH
  notifies :restart, "service[apache2]"
  not_if "which php7.2"
end
