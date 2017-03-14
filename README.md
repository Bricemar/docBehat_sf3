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
            When I run "php bin/console app:greeting"
            Then I should see "Hello World"
            
Cela fait, lancer la commande
    
    vendor/bin/behat
    
Vous devriez avoir d'affiché 

    Feature: Commande
        
      Scenario: Running greeting command         # src/AppBundle/Features/commande.feature:2
        When I run "php bin/console app:greeting"
        Then I should see "Hello World"
            
    1 scénario (1 indéfinis)
    2 étapes (2 indéfinis)
    0m0.02s (15.53Mb)
        
     >> app_suite suite has undefined steps. Please choose the context to generate snippets:
         
      [0] None
      [1] AppBundle\Features\Context\FeatureContext
      >
 
On nous dit qu'il y a des étapes non définies, il suffit d'appuyer sur enter 
et le terminal vous affiche les étapes manquantes pour effectuer le scénario

    /**
     * @When I run "php bin\/console app:greeting"
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

Il vous suffit de les copier et coller dans AppBundle/Features/Context/FeatureContext.php 
et d'adapter le code celon ce que doit faire le scénario :

    namespace AppBundle\Features\Context;
        
    use Behat\Behat\Context\Context;
    use Behat\Behat\Tester\Exception\PendingException;
    use Behat\Gherkin\Node\PyStringNode;
    use Behat\Gherkin\Node\TableNode;
    use Behat\Symfony2Extension\Context\KernelAwareContext;
    use Symfony\Component\HttpKernel\KernelInterface;
        
    /**
     * Defines application features from the specific context.
     */
    class FeatureContext implements Context, KernelAwareContext
    {
        private $kernel;
        private $cmdOut = '';
        
        /**
         * Initializes context.
         *
         * Every scenario gets its own context instance.
         * You can also pass arbitrary arguments to the
         * context constructor through behat.yml.
         */
        public function __construct()
        {
        }
            
        /**
         * @When I run :arg1
         */
        public function iRunPhpAppConsoleAppGreeting($arg1)
        {
            $this->cmdOut = shell_exec($arg1);
        }
            
        /**
         * @Then I should see :arg1
         */
        public function iShouldSee($arg1)
        {
            if($this->cmdOut !== $arg1){sprintf("Could not see ".$arg1);}
        }
            
        /**
         * Sets Kernel instance.
         *
         * @param KernelInterface $kernel
         */
        public function setKernel(KernelInterface $kernel)
        {
            $this->kernel = $kernel;
        }
            
        /**
         * Get Kernel instance.
         *
         * @return KernelInterface
         */
        public function getKernel() {
            return $this->kernel;
        }
    }
    
Et bien sûr il faut créer la commande app:greeting dans AppBundle/Command/Greeting.php

    namespace AppBundle\Command;
        
    use Symfony\Component\Console\Command\Command;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;
        
    class HelloCommand extends Command
    {
        protected function configure()
        {
            $this->setName('app:greeting');
        }
        protected function execute(InputInterface $input, OutputInterface $output)
        {
            $output->writeln('Hello World');
        }
    }
    
Relancez une dernière fois la commande

    /vendor/bin/behat
    
Et vous devriez avoir

    Feature: Commande
        
      Scenario: Running greeting command          # src/AppBundle/Features/commande.feature:2
        When I run "php bin/console app:greeting" # AppBundle\Features\Context\FeatureContext::iRun()
        Then I should see "Hello World"           # AppBundle\Features\Context\FeatureContext::iShouldSee()
            
    1 scénario (1 succès)
    2 étapes (2 succès)
    0m0.11s (15.63Mb)