Documentation BeHat
========================

La première partie du README.md concerne l'installation et la configuration sur une instance Symfony2, 
la seconde concerne ce dépôt, et la dernière sera pour ine installation plus générale

Installation
------------

    composer require behat/behat

Configuration
-------------

Créez un fichier **behat.yml** à la racine du projet (au même niveau que composer.json) 

    default:
        suites:
            app_suite:
                type: symfony_bundle
                bundle: AppBundle
                
**/!\ Attention ceci est une configuration de BASE !**
Pour plus d'information vous pouvez aller voir : http://docs.behat.org/en/v2.5/guides/7.config.html

Lancez la commande

    bin/behat -init -suite=app_suite