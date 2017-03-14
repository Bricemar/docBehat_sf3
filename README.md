Documentation BeHat Symfony3
========================

Installation
------------

    composer require behat/symfony2-extension

Configuration
-------------

Créez un fichier **behat.yml** à la racine du projet (au même niveau que composer.json) 

    default:
        extensions:
                Behat\Symfony2Extension: ~
        suites:
            app_suite:
                type: symfony_bundle
                bundle: AppBundle
                
**/!\ Attention ceci est une configuration de BASE !**
Pour plus d'information vous pouvez aller voir : http://docs.behat.org/en/v2.5/guides/7.config.html

Lancez la commande

    vendor/bin/behat -init -suite=app_suite