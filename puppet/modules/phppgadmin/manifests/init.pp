class phppgadmin
{
    package 
    { 
        "phppgadmin":
            ensure  => present,
            require => [
                Exec['apt-get update'],
                Package["php5", "php5-pgsql", "apache2"],
            ]
    }
}
