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

    vendor/bin/behat --init --suite=app_suite
    
Vous devriez avoir d'affiché

    +d src/AppBundle/Features - place your *.feature files here
    +d features/bootstrap/AppBundle/Features/Context - place your context classes here
    +f features/bootstrap/AppBundle/Features/Context/FeatureContext.php - place your definitions, transformations and hooks here

Ensuite lancez la commande 
    
    vendor/bin/behat
    
La console vous affichera

    Pas de scénario
    Pas d'étape
    0m0.00s (12.52Mb)

Création de Scénarios
---------------------

Dans le dossier du bundle AppBundle/Features se trouvera tout vos fichiers *.feature, ils servent à créer des scénarios
afin de faire les tests fonctionnels

Pour notre exemple nous allons créer un fichier commande.feature dont le contenu est le suivant :

    Feature: Commande
        Scenario: Running greeting command
            When I run"php app/console app:greeting"
            Then I should see "Hello World"
            
Cela fait, lancer la commande
    
    vendor/bin/behat
    
Vous devriez avoir d'affiché 

    Feature: Commande
        
      Scenario: Running greeting command         # src/AppBundle/Features/commande.feature:2
        When I run"php app/console app:greeting"
        Then I should see "Hello World"
            
    1 scénario (1 indéfinis)
    2 étapes (2 indéfinis)
    0m0.02s (15.53Mb)
        
     >> app_suite suite has undefined steps. Please choose the context to generate snippets:
         
      [0] None
      [1] AppBundle\Features\Context\FeatureContext
      >
      
Appuyez sur enter, et le terminal vous affiche les étapes manquantes pour effectuer les scénarios

    /**
     * @When I run"php app\/console app:greeting"
     */
    public function iRunPhpAppConsoleAppGreeting()
    {
        throw new PendingException();
    }
        
    /**
     * @Then I should see :arg1
     */
    public function iShouldSee($arg1)
    {
        throw new PendingException();
    }
